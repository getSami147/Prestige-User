import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';

// ignore: must_be_immutable
class ErrorScreen extends StatefulWidget {
  ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              errorImage,
              fit: BoxFit.cover,
            )).paddingTop(spacing_thirty),
            text("Error!", fontSize: 35.0,fontWeight: FontWeight.w600).paddingTop(spacing_standard_new),
            text("Something Went Wrong.\nPlease Try Again",color: textGreyColor,
                    maxLine: 5, isCentered: true, fontSize: textSizeLargeMedium)
                .paddingTop(spacing_standard),
            elevatedButton(
              context,
              backgroundColor: Colors.red,
              bodersideColor: Colors.red,
              onPress: () {},
              child: text("Try Again", color: white),
            ).paddingTop(spacingBig),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }
}
