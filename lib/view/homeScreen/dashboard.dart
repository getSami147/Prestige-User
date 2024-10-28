import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Updated package import
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/view/categories/categoriesScreen.dart';
import 'package:prestige/view/drawer/transactions/mytransaction.dart';
import 'package:prestige/view/order/orderhistory.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/view/homeScreen/homeScreen.dart';
import 'package:prestige/view/profile/profileScreen.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

import '../../utils/widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    // var authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    // authViewModel.updateDeviceToken(context);
    provider.getUserTokens();
    provider.getCurrentLocationPermission();
    getCurrentCoordinates();
    // initializeLocation(provider);
    super.initState();
  }

  // get current Location
  getCurrentCoordinates() async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var locations = await Geolocator.getCurrentPosition();
    provider.mylat = locations.latitude;
    provider.mylng = locations.longitude;
    setState(() {});
    return locations;
  }

  int selectedIndex = 0;
  var pages = [
    const Homescreen(),
    const CategoriesScreen(),
    const Mytransactionscreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];
  List<String> navBarIcons = [
    nav_ic_home,
    nav_ic_explore,
    nav_ic_trans,
    nav_ic_shoppingBag,
    nav_ic_profile,
  ];

  List<Widget> navText = [
    text(NavBar_home, fontSize: textSizeSmall),
    text(NavBar_explore, fontSize: textSizeSmall),
    text(NavBar_trans, fontSize: textSizeSmall),
    text(NavBar_shoppingBag, fontSize: textSizeSmall),
    text(NavBar_Profile, fontSize: textSizeSmall),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: color_white,
            boxShadow: [
              BoxShadow(
                  color: colorPrimary.withOpacity(.15),
                  blurRadius: 45,
                  offset: const Offset(0, 5))
            ],
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: radiusCircular(15))),
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: navBarIcons.asMap().entries.map((entry) {
              int index = entry.key;
              String e = entry.value;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      e,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                      color: index == selectedIndex ? colorPrimary : null,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  navText[index]
                ],
              );
            }).toList()),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (selectedIndex != 0) {
            selectedIndex = 0;
            setState(() {});
          } else {
            // Show exit confirmation dialog
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Exit the app?'),
                  content: const Text('Are you sure you want to exit the app?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: text("NO")),
                    TextButton(
                        onPressed: () {
                          // Navigator.of(context).pop(true);
                          exit(0);
                        },
                        child: text("Yes")),
                  ],
                );
              },
            );
          }

          return false;
        },
        child: PageView(
          children: [pages[selectedIndex]],
        ),
      ),
    );
  }
}
