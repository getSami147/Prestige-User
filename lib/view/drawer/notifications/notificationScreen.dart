import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
      int page=1;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getMyNotifications(page, context); // Fetch initial data
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
          page++;
          homeViewModel.getMyNotifications(page, context); // Fetch next page
      
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: black),
          title: text(NotificationScreen_Notifications,
              fontSize: textSizeLarge, fontWeight: FontWeight.w700),
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, value, child) {
              List data = value.myNotification;
  
          // Sort the list in descending order by createdAt field
          data.sort((a, b) {
            DateTime dateA = DateTime.parse(a["createdAt"]);
            DateTime dateB = DateTime.parse(b["createdAt"]);
            return dateB.compareTo(dateA); // For descending order
          });

            if (value.pageloading && data.isEmpty) {
              return const Center(child: CustomLoadingIndicator());
            } else if (data.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      bellicon,
                      height: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.18
                          : MediaQuery.of(context).size.height * 0.28,
                    ),
                  ),
                  text(NotificationScreen_NoNotifications,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: textGreenColor)
                      .paddingTop(20)
                ],
              );
            } else {
              return SingleChildScrollView(
                controller: scrollController,
                 physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // NotificationDetailScreen(data: data).launch(context,
                            //     pageRouteAnimation: PageRouteAnimation.Fade);
                          },
                          child: CustomListTile(
                            image: ordersuccess,
                            text0: data[index]["title"].toString(),
                            text1:formatDateTime(data[index]["createdAt"].toString()),
                         
                          ).paddingTop(spacing_standard_new),
                        );
                      },
                    ).paddingSymmetric(horizontal: 15),
                     SizedBox(height: value.pageloading ? 20 : 10),
                      if (page!=1&& value.pageloading) const CircularProgressIndicator(),
                      SizedBox(height: value.pageloading ? 20 : 10),
                  ],
                ),
              );
            }
          },
        ));
  }
}

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  String? image, text0, text1;
  CustomListTile({this.image, this.text0, this.text1, super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Container(
        alignment: Alignment.center,
        height: orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.11
            : MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff333333).withOpacity(0.10),
                  offset: const Offset(0, 4),
                  blurRadius: 27)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colorPrimary.withOpacity(.9),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(drawer_ic_notificationbell,
                height: 20, width: 20, fit: BoxFit.contain, color: white),
          ),
          title: text(text0.toString(),
              fontSize: textSizeSmall, fontWeight: FontWeight.w500, isLongText: true),
          subtitle: text(text1.toString(),
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
              color: colorSecondary),
        ));
  }
}
