import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/Colors.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/authViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
final formkey=GlobalKey<FormState>();
  final tokenController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final obSecurePassword = ValueNotifier(true);
    final obSecureConfromPassword = ValueNotifier(true);

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    final currentpasswordFouseNode = FocusNode();
    final newPasswordFouseNode = FocusNode();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                forgotPassword,
                fit: BoxFit.contain,
                height: size.width * .55,
                width: size.width * .55,
              )).paddingTop(spacing_thirty),
              Center(
                  child: text(
                Rest_newPassword,
                isCentered: true,
               color: black,
                    fontSize: textSizeLarge,
                    fontWeight: FontWeight.w700
              )).paddingTop(spacing_xxLarge),
              Center(
                  child: text(
                Rest_RestSubtitle,
                isCentered: true,
                maxLine: 4,
                color: textGreyColor,
                  fontSize: textSizeSMedium,
              )).paddingTop(spacing_middle),
              text(
                'Current Password',
              ).paddingTop(spacing_standard_new),
              ValueListenableBuilder(
                valueListenable: obSecurePassword,
                builder: (context, value, child) => CustomTextFormField(context,
                  controller: currentPasswordController,
                  focusNode: currentpasswordFouseNode,
                  obscureText: obSecurePassword.value,
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                            return 'Please enter the current password';
                          } 
                          return null;
                        },
                  
                  suffixIcon: GestureDetector(
                          onTap: () {
                            obSecurePassword.value = !obSecurePassword.value;
                          },
                          child: SvgPicture.asset(obSecurePassword.value
                              ? svg_hidePassword
                              : svg_unHide))
                      .paddingRight(spacing_middle),
                  hintText: 
                  'Current Password',
                ).paddingTop(spacing_middle),
              ),
              text(
                  fontSize: textSizeSMedium,
                Rest_newPassword,
                
              ).paddingTop(spacing_middle),
              ValueListenableBuilder(
                valueListenable: obSecureConfromPassword,
                builder: (context, value, child) => CustomTextFormField(context,
                  controller: newPasswordController,
                  focusNode: newPasswordFouseNode,
                  obscureText: obSecureConfromPassword.value,
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          } 
                          return null;
                        },
                  suffixIcon: GestureDetector(
                          onTap: () {
                            obSecureConfromPassword.value =
                                !obSecureConfromPassword.value;
                          },
                          child: SvgPicture.asset(obSecureConfromPassword.value
                              ? svg_hidePassword
                              : svg_unHide))
                      .paddingRight(spacing_middle),
                  hintText: SignUp2_ConformPassword,
                ).paddingTop(spacing_middle),
              ),
              Consumer<AuthViewModel>(
                builder: (context, value, child) => elevatedButton(context,
                    loading: value.loading, onPress: () {
                      if (formkey.currentState!.validate()) {
                     Map<String, dynamic>data = {
                      "currentPassword": currentPasswordController.text.toString(),
                      "password": newPasswordController.text.toString()
                    };
                    AuthViewModel().changePassword(data, context);
                         }
                },
                    child: text(Rest_RestPassword,
                         fontWeight: FontWeight.w500, color: color_white)),
              ).paddingTop(spacingBig),
            ],
          ).paddingSymmetric(horizontal: spacing_twinty),
        ),
      ),
    );
  }
}
