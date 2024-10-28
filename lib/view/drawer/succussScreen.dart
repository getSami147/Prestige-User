import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';

// ignore: must_be_immutable
class SuccussScreen extends StatefulWidget {
 const SuccussScreen({super.key});

  @override
  State<SuccussScreen> createState() => _SuccussScreenState();
}

class _SuccussScreenState extends State<SuccussScreen> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBarWidget("Payment Successful",elevation: 0,showBack: false),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              sucussDone,
              height:orientation==Orientation.portrait? size.height*.25:size.width*.15,
              fit: BoxFit.cover,
            )).paddingTop(spacing_thirty),
            // text("Successful!", fontSize: 25.0).paddingTop(spacing_middle),
            text("Your payment is successfully done",color: textGreyColor,
                    maxLine: 5, isCentered: true, fontSize: textSizeLargeMedium)
                .paddingTop(spacing_standard),
            elevatedButton(
              context,
              onPress: () {},
              child: text("Done", color: white),
            ).paddingTop(spacingBig),
          ],
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }
}
