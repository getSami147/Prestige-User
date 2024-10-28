import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/profile/updateProfileScreen.dart';

class MemberShipAlertBox extends StatelessWidget {

   MemberShipAlertBox({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      insetPadding: const EdgeInsets.symmetric(horizontal: spacing_twinty),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    drawer_ic_helpFAQs,color:redColor,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    height: spacing_twinty,
                  ),
                  text(
                    "Membership",
                    fontWeight: FontWeight.w500,
                    fontSize: textSizeLargeMedium,
                    color: redColor,maxLine: 5,isCentered: true
                  ),
                  const SizedBox(
                    height: spacing_control,
                  ),
                  text(
             "First, you need to activate the\n membership after that, you can proceed\n with the order.",
                    maxLine: 5,isCentered: true
                  ),
                  const SizedBox(
                    height: spacing_control,
                  ),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(bottom: spacing_twinty),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: elevatedButton(
                      context,
                      onPress: () {
                        Navigator.pop(context);
                      },
                      height: 45.0,
                      borderRadius: 25.0,
                      backgroundColor: color_white,
                      bodersideColor: blackColor,
                      child: text("Cancel", fontSize: textSizeSMedium),
                    ),
                  ),
                  const SizedBox(
                    width: spacing_standard_new,
                  ),
                  Expanded(
                    child: elevatedButton(
                      context,
                      onPress: () {
                        const UpdateProfileScreen().launch(context,pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      height: 45.0,
                      borderRadius: 25.0,
                      backgroundColor: dissmisable_RedColor,
                      bodersideColor: dissmisable_RedColor,
                      child: text("Conform",
                          color: color_white, fontSize: textSizeSMedium),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          ],
        ),
      ),
    );
  }
}
