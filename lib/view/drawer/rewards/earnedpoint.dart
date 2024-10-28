import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/checkout.dart';
import 'package:prestige/view/homeScreen/dashboard.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class PointsDetailScreen extends StatefulWidget {
  var data;
  bool earnedPoint;
  PointsDetailScreen({this.data, required this.earnedPoint, super.key});

  @override
  State<PointsDetailScreen> createState() => _PointsDetailScreenState();
}

class _PointsDetailScreenState extends State<PointsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var userViewModel=Provider.of<UserViewModel>(context,listen: false);
    if (kDebugMode) {
      print("$Myreward_Order ${widget.data}");
      print("earnedPoint ${widget.earnedPoint}");
    }
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: text(Earnedpoint_Earned,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                EarnedDetailTile(
                  leading: widget.data["shopLogo"].toString(),
                  title: "$Myreward_Order ${widget.data["orderNo"].toString()}",
                  subtitle:
                      "$Myreward_Order ${widget.data["shopName"].toString()}",
                  trailingImage: coin2,
                  trailingText: "N ${ammoutFormatter((widget.data["earnedPoints"] is double ? widget.data["earnedPoints"] : double.tryParse(widget.data["earnedPoints"].toString()))?.toInt() ?? 0)}",
                  trailingText2:
                      " ${widget.earnedPoint == true ? Myreward_add : Myreward_remove} ${widget.earnedPoint == true ? ammoutFormatter((widget.data["earnedPoints"] is double ? widget.data["earnedPoints"] : double.tryParse(widget.data["earnedPoints"].toString()))?.toInt() ?? 0) : ammoutFormatter((widget.data["spentPoints"] is double ? widget.data["spentPoints"] : double.tryParse(widget.data["spentPoints"].toString()))?.toInt() ?? 0)
                      }",
                  trailingcolor:
                      widget.earnedPoint == true ? colorPrimary : Colors.red,
                ),
                Container(
                  alignment: Alignment.center,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.3
                      : MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black.withOpacity(0.06),
                            offset: const Offset(0, 4),
                            blurRadius: 24)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      CustomBillingRow(
                        text0: Ordrdetail_OrderID,
                        text1: widget.data["orderNo"].toString(),
                        titleColor: textGreyColor,
                      ).paddingTop(10),
                      Row(
                        children: [
                          text(Earnedpoint_Date, color: textGreyColor),
                          const Spacer(),
                          text(formatDateTime(widget.data["createdAt"].toString()),
                              fontSize: textSizeSmall, fontWeight: FontWeight.w600),
                          
                        ],
                      ).paddingOnly(left: 10, right: 10, top: 10),
                      CustomBillingRow(
                        text0: Earnedpoint_pay,
                        text1: widget.data["paymentMethod"].toString(),
                        titleColor: textGreyColor,
                        traillingColor: colorPrimary,
                      ).paddingTop(10),
                      CustomBillingRow(
                        text0: Earnedpoint_total,
                        text1: "N ${ammoutFormatter((widget.data["totalAmount"] is double ? widget.data["totalAmount"] : double.tryParse(widget.data["totalAmount"].toString()))?.toInt() ?? 0)}",
                        titleColor: textGreyColor,
                        traillingColor: colorPrimary,
                      ).paddingTop(10),
                      text(Earnedpoint_on,
                              fontSize: textSizeMedium, fontWeight: FontWeight.w600)
                          .paddingTop(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text(
                              widget.earnedPoint == true
                                  ? Earnedpoint_you
                                  : "You spent",
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w600),
                          Image.asset(
                            coin2,
                            height: 15,
                          ).paddingLeft(5),
                          const SizedBox(
                            width: spacing_standard,
                          ),
                          widget.earnedPoint == true
                              ? text(ammoutFormatter((widget.data["earnedPoints"] is double ? widget.data["earnedPoints"] : double.tryParse(widget.data["earnedPoints"].toString()))?.toInt() ?? 0)
                                 , fontSize: textSizeSMedium,
                                  fontWeight: FontWeight.w600,
                                  color: colorPrimary)
                              : text(
                                  ammoutFormatter((widget.data["spentPoints"] is double ? widget.data["spentPoints"] : double.tryParse(widget.data["spentPoints"].toString()))?.toInt() ?? 0)

                                        ,
                                  fontSize: textSizeSMedium,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                          text(Earnedpoint_prestige,
                                  fontSize: textSizeSMedium, fontWeight: FontWeight.w600)
                              .paddingSymmetric(horizontal: spacing_standard),
                        ],
                      )
                    ],
                  ),
                ).paddingTop(20),
              ],
            ).paddingSymmetric(horizontal: 15, vertical: 15),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class EarnedDetailTile extends StatelessWidget {
  String? leading, title, subtitle, trailingText, trailingText2, trailingImage;
  Color? trailingcolor;
  EarnedDetailTile({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailingImage,
    required this.trailingText,
    required this.trailingText2,
    this.trailingcolor = colorPrimary,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
                color: const Color(0xff333333).withOpacity(0.10),
                offset: const Offset(0, 4),
                blurRadius: 24,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                leading.toString(),
                height: size.width * .15,
                width: size.width * .15,
                fit: BoxFit.cover,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(title.toString(),
                 fontSize: textSizeSMedium,
                  fontWeight: FontWeight.w500,
                  isLongText: true),
              const SizedBox(
                height: spacing_middle,
              ),
              text(subtitle.toString(),
                  fontSize: textSizeSmall,
                  fontWeight: FontWeight.w400,
                  color: colorSecondary),
            ],
          ).paddingLeft(10),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                textAlign: TextAlign.end,
                trailingText.toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: trailingcolor),
              ),
              Row(
                children: [
                  Image.asset(
                    trailingImage.toString(),
                    height: 10,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    trailingText2.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: textSizeSmall,
                        fontWeight: FontWeight.w500,
                        color: trailingcolor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: spacing_middle, vertical: spacing_middle),
    ).paddingTop(spacing_standard_new);
  }
}
