import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/authViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final nameController = TextEditingController();
  final contectController = TextEditingController();
  // final emailFouseNode = FocusNode();
  final nameFouseNode = FocusNode();
  final contectFouseNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    DateTime? picked;
    Future<void> selectDate(BuildContext context) async {
      var userViewModel = Provider.of<UserViewModel>(context, listen: false);
      picked = await showDatePicker(
          helpText: 'Set your Date of Birth',
          cancelText: 'Cancel',
          confirmText: "Conform",
          fieldLabelText: 'Booking Date',
          fieldHintText: 'Month/Date/Year',
          errorFormatText: 'Enter valid date',
          errorInvalidText: 'Enter date in valid range',
          context: context,
          initialDate: userViewModel.selectedDate,
          firstDate: DateTime(1960, 1),
          lastDate: DateTime.now());
      if (picked != null && picked != userViewModel.selectedDate) {
        userViewModel.setSelectedDate(picked!);
      }
    }

    final formkey = GlobalKey<FormState>();
    var size = MediaQuery.sizeOf(context);
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    nameController.text = userViewModel.name.toString();
    contectController.text = userViewModel.contact.toString();
    userViewModel.switchValue = userViewModel.membership ?? false;

    DateTime dateTime =
        DateTime.parse(userViewModel.userDateOfBirth.toString()).toUtc();
// print(dateTime);
    userViewModel.selectedDate = dateTime;
    // = userViewModel.userDateOfBirth;
    return Scaffold(
      backgroundColor: white,
      appBar: appBarWidget(
        "Edit Profile",
        color: white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: AuthViewModel().getMeApi(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingIndicator());
          } else if (snapshot.hasError) {
            return Center(child: text(snapshot.error.toString()));
          } else {
            var data = snapshot.data["me"];
            // print(data);
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<UserViewModel>(
                      builder: (BuildContext context, value, Widget? child) =>
                          Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: size.width * .14,
                            backgroundColor: colorPrimary,
                            child: value.image == null
                                ? (data["image"] == null ||
                                        ["image"].isEmpty ||
                                        !data["image"]
                                            .toString()
                                            .startsWith('http')
                                    ? ClipOval(
                                        child: Image.asset(
                                          profileimage,
                                          height: size.width * .24,
                                          width: size.width * .24,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          data["image"].toString(),
                                          height: size.width * .24,
                                          width: size.width * .24,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              placeholderProfile,
                                              height: size.width * .24,
                                              width: size.width * .24,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ))
                                : ClipOval(
                                    child: Image.file(
                                      File(value.image!.path).absolute,
                                      height: size.width * .20,
                                      width: size.width * .20,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ).paddingTop(spacing_twinty),
                          Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: colorPrimary, shape: BoxShape.circle),
                              child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () {
                                  value.getImages();
                                },
                                icon: const Icon(Icons.edit_outlined),
                                color: whiteColor,
                                iconSize: 15,
                              ))
                        ],
                      ).center(),
                    ),

                    text("Name", fontSize: textSizeSMedium)
                        .paddingTop(spacing_middle),
                    CustomTextFormField(
                      context,
                      controller: nameController,
                      focusNode: nameFouseNode,
                      onFieldSubmitted: (value) {
                        utils().formFocusChange(
                            context, nameFouseNode, contectFouseNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      hintText: "Name",
                    ).paddingTop(spacing_middle),
                    // text(
                    //   LogIn_Email,
                    //   googleFonts: GoogleFonts.lato(
                    //     fontSize: textSizeSMedium,
                    //   ),
                    // ).paddingTop(spacing_middle),
                    // textformfield(
                    //   controller: contectController,
                    //   focusNode: contectFouseNode,
                    //   // onFieldSubmitted: (value) {
                    //   //   utils().formFocusChange(
                    //   //       context, emailFouseNode, passwordFouseNode);
                    //   // },
                    //   keyboardType: TextInputType.emailAddress,
                    //   obscureText: false,
                    //   hinttext: "Please enter email",
                    // ).paddingTop(spacing_middle),

                    text(
                      fontSize: textSizeSMedium,
                      "Contect Number",
                    ).paddingTop(spacing_middle),
                    CustomTextFormField(
                      context,
                      controller: contectController,
                      focusNode: contectFouseNode,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contect number';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        // utils().formFocusChange(
                        //     context, contectFouseNode, passwordFouseNode);
                      },
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      hintText: "Contect Number",
                    ).paddingTop(spacing_middle),
                    text(
                      fontSize: textSizeSMedium,
                      SignUp_DOB,
                    ).paddingTop(spacing_middle),
                    Consumer<UserViewModel>(
                      builder: (context, pickDate, child) {
                        return CustomTextFormField(
                          context,
                          suffixIcon: IconButton(
                              onPressed: () {
                                selectDate(context);
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: colorPrimary,
                              )),
                          validator: (value) {
                            if (userViewModel.selectedDate == null ||
                                userViewModel.selectedDate == '') {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          // controller: emailController,
                          // focusNode: emailFouseNode,
                          // onFieldSubmitted: (value) {
                          //   utils().formFocusChange(
                          //       context, emailFouseNode, passwordFouseNode);
                          // },

                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hintText:
                              DateFormat.yMd().format(pickDate.selectedDate),
                        ).paddingTop(spacing_middle);
                      },
                    ),
                    Consumer<UserViewModel>(builder: (context, switchState, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text("Membership",
                              fontSize: textSizeMedium,
                              fontWeight: FontWeight.w500),
                          CupertinoSwitch(
                            activeColor: colorPrimary,
                            value: switchState.switchValue,
                            onChanged: (newValue) {
                              switchState.toggleSwitch(newValue);
                            },
                          ),
                        ],
                      );
                    }).paddingTop(spacing_twinty),
                    Consumer<UserViewModel>(
                      builder: (context, value, child) =>
                          elevatedButton(context, onPress: () {
                        if (formkey.currentState!.validate()) {
                          var data = {
                            "name": nameController.text.toString(),
                            "DOB": userViewModel.selectedDate.toString(),
                            "contact": contectController.text.toString(),
                            "Membership": value.switchValue.toString(),
                          };
                          AuthViewModel().updateMeformData(data, context);
                        }
                      },
                              child: text("Update Profile",
                                  fontWeight: FontWeight.w500,
                                  color: color_white)),
                    ).paddingTop(spacing_xxLarge),
                  ],
                ),
              ),
            );
          }
        },
      ).paddingSymmetric(horizontal: spacing_large),
    );
  }
}
