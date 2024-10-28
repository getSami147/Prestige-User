import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // controller
  
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final typeController = TextEditingController();
  final foundUsFromController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    nameController.dispose();
    emailController.dispose();
    typeController.dispose();
    foundUsFromController.dispose();
    descriptionController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserViewModel>(context, listen: false);
  nameController.text= provider.name!;
  emailController.text= provider.userEmail!;
    
final formkey=GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Contact us"),),
      body: SingleChildScrollView(
        child: Form(key: formkey,
          child: Column(
            children: [
              text(
                ContactUs_getIn,
                 fontSize: textSizeXLarge,
                    fontWeight: FontWeight.w700,
                    color: colorPrimary
              ).paddingTop(spacing_twinty),
              text(
                ContactUs_discription,
                maxLine: 5,
                isCentered: true,
                  fontSize: textSizeMedium,
                  fontWeight: FontWeight.w400,
                
              ).paddingTop(spacing_control),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                      ContactUs_Name,
                      fontSize: textSizeMedium,
                        color: blackColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                    ),
                    CustomTextFormField(context,
                      obscureText: false,
                      filledColor: filledColor,
                      controller: nameController,
                     validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                } 
                                return null;
                              },
                    ).paddingTop(spacing_control),
                    text(
                      ContactUs_Email,
                     fontSize: textSizeMedium,
                        color: blackColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                    ).paddingTop(spacing_twinty),
                    CustomTextFormField(context,
                      filledColor: filledColor,
                      controller: emailController,
                      validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the email';
                              } else if (!value.contains("@")) {
                                return "Please enter a validate email";
                              }
          
                              return null;
                            },
                    ).paddingTop(spacing_control),
                     text(
                      "type",
                        fontSize: textSizeMedium,
                        color: blackColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                    ).paddingTop(spacing_twinty),
                    CustomTextFormField(
                      context,hintText: "type",
                      obscureText: false,
                      filledColor: filledColor,
                      controller: typeController,
                      validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please specify the purpose of your contact.';
                                } 
                                return null;
                              },
                    ).paddingTop(spacing_control),
                     text(
                      "Found Us From", fontSize: textSizeMedium,
                        color: blackColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                    ).paddingTop(spacing_twinty),
                    CustomTextFormField(context,
                    hintText:"Found Us From" ,
                      obscureText: false,
                      filledColor: filledColor,
                      controller: foundUsFromController,
                     validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please let us know the platform through which you reached us.';
                                } 
                                return null;
                              },
                    ).paddingTop(spacing_control),
                    text(
                      "Description",
                       fontSize: textSizeMedium,
                        color: blackColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                    ).paddingTop(spacing_twinty),
                    CustomTextFormField(
                      context,hintText: "Description",
                      controller: descriptionController,
                      filledColor: filledColor,
                      maxLines: 5,
                       validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '"Please describe your opinion or problem here."';
                                } 
                                return null;
                              },
                    ).paddingTop(spacing_control),
                    Consumer<HomeViewModel>(
                      builder: (context, value, child) => elevatedButton(context,
                          onPress: () {
                              if (formkey.currentState!.validate()) {
                         Map<String, String> data = {
                          "name": nameController.text.toString().trim(),
                          "email": emailController.text.toString().trim(),
                          "type": typeController.text.toString().trim(),
                          "foundUsFrom": foundUsFromController.text.toString().trim(),
                          "description":descriptionController.text.toString().trim()
                        };
                          HomeViewModel().contectUsPostAPI(data, context);
                        
                      }
                          },
                          child: text(ContactUs_Submit,
                               fontWeight: FontWeight.w500,
                                  fontSize: textSizeLargeMedium,
                                  color: color_white)),
                    ).paddingTop(spacing_xxLarge)
                  ],
                )
              ).paddingSymmetric(vertical: spacing_thirty)
            ],
          ).paddingSymmetric(horizontal: spacing_twinty),
        ),
      ),
    );
  }
}
