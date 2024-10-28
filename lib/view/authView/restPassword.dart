import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/Colors.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/authViewModel.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final tokenController= TextEditingController();
  final passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
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
              Rest_RestPassword,
              isCentered: true,
              color: black,
                  fontSize: textSizeLarge,
                  fontWeight: FontWeight.w700
            )).paddingTop(spacing_xxLarge),
            Center(
                child: text(
              "Password reset instructions have been sent to Your email, Please Check your email.",
              isCentered: true,
              maxLine: 4, color: textGreyColor,
                fontSize: textSizeSMedium,
              
            )).paddingTop(spacing_middle),
           
            // ValueListenableBuilder(
            //         valueListenable: obSecurePassword,
            //         builder: (context, value, child) => CustomTextFormField(context,
            //           controller: passwordController,
            //           focusNode: passwordFouseNode,
            //           obscureText: obSecurePassword.value,
            //           suffixIcon: GestureDetector(
            //                   onTap: () {
            //                     obSecurePassword.value = !obSecurePassword.value;
            //                   },
            //                   child: SvgPicture.asset(
            //                       obSecurePassword.value ? svg_hidePassword : svg_unHide))
            //               .paddingRight(spacing_middle),
            //           hintText: Rest_newPassword,
            //         ).paddingTop(spacing_middle),
            //       ),
            //       text(
            //     SignUp2_ConformPassword,
            //     googleFonts: GoogleFonts.lato(
            //       fontSize: textSizeSMedium,
            //     ),
            //   ).paddingTop(spacing_middle),
            //        ValueListenableBuilder(
            //         valueListenable: obSecureConfromPassword,
            //         builder: (context, value, child) => CustomTextFormField(context,
            //           controller: conformPasswordController,
            //           focusNode: conformPasswordFouseNode,
            //           obscureText: obSecureConfromPassword.value,
            //           suffixIcon: GestureDetector(
            //                   onTap: () {
            //                     obSecureConfromPassword.value = !obSecureConfromPassword.value;
            //                   },
            //                   child: SvgPicture.asset(
            //                       obSecureConfromPassword.value ? svg_hidePassword : svg_unHide))
            //               .paddingRight(spacing_middle),
            //           hintText: SignUp2_ConformPassword,
            //         ).paddingTop(spacing_middle),
            //       ),
           
             Consumer<AuthViewModel>(
                    builder: (context, value, child) => elevatedButton(context,
                             loading: value.loading,
                            onPress: () {
                              const LoginScreen().launch(context,pageRouteAnimation:PageRouteAnimation.Fade ,isNewTask: true);
                             
                            },
                            child: text("Go back",fontWeight: FontWeight.w500,
                                    color: color_white
                                )),
                                    
                        
                  ).paddingTop(spacingBig),
          
          ],
        )
        .paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
