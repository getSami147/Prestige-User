import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/alldone.dart';
import 'package:prestige/view/authView/otpVerification.dart';
import 'package:prestige/viewModel/onbondingmodel.dart';

class VerificationMethod extends StatefulWidget {
  const VerificationMethod({super.key});

  @override
  State<VerificationMethod> createState() => _VerificationMethodState();
}

class _VerificationMethodState extends State<VerificationMethod> {
  var select = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.asset(
            oTP,
            fit: BoxFit.contain,
            height: size.width * .55,
            width: size.width * .55,
          )).paddingTop(spacing_thirty),
          Center(
              child: text(
            verifcationM_Title,
            isCentered: true,
            color: black,
                fontSize: textSizeLarge,
                fontWeight: FontWeight.w700
          )).paddingTop(spacing_middle),
          Center(
              child: text(
            verifcationM_text,
            isCentered: true,
            maxLine: 4,   color: textGreyColor,
              fontSize: textSizeSMedium,
           
          )).paddingTop(spacing_middle),
          text(
              fontSize: textSizeSMedium,
            verifcationM_Method,
            
          ).paddingTop(spacing_middle),
          for (int i = 0; i < otpverficationmodel.length; i++) ...[
            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 24)
                  ]),
              child: ListTile(
                leading:
                    SvgPicture.asset(otpverficationmodel[i].image.toString()),
                title: text(otpverficationmodel[i].text.toString()),
                trailing: Radio(
                  value: otpverficationmodel[i].ratiovalue,
                  groupValue: select,
                  onChanged: (dynamic value) {
                    select = value;
                    setState(() {});
                  },
                ),
              ),
            ).paddingTop(spacing_middle),
          ],
          elevatedButton(
            context,
            onPress: () {
              // const OtpVerification()
              //     .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            },
            child: text(verifcationM_nextstep, color: white),
          ).paddingTop(spacingBig)
        ],
      ).paddingSymmetric(horizontal: spacing_twinty),
    );
  }
}
