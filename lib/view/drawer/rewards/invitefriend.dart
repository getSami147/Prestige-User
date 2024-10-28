import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/onbondingmodel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class Invitedfriendscreen extends StatefulWidget {
  const Invitedfriendscreen({super.key});

  @override
  State<Invitedfriendscreen> createState() => _InvitedfriendscreenState();
}

class _InvitedfriendscreenState extends State<Invitedfriendscreen>
    with TickerProviderStateMixin {
  List invite1 = [Invitefriend_referal, Invitefriend_invit];
  final invitingController = TextEditingController();
  final invitingFouseNode = FocusNode();
    final formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var size = MediaQuery.sizeOf(context);


    TabController control = TabController(length: 2, vsync: this);
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(Invitefriend_Invite,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
       
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            SingleChildScrollView(
              child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        dividerHeight:0,
                          controller: control,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: const EdgeInsets.only(right: 6),
                          labelColor: Colors.white,
                          unselectedLabelColor: colorPrimary,
                          indicatorColor: Colors.pink,
                          indicator: BoxDecoration(
                            color: textGreenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: [
                            for (int i = 0; i < invite1.length; i++) ...[
                              Tab(
                                text: invite1[i].toString(),
                              )
                            ]
                          ])
                    ],
                  )).paddingTop(20),
            ),
            Expanded(
              child: TabBarView(controller: control, children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      text(Invitefriend_wehave,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: textGreenColor).paddingTop(spacing_twinty),
                      Image.asset(
                        invite,
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.3
                            : MediaQuery.of(context).size.height * 0.8,
                      ).paddingTop(20),
                      text(Invitefriend_refer,
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w500,
                              color: textGreenColor,
                              isLongText: true)
                          .paddingTop(10),
                      Container(
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.16
                            : MediaQuery.of(context).size.height * 0.34,
                        width: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.width * 0.9
                            : MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: textGreyColor.withOpacity(0.5),
                            border: Border.all(color: textGreyColor),
                            borderRadius: BorderRadius.circular(17)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(Invitefriend_yourreferal.toString(),
                                fontSize: textSizeSMedium,
                                fontWeight: FontWeight.w500,
                                color: textGreyColor),
                            InkWell(
                              onTap: () {
                                    copyToClipboard(userViewModel.referralCode.toString());
                                  },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(userViewModel.referralCode.toString(),
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.w700,
                                      color: textGreenColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(
                                    copy,
                                    height: 20,
                                  )
                                ],
                              ).paddingTop(10),
                            ),
                          ],
                        ),
                      ).paddingTop(10),
                      // text(Invitefriend_you,
                      //        fontSize: textSizeSMedium,
                      //         fontWeight: FontWeight.w500,
                      //         color: textGreenColor)
                      //     .paddingTop(10),
                      // Container(
                      //     alignment: Alignment.center,
                      //     height: orientation == Orientation.portrait
                      //         ? MediaQuery.of(context).size.height * 0.1
                      //         : MediaQuery.of(context).size.height * 0.2,
                      //     decoration: BoxDecoration(
                      //         color: white,
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: black.withOpacity(0.06),
                      //               offset: Offset(0, 4),
                      //               blurRadius: 24)
                      //         ],
                      //         borderRadius: BorderRadius.circular(10)),
                      //     child: ListTile(
                      //       leading: Image.asset(
                      //         link.toString(),
                      //         height: 30,
                      //       ),
                      //       title: text(Invitefriend_Invit.toString(),
                      //          fontSize: textSizeSMedium,
                      //           fontWeight: FontWeight.w700,
                      //           isLongText: true),
                      //       subtitle: text(Invitefriend_send.toString(),
                      //           fontSize: textSizeSMedium,
                      //           fontWeight: FontWeight.w400,
                      //           color: colorSecondary),
                      //     )).paddingTop(10),
                     
                      CustomTextFormField(context,
                        controller: invitingController,
                        focusNode: invitingFouseNode,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Please enter email",
                        validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!value.contains("@")) {
                                return "Please enter a validate email";
                              }
        
                              return null;
                            },
                      ).paddingTop(spacing_twinty),
                      elevatedButton(
                        context,
                        onPress: () {
                          if (formkey.currentState!.validate()) {
                             HomeViewModel().inviteFriendsPost(
                                  invitingController.text.trim().toString(),
                                  context);
                          } 
                          
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(svg_shareit),
                            const SizedBox(
                              width: 10,
                            ),
                            text("Invite Friend",
                                fontSize: textSizeMedium,
                                fontWeight: FontWeight.w500,
                                color: white)
                          ],
                        ),
                      ).paddingTop(20),
                      // elevatedButton(
                      //   context,
                      //   onPress: () {},
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SvgPicture.asset(svg_shareit),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       text(Invitefriend_share,
                      //           fontSize: textSizeMedium,
                      //           fontWeight: FontWeight.w500,
                      //           color: white)
                      //     ],
                      //   ),
                      // ).paddingTop(20),
                    
                    ],
                  ),
                ),
                // Invited Friends ///.........................>>>.
                FutureBuilder(
                  future: HomeViewModel().getInviteFriends(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: const CustomLoadingIndicator()
                            .paddingTop(spacing_middle));
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            text(snapshot.error.toString(), maxLine: 10));
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: text("No Invitation Found ", maxLine: 10));
                  } else {
                    List<dynamic> invited = [];
                    if (snapshot.data['data']["docs"] != null &&
                        snapshot.data['data'].isNotEmpty) {
                      invited = snapshot.data['data']["docs"].toList();
                      
                      // You can print or use featureData here if needed.
                    } else {
                      invited = [];
                    }
                     
                    return invited.isEmpty
                        ? const Center(child: Text("No Invited friend Found"))
                            .paddingSymmetric(vertical: spacing_twinty)
                        :ListView.builder(shrinkWrap: true,
                        itemCount:invited.length,
                          itemBuilder: (context, index) {
                    var data=invited[index];
        // print("data: ${data}");
                            
                          return  
                           Container(
                               alignment: Alignment.center,
                               height: orientation == Orientation.portrait
                                   ? MediaQuery.of(context).size.height * 0.11
                                   : MediaQuery.of(context).size.height * 0.2,
                               decoration: BoxDecoration(
                                   color: white,
                                   boxShadow: [
                                     BoxShadow(
                                         color: black.withOpacity(0.06),
                                         offset: const Offset(0, 4),
                                         blurRadius: 24)
                                   ],
                                   borderRadius: BorderRadius.circular(10)),
                               child: ListTile(
                                 leading: CircleAvatar(
                                         radius: size.width * .07,
                                         backgroundColor: colorPrimary,
                                         child: ClipOval(
                                             child: Image.network(
                                           data["userDetails"]["image"].toString(),
                                           height: size.width * .12,
                                           width: size.width * .12,
                                           fit: BoxFit.cover,
                                         )),
                                       ),
                                 
                                 title: text(data["userDetails"]["name"].toString(),
                                     fontSize: textSizeSMedium,
                                     fontWeight: FontWeight.w500,
                                     isLongText: true),
                                 subtitle: text(DateFormat("yMMMMEEEEd").format(DateTime.parse(data["userDetails"]["createdAt"].toString())),
                                     fontSize: 11.0,
                                     fontWeight: FontWeight.w400,
                                     color: colorSecondary),
                                 trailing: 
                                 Column(
                                                   children: [
                                                     text(
                                                       "${data["reward"].toString()} PTS ",
                                                       fontSize: textSizeLargeMedium,
                                                       fontWeight: FontWeight.w500,
                                                     ),
                                                     text("${data["equivalenceNaira"].toString()} N",
                           color: colorPrimary,
                           fontSize: textSizeLargeMedium,
                           fontWeight: FontWeight.w500)
                                                   ],
                                                 ) )
                                                 ).paddingTop(10);
            
                        },);
                
          }})
                
              ]).paddingTop(10),
            ),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}
