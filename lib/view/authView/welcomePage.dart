import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/onbondingscreen.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.sizeOf(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 4,
              ),
              Center(
                child: SvgPicture.asset(svg_SplashIcon2, height:size.height * 0.08,width:size.height * 0.08 ,fit: BoxFit.contain,),
              ),
              const Spacer(
                flex: 1,
              ),
              text(welcome_welcome, fontSize: 37.0, ).paddingTop(20),
              Container(
                width: 175,
                height: 2,
                decoration: BoxDecoration(
                    color: dissmisable_RedColor,
                    borderRadius: BorderRadius.circular(3)),
              ),
              text(welcome_welcometext,
                      isLongText: true,
                      fontSize: textSizeSMedium,
                      color: textGreyColor,
                      isCentered: true)
                  .paddingTop(20),
              const Spacer(),
              elevatedButton(
                context,
                onPress: () {
                  const Onbondingscreen().launch(context);
                },
                child: text(welcome_getstart, fontSize: textSizeSMedium, color: color_white),
              ).paddingTop(20),
              const SizedBox(
                height: 20,
              )
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 15),
        )
      ],
    ));
  }
}
