import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:prestige/view/homeScreen/dashboard.dart';

// ignore: must_be_immutable
class Alldonescreen extends StatefulWidget {
  dynamic value;
   Alldonescreen({required this.value, super.key});

  @override
  State<Alldonescreen> createState() => _AlldonescreenState();
}

class _AlldonescreenState extends State<Alldonescreen> {
  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print("AllDone: ${widget.value}");
    // }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
                child: SvgPicture.asset(
              svg_done,
              height: MediaQuery.of(context).size.height * 0.1,
            )).paddingTop(spacing_thirty),
            text(Alldone_Alldone, fontSize: textSizeLarge).paddingTop(spacing_middle),
            text(Alldone_Prestige, fontSize: textSizeLargeMedium).paddingTop(spacingBig),
            text(Alldone_save,
                    isLongText: true, isCentered: true, fontSize: textSizeLarge)
                .paddingTop(spacing_twinty),
            text(Alldone_yourprestige, fontSize:textSizeLargeMedium).paddingTop(spacingBig),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: textGreenColor),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(0, 4),
                        blurRadius: 24)
                  ]),
              child: text(widget.value["prestigeNumber"].toString()),
            ).paddingTop(spacing_large),
            elevatedButton(
              context,
              onPress: () {
                const LoginScreen().launch(context,isNewTask: true);
              },
              child: text("Continue", color: white),
            ).paddingTop(spacingBig),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
