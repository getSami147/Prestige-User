import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:prestige/view/drawer/contectUs.dart';
import 'package:prestige/view/drawer/rewards/invitefriend.dart';
import 'package:prestige/view/drawer/memberShip/memberservice.dart';

// onbondingscreen model
class onbonding {
  String? text, image, text1, text2;
  onbonding({this.image, this.text, this.text1, this.text2});
}

final onbondingscreenmodel = [
  onbonding(
      text: onbonding_reward,
      image: spendingReward,
      text1: onbonding_use_prestige,
      text2: ""),
  onbonding(
      text: welcome_welcometext,
      image: premierReward,
      text1: onbonding_use_point,
      text2: onbonding_keep_your)
];
//.............................................................................//

// OTP Verification screen model

class Verificationmodel {
  String? image, text;
  int? ratiovalue;
  Verificationmodel({this.image, this.text, this.ratiovalue});
}

final otpverficationmodel = [
  Verificationmodel(
      text: verifcationM_email, ratiovalue: 1, image: svg_emailaddress),
  Verificationmodel(
      text: verifcationM_mobilenumber, ratiovalue: 2, image: svg_mobilenumber)
];

//.....................................................................//

//homescreen model

class homescreenmodel {
  String? image, text, text1;
  homescreenmodel({this.image, this.text, this.text1});
}

final itemlist = [
  homescreenmodel(
      image: girl_gym, text: HomeScreen_girlgym, text1: HomeScreen_n54),
  homescreenmodel(image: boy, text: HomeScreen_couple, text1: HomeScreen_n4),
  homescreenmodel(image: cream, text: HomeScreen_cream, text1: HomeScreen_n44),
];
//........................................................//

//home screen SlidingCardModel 
class SlidingCardModel {
  String? text, text1, text2, image;
  Color? color;
  Color bordercolor;
  var onTap;
  SlidingCardModel(
      {this.text,
      this.text1,
      this.text2,
      this.image,
      this.color,required this.onTap,
      required this.bordercolor});
}

final slidingCardModel = [
  SlidingCardModel(
      text: HomeScreen_wevalue,
      text1: HomeScreen_refer,
      text2: "Share Code",
      color: textGreenColor,
      bordercolor: textGreenColor,
      onTap:const Invitedfriendscreen()),
  SlidingCardModel(
      text: HomeScreen_gettouch,
      text1: HomeScreen_forquestion,
      text2: "Contact Us",
      color: colorPrimary2,
      bordercolor: colorPrimary2,
      onTap:const ContactUs()),
  SlidingCardModel(
      text: "Promo Code",
      text1: "unlock your reward and keep\nenjoying Prestige+",
      text2: "Enter Promo Code",
      color: const Color(0xffFF0000),
      bordercolor: const Color(0xffFF0000),
       onTap: const Invitedfriendscreen())
];

//....................................................//

// Homescreen model

class category {
  String? image, text;
  category({this.image, this.text});
}

final categorymodel = [
  category(image: airplane, text: HomeScreen_transportion),
  category(image: woman2, text: HomeScreen_fashion),
  category(image: house, text: HomeScreen_home),
  category(image: bags, text: HomeScreen_travel),
  category(image: art, text: HomeScreen_art),
  category(image: sport, text: HomeScreen_sport),
  category(image: food, text: HomeScreen_food),
  category(image: child, text: HomeScreen_child),
  category(image: office, text: HomeScreen_office),
  category(image: toy, text: HomeScreen_toy),
];
//..................................................................//

//Categoryscreen model

class items {
  String? image, text;
  items({this.image, this.text});
}

final categorymodel2 = [
  items(image: door, text: CategoryScreen_home),
  items(image: sport, text: HomeScreen_sport),
  items(image: food, text: HomeScreen_food),
  items(image: pet, text: CategoryScreen_pet)
];

//.................................................................//
//Categoryscreen model
class product {
  String? image, text, text1, text2;
  product({this.image, this.text, this.text1, this.text2});
}

final productlist = [
  product(
      image: chir,
      text: CategoryScreen_chair,
      text1: CategoryScreen_address,
      text2: CategoryScreen_n3),
  product(
      image: table,
      text: CategoryScreen_table,
      text1: CategoryScreen_address,
      text2: CategoryScreen_n3),
  product(
      image: bed,
      text: CategoryScreen_bed,
      text1: CategoryScreen_address,
      text2: CategoryScreen_n3),
  product(
      image: cabi,
      text: CategoryScreen_cabi,
      text1: CategoryScreen_address,
      text2: CategoryScreen_n3)
];
