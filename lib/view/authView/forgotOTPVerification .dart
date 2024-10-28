// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:prestige/utils/Constant.dart';
// import 'package:prestige/utils/Images.dart';
// import 'package:prestige/utils/colors.dart';
// import 'package:prestige/utils/string.dart';
// import 'package:prestige/utils/widget.dart';
// import 'package:prestige/view/authView/restPassword.dart';
// import 'package:prestige/viewModel/authViewModel.dart';
// import 'package:provider/provider.dart';

// class ForgotOTPVerification extends StatefulWidget {
//   const ForgotOTPVerification({super.key});

//   @override
//   State<ForgotOTPVerification> createState() => _ForgotOTPVerificationState();
// }

// class _ForgotOTPVerificationState extends State<ForgotOTPVerification> {
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.sizeOf(context);

//     var otp;
//     return   Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//                 child: Image.asset(
//               oTP,
//               fit: BoxFit.contain,
//               height: size.width * .55,
//               width: size.width * .55,
//             )).paddingTop(spacing_thirty),
//             Center(
//                 child: text(
//               ForgotOTP_title,
//               isCentered: true,
//                color: black,
//                   fontSize: textSizeLarge,
//                   fontWeight: FontWeight.w700
//             )).paddingTop(spacing_middle),
//             Center(
//                 child: text(
//               OTP_Subtitle,
//               isCentered: true,
//               maxLine: 4,
//                color: textGreyColor,
//                 fontSize: textSizeSMedium,
//             )).paddingTop(spacing_middle),
//             Center(
//               child: text(
//                 "samiuzr@gmail.com",
//                                   fontSize: textSizeSMedium,fontWeight: FontWeight.w600

//               ).paddingTop(spacing_control),
//             ),
//             PinCodeTextField(
//               appContext: context,
//               length: 6,
//               onChanged: (value) {
//                 otp = value;
//                 setState(() {});
//                 if (kDebugMode) {
//                   print("value otp: ${value}");
//                 }
//               },
//               pinTheme: PinTheme(
//                   fieldWidth: 50,
//                   fieldHeight: 50,
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(10),
//                   activeColor: colorPrimary,
//                   inactiveColor: textGreyColor),
//             ).paddingTop(spacing_xxLarge), 
          
//              Consumer<AuthViewModel>(
//                     builder: (context, value, child) => elevatedButton(context,
//                              loading: value.loading,
//                             onPress: () {
//                               ResetPassword().launch(context,pageRouteAnimation: PageRouteAnimation.Fade);
                              
//                             },
//                             child: text(ForgotOTP_ResetPassword,
//                                 fontWeight: FontWeight.w500,
//                                     color: color_white)),
                              
                                    
                        
//                   ).paddingTop(spacing_xxLarge),
//              Center(
//               child: text(
//                 ForgotOTP_Resend,
//                                   fontSize: textSizeSMedium,fontWeight: FontWeight.w600

//               ).paddingTop(spacing_thirty),
//             ),
//              Center(
//               child: text(
//                 "Aailable in 10 seconds",
//                  fontSize: textSizeSmall,
//                   color: colorPrimary
//               ).paddingTop(spacing_control),
//             ),
//           ],
//         ).paddingSymmetric(horizontal: spacing_twinty),
//       ),
//     );
//   ;
//   }
// }