import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Colors.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/widget.dart';

// ignore: must_be_immutable
class DraweTile extends StatelessWidget {
  // IconData? iconA;
  String? imagename;
  String? textName;
  VoidCallback? onTap;

  DraweTile(
      {Key? key,
      required this.imagename,
      required this.textName,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                imagename.toString(),
                height: 25,
                width: 25,
                color: colorPrimary,
                fit: BoxFit.contain,
              ),
              text(textName, fontFamily: 'Poppins')
                  .paddingLeft(spacing_standard_new),
            ],
          ).paddingTop(spacing_standard_new),
          // const Divider().paddingTop(spacing_middle)
        ],
      ).paddingTop(spacing_standard),
    );
  }
}
//homescreen custom
class offerContiner extends StatelessWidget {
  String? text1, image;
  var size;
  VoidCallback? ontap;
  double? heigth, width;
  Color? color, color1;
  bool show;
  AlignmentGeometry alig;
  offerContiner({
    this.ontap,
    required this.alig,
    this.show = false,
    this.color,
    this.color1,
    this.heigth,
    this.width,
    this.size,
    this.image,
    this.text1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(33)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            show == true
                ? Image.asset(
                    image.toString(),
                    height: 15,
                  ).paddingRight(10)
                : const SizedBox(),
           
            Align(
              alignment: alig,
              child: text(text1,
                      fontWeight: FontWeight.w700,
                      color: color1,
                      fontSize: size)
                  .paddingLeft(5),
            ),
          ],
        ).paddingAll(spacing_middle),
      ),
    );
  }
}
