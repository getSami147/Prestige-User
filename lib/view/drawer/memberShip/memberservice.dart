import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/categories/categoriesScreen.dart';
import 'package:prestige/view/drawer/transactions/mytransaction.dart';

class Memberservicescreen extends StatefulWidget {
  const Memberservicescreen({super.key});

  @override
  State<Memberservicescreen> createState() => _MemberservicescreenState();
}

class _MemberservicescreenState extends State<Memberservicescreen> {
  List rewardtext = [
    Memberservice_RewardsFAQs,
    Memberservice_Program,
    Memberservice_Terms
  ];
  List reward = [
    Memberservice_Privacy,
    Memberservice_Legal,
  ];
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        title: text(Memberservice_Member,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(Memberservice_How,
                    fontSize: textSizeLargeMedium,
                    fontWeight: FontWeight.w700,
                    color: textGreenColor)
                .paddingTop(20),
            text(Memberservice_Many,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: colorSecondary,
                    isLongText: true)
                .paddingTop(10),
            text(Memberservice_email,
                    fontSize: textSizeSMedium,
                    fontWeight: FontWeight.w400,
                    color: colorPrimary)
                .paddingTop(10),
            Divider(
              color: textGreyColor.withOpacity(0.2),
            ).paddingTop(10),
            text(Memberservice_Rewards,
                    fontSize: textSizeLargeMedium,
                    fontWeight: FontWeight.w700,
                    color: textGreenColor)
                .paddingTop(10),
            for (int i = 0; i < rewardtext.length; i++) ...[
              customcontainerrow(
                color: white,
                size: 18.0,
                orientation: orientation,
                text1: rewardtext[i],
                color1: textGreenColor,
                color2: textGreenColor,
              ),
            ],
            text(Memberservice_Security,
                    fontSize: textSizeMedium,
                    fontWeight: FontWeight.w700,
                    color: textGreenColor)
                .paddingTop(10),
            for (int i = 0; i < reward.length; i++) ...[
              customcontainerrow(
                color: white,
                size: 16.0,
                orientation: orientation,
                text1: reward[i],
                color1: textGreenColor,
                color2: textGreenColor,
              ),
            ],
            elevatedButton(
              context,
              onPress: () {
                CategoriesScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              child: text(Memberservice_Explore, color: white),
            ).paddingTop(spacing_thirty)
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
