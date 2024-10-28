
// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/view/drawer/FAQsScreen.dart';
import 'package:prestige/view/drawer/notifications/notificationScreen.dart';
import 'package:prestige/view/drawer/termsAndUses.dart';
import 'package:prestige/view/profile/updateProfileScreen.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';

import 'package:prestige/viewModel/authViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  var index = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  // final emailFouseNode = FocusNode();
  final nameFouseNode = FocusNode();
  final emailFouseNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    nameController.text = userViewModel.name.toString();
    emailController.text = userViewModel.userEmail.toString();
    return Scaffold(
      backgroundColor: white,
      appBar: appBarWidget("Profile", color: white, elevation: 0,),
      body: Center(
        child: FutureBuilder(
          future: AuthViewModel().getMeApi(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomLoadingIndicator());
            } else if (snapshot.hasError) {
              return Center(child: text(snapshot.error.toString()));
            } else {
              var data = snapshot.data["me"];
              // print(data);
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (data["image"] == null ||
                            data["image"].isEmpty ||
                            !data["image"].toString().startsWith('http'))
                        ?  Center(
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: colorPrimary,
                                child: ClipOval(
                                    child: Image.asset(
                                  profileimage,
                                  height: size.width * .20,
                                  width: size.width * .20,
                                  fit: BoxFit.cover,
                                )),
                              ),
                            )
                          : Center(
                              child: CircleAvatar(
                                radius: size.width * .14,
                                backgroundColor: colorPrimary,
                                child: ClipOval(
                                    child: Image.network(
                                  data["image"].toString(),
                                  height: size.width * .24,
                                  width: size.width * .24,
                                  fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProfile,
                          height: size.width * .24,
                          width: size.width * .24,
                          fit: BoxFit.cover,
                         );
                        },
                                )),
                              ),
                            ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: orientation == Orientation.portrait
                              ? spacing_twinty
                              : spacing_standard),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text(data["name"].toString(),
                              fontSize: textSizeNormal,
                              fontWeight: FontWeight.w700),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: colorPrimary.withOpacity(.2),
                            child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () {
                                  const UpdateProfileScreen().launch(context,
                                      pageRouteAnimation:
                                          PageRouteAnimation.Fade);
                                },
                                icon: SvgPicture.asset(
                                  svg_edit,
                                  color: colorPrimary,
                                  height: 15,
                                  width: 15,
                                )),
                          ).paddingLeft(10),
                        ],
                      ),
                    ),
                    TabBar(
                      dividerHeight: 0,
                      onTap: (value) {
                        index = value;
                      },
                      unselectedLabelColor: colorPrimary,
                      labelColor: white,
                      controller: controller,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [colorPrimary, colorPrimary]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      tabs: [
                        const Tab(text: "Dashboard")
                            .paddingSymmetric(horizontal: spacing_twinty),
                        const Tab(text: "Profile ").paddingSymmetric(
                            horizontal: spacing_twinty, vertical: 0),
                      ],
                    ).paddingSymmetric(vertical: spacing_thirty, horizontal: 0),
                    Expanded(
                        child: TabBarView(
                          
                            physics: const BouncingScrollPhysics(),
                            controller: controller,
                            children: [
                          FutureBuilder(
                            future: HomeViewModel().getUserDashboard(context),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshotUser) {
                              if (snapshotUser.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CustomLoadingIndicator());
                              } else if (snapshotUser.hasError) {
                                return Center(
                                    child: Text(snapshotUser.error.toString()));
                              } else if (!snapshotUser.hasData ||
                                  snapshotUser.data == null) {
                                return const Center(child: Text("No data available"));
                              } else if (snapshotUser.data["data"] == null ||
                                  snapshotUser.data["data"].isEmpty) {
                                return const Center(child: Text("No Dashboard Data"));
                              } else {
                                var data = snapshotUser.data["data"];
                                print(snapshot.data);
                                // data["currentPoint"]=2292929.022200;
                                // Dashboard............................>>>
                                return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Overview",
                                        style: TextStyle(
                                          fontSize: textSizeNormal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: spacing_middle),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OverViewContainer(
                                            orientation: orientation,
                                            upperIcon: coin2,
                                            upperTitleText: "Prestige+ Points",
                                            
                                            lowerTitleText:ammoutFormatter((userViewModel.prestigePoint is double ? userViewModel.prestigePoint : double.tryParse(userViewModel.prestigePoint.toString()))?.toInt() ?? 0)
                                          ),
                                          OverViewContainer(
                                            orientation: orientation,
                                            upperIcon: earnCoins,
                                            lowerTitleText: ammoutFormatter((data["earnedPoints"] is double ? data["earnedPoints"] : double.tryParse(data["earnedPoints"].toString()))?.toInt() ?? 0)
,
                                            upperTitleText:
                                                "Earned Prestige+ Points",
                                            
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: spacing_middle),
                                      const SizedBox(height: spacing_middle),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OverViewContainer(
                                            orientation: orientation,
                                            upperIcon: spandCoins,
                                            upperTitleText:
                                                "Spent Prestige+ Points",
                                            lowerTitleText: ammoutFormatter((data["spentPoints"] is double ? data["spentPoints"] : double.tryParse(data["spentPoints"].toString()))?.toInt() ?? 0)
                                        
                                             
                                          ),
                                          OverViewContainer(
                                            orientation: orientation,
                                            upperIcon: orderBag,
                                            upperTitleText: "Total Orders",
                                            lowerTitleText: snapshotUser
                                                    .data["orderCount"]
                                                    ?.toString() ??
                                                '0',
                                          ),
                                        ],
                                      ).paddingSymmetric(
                                          horizontal: spacing_middle),
                                    ],
                                  ).paddingTop(spacing_twinty),
                                );
                              }
                            },
                          ),

                          // Profile............................>>>>
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text("Personal Details",
                                        fontSize: textSizeLargeMedium,
                                        fontWeight: FontWeight.w600)
                                    .paddingTop(spacing_thirty),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 24,
                                            offset: const Offset(0, 4),
                                            spreadRadius: 0,
                                            color: const Color(0xff333333)
                                                .withOpacity(.10))
                                      ]),
                                  child: Column(
                                    children: [
                                      ProfileDetailContainer(
                                        leadingIcon: svg_phone,
                                        title: "Mobile Number",
                                        subtitle: data["contact"].toString(),
                                      ),
                                      ProfileDetailContainer(
                                        leadingIcon: svg_email,
                                        title: "Email",
                                        subtitle: data["email"].toString(),
                                      ),
                                      ProfileDetailContainer(
                                        leadingIcon: drawer_ic_profile,
                                        title: "Role",
                                        subtitle: data["role"].toString(),
                                      ),
                                      
                                      ProfileDetailContainer(
                                        leadingIcon: svg_location,
                                        title: "Location",
                                        subtitle: "${data["statesName"].toString()}, ${data["LGA"].toString()}, ${data["countryName"].toString()}",
                                      ),
                                     
                                    ],
                                  )
                                      .paddingSymmetric(
                                          horizontal: spacing_standard_new)
                                      .paddingOnly(
                                          bottom: spacing_standard_new),
                                ).paddingTop(spacing_middle),
                              
                                ProfileDetailContainer(
                                  ontap: () {
                                    const TermsAndUses().launch(context,
                                        pageRouteAnimation:
                                            PageRouteAnimation.Fade);
                                  },
                                  isContainer: true,
                                  leadingIcon: drawer_ic_termsCondition,
                                  title: "Terms & Conditions",
                                ).paddingTop(spacing_standard_new),
                                ProfileDetailContainer(
                                  ontap: () {
                                    const FAQsScreen().launch(context,
                                        pageRouteAnimation:
                                            PageRouteAnimation.Fade);
                                  },
                                  isContainer: true,
                                  leadingIcon: drawer_ic_helpFAQs,
                                  title: "Help & Support",
                                ).paddingTop(spacing_standard_new),
                                const SizedBox(
                                  height: spacing_thirty,
                                ),
                              ],
                            ),
                          )
                        ]))
                  ],
                ),
              );
            }
          },
        ),
      ).paddingSymmetric(horizontal: spacing_standard_new),
    );
  }
}

class OverViewContainer extends StatelessWidget {
  var upperIcon;
  var upperTitleText;
  var lowerTitleText;
  OverViewContainer({
    super.key,
    this.upperIcon,
    this.upperTitleText,
    this.lowerTitleText,
    required this.orientation,
  });

  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                  color: const Color(0xff252525).withOpacity(.1))
            ]),
        alignment: Alignment.center,
        height: orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.2
            : MediaQuery.of(context).size.width * 0.15,
        width: orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width * 0.42
            : MediaQuery.of(context).size.width * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    upperIcon,
                    height: 25,
                    width: 25,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: spacing_middle,
                  ),
                  Expanded(
                    child: text(
                      upperTitleText,overflow: TextOverflow.ellipsis,
                      maxLine: 2,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: spacing_standard_new),
            ),
            const DottedLine(
              direction: Axis.horizontal,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: colorPrimary,
            ),
            Expanded(
              child: Center(
                child: text(
                  lowerTitleText,
                  fontSize: textSizeNormal, fontWeight: FontWeight.w600
                ).paddingSymmetric(horizontal: spacing_standard_new),
              ),
            ),
          ],
        ));
  }
}

class ProfileDetailContainer extends StatelessWidget {
  String? leadingIcon;
  String? title;
  String? subtitle;
  bool isContainer = false;
  VoidCallback? ontap;
  ProfileDetailContainer(
      {super.key,
      this.leadingIcon,
      this.ontap,
      this.title,
      this.subtitle,
      this.isContainer = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: isContainer == true
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                    BoxShadow(
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        color: const Color(0xff333333).withOpacity(.10))
                  ])
            : const BoxDecoration(),
        child: Padding(
          padding: isContainer == true
              ? const EdgeInsets.symmetric(
                  horizontal: spacing_standard_new, vertical: spacing_middle)
              : const EdgeInsets.only(top: spacing_standard_new),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: colorPrimary.withOpacity(.2),
                child: IconButton(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      leadingIcon.toString(),
                      color: colorPrimary,
                      height: 18,
                      width: 18,
                    )),
              ),
              isContainer == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: spacing_middle),
                      child: text(title.toString(),
                          fontSize: textSizeLargeMedium, fontWeight: FontWeight.w600),
                         
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(title.toString(),
                            color: textGreyColor,
                            fontWeight: FontWeight.w500),
                        text(subtitle.toString(),
                            fontSize: textSizeLargeMedium,
                            fontWeight: FontWeight.w500),
                      ],
                    ).paddingLeft(spacing_middle)
            ],
          ),
        ),
      ),
    );
  }
}
