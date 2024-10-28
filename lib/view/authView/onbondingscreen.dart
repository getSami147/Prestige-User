import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:prestige/view/authView/signUp.dart';
import 'package:prestige/viewModel/onbondingmodel.dart';

class Onbondingscreen extends StatefulWidget {
  const Onbondingscreen({super.key});

  @override
  State<Onbondingscreen> createState() => _OnbondingscreenState();
}

class _OnbondingscreenState extends State<Onbondingscreen> {
  var select = 0;
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  svg_SplashIcon2,
                  height:size.height * 0.07,width:size.height * 0.07 ,fit: BoxFit.cover,
                ).paddingTop(size.height*.05),
              ),
              const SizedBox(
                height: spacing_middle,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.52,
                child: PageView.builder(
                  onPageChanged: (value) {
                    select = value;
                    setState(() {});
                  },
                  itemCount: onbondingscreenmodel.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        text(onbondingscreenmodel[index].text.toString(),
                                fontSize: textSizeLargeMedium,
                               fontWeight: FontWeight.w500,isCentered: true,isLongText: true)
                            .paddingLeft(5),
                        const SizedBox(
                          height: 20,
                        ),
                        //Spacer(),
                        Image.asset(
                            onbondingscreenmodel[index].image.toString(),height:size.height*.25 ),
                        text(onbondingscreenmodel[index].text2.toString(),
                              fontWeight: FontWeight.w500,
                            fontSize: textSizeLargeMedium,
                            ),
                        text(onbondingscreenmodel[index].text1.toString(),
                            isLongText: true,
                            isCentered: true,
                            fontSize: textSizeSmall,
                            color: textGreyColor),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < 2; i++) ...[
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 6,
                    width: select == i ? 24 : 6,
                    decoration: BoxDecoration(
                        color:
                            select == i ? textGreenColor : colorSecondary,
                        borderRadius: BorderRadius.circular(8)),
                  )
                ]
              ]),
              elevatedButton(
                context,
                onPress: () {
                  const LoginScreen().launch(context);
                },
                child: text(LogIn_LOGIN, color: white),
              ).paddingTop(size.height*.05),
              elevatedButton(
                backgroundColor: white,
                bodersideColor: textGreyColor,
                context,
                onPress: () {
                  const SignUpScreen().launch(context);
                },
                child: text(
                  onbonding_join_prestige,
                ),
              ).paddingTop(spacing_twinty)
            ],
          ).paddingSymmetric(horizontal: spacing_twinty),
        ),
      ),
    );
  }
}
