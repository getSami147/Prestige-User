import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/drawer/rewards/earnedpoint.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/homeViewModel.dart';

class Myrewardscreen extends StatefulWidget {
  const Myrewardscreen({super.key});

  @override
  State<Myrewardscreen> createState() => _MyrewardscreenState();
}

class _MyrewardscreenState extends State<Myrewardscreen>
    with TickerProviderStateMixin {
  List rewardstetx = [Myreward_Earnedpoints, Myreward_Spentpoints];
  @override
  Widget build(BuildContext context) {
    TabController control = TabController(length: 2, vsync: this);
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: black),
          title: text(Myreward_MyRewards,
              fontSize: textSizeLarge, fontWeight: FontWeight.w700),
        ),
        body: FutureBuilder(
            future: HomeViewModel().getPointHistory(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: const CustomLoadingIndicator()
                        .paddingTop(spacing_middle));
              } else if (snapshot.hasError) {
                return Center(
                        child: text(snapshot.error.toString(),
                            isCentered: true, maxLine: 10))
                    .paddingSymmetric(horizontal: spacing_standard_new);
              } else if (!snapshot.hasData) {
                return Center(child: text("No points Found ", maxLine: 10));
              } else {
                // get By Id ....
                List<dynamic> points = [];
                List<dynamic> earnedPoints = [];
                List<dynamic> spentPoints = [];
                if (snapshot.data['data'] != null &&
                    snapshot.data['data'].isNotEmpty) {
                  points = snapshot.data['data'];
                  earnedPoints = points
                      .where((e) => e['paymentMethod'] != "point")
                      .toList();
                  spentPoints = points
                      .where((e) => e['paymentMethod'] == "point")
                      .toList();
                } else {
                  points = [];
                }

                return Column(
                  children: [
                    DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              dividerHeight: 0,
                                automaticIndicatorColorAdjustment: true,
                                controller: control,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.only(right: 6),
                                labelColor: textGreenColor,
                                unselectedLabelColor: const Color(0xff747688),
                                indicatorColor: textGreenColor,
                                tabs: [
                                  for (int i = 0;
                                      i < rewardstetx.length;
                                      i++) ...[
                                    Tab(
                                      text: rewardstetx[i].toString(),
                                    )
                                  ]
                                ]),
                          ],
                        )).paddingTop(20),
                    Expanded(
                      child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          controller: control,
                          children: [
                            // Earned Point///.......................
                            earnedPoints.isEmpty
                                ? const Center(child: Text("No earned Points"))
                                    .paddingSymmetric(vertical: spacing_twinty)
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: earnedPoints.length,
                                    itemBuilder: (context, index) {
                                      var data = earnedPoints[index];
                                      return InkWell(
                                          onTap: () {
                                            PointsDetailScreen(
                                              data: data,
                                              earnedPoint: true,
                                            ).launch(context,
                                                pageRouteAnimation:
                                                    PageRouteAnimation.Fade);
                                          },
                                          child: RewardTile(
                                            leading:
                                                data["shopLogo"].toString(),
                                            title: data["shopName"].toString(),
                                            subtitle:
                                                "$Myreward_Order ${data["orderNo"].toString()}",
                                            trailingImage: coin2,
                                            trailingText:
                                                "$Myreward_add  ${ammoutFormatter((data["earnedPoints"] is double ? data["earnedPoints"] : double.tryParse(data["earnedPoints"].toString()))?.toInt() ?? 0)}",
                                                
                                            date:
                                            data["createdAt"].toString() ,
                                          ));
                                    },
                                  ),

                            // spent Point///.......................
                            spentPoints.isEmpty
                                ? const Center(child: Text("No Spent Points"))
                                    .paddingSymmetric(vertical: spacing_twinty)
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: spentPoints.length,
                                    itemBuilder: (context, index) {
                                      var data = spentPoints[index];
                                      return InkWell(
                                        onTap: () {
                                          PointsDetailScreen(
                                            data: data,
                                            earnedPoint: false,
                                          ).launch(context,
                                              pageRouteAnimation:
                                                  PageRouteAnimation.Fade);
                                        },
                                        child: RewardTile(
                                          leading: data["shopLogo"].toString(),
                                          title: data["shopName"].toString(),
                                          subtitle:
                                              "$Myreward_Order ${data["orderNo"].toString()}",
                                          trailingImage: coin2,
                                          trailingcolor: Colors.red,
                                          trailingText:
                                              "$Myreward_remove ${ammoutFormatter((data["spentPoints"] is double ? data["spentPoints"] : double.tryParse(data["spentPoints"].toString()))?.toInt() ?? 0)}",
                                          date: data["createdAt"].toString(),
                                        ),
                                      );
                                    },
                                  ),
                          ]).paddingTop(spacing_twinty),
                    )
                  ],
                );
              }
            }));
  }
}

class RewardTile extends StatelessWidget {
  String? leading, title, subtitle, trailingText, trailingImage;
  Color? trailingcolor;
  var date;
  RewardTile({
    super.key,
    required this.leading,
    required this.title,
    required this.date,
    required this.subtitle,
    required this.trailingImage,
    required this.trailingText,
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
                CircleAvatar(
                  radius: size.width * .07,
                  backgroundColor: colorPrimary,
                  child: ClipOval(
                      child: Image.network(
                    leading.toString(),
                    height: size.width * .12,
                    width: size.width * .12,
                    fit: BoxFit.cover,
                  )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(title.toString(),
                       fontSize: textSizeSMedium,
                        fontWeight: FontWeight.w500,
                        isLongText: true),
                    text(DateFormat('dd/ MMMM/ yyyy').format(DateTime.parse(date))
                      ,
                        fontSize: textSizeSmall,
                        isLongText: true),
                    text(subtitle.toString(),
                        fontSize: textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: colorSecondary),
                  ],
                ).paddingLeft(10),
                const Spacer(),
                Image.asset(
                  trailingImage.toString(),
                  height: 20,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    textAlign: TextAlign.end,
                    trailingText.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: textSizeSMedium,
                        fontWeight: FontWeight.w500,
                        color: trailingcolor),
                  ).paddingLeft(spacing_standard),
                ),
              ],
            ).paddingSymmetric(
                horizontal: spacing_standard_new, vertical: spacing_middle))
        .paddingTop(spacing_standard_new)
        .paddingSymmetric(horizontal: spacing_standard_new);
  }
}
