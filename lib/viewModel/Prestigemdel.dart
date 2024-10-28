import 'package:flutter/material.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';

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

//homescreen model
class referces {
  String? text, text1, text2, image;
  Color? color;
  Color bordercolor;
  referces(
      {this.text,
      this.text1,
      this.text2,
      this.image,
      this.color,
      required this.bordercolor});
}

final homescreenitem = [
  referces(
      text: HomeScreen_wevalue,
      text1: HomeScreen_refer,
      text2: HomeScreen_join,
      color: textGreenColor,
      bordercolor: textGreenColor),
  referces(
      text: HomeScreen_gettouch,
      text1: HomeScreen_forquestion,
      text2: HomeScreen_join,
      color: colorPrimary2,
      bordercolor: colorPrimary2)
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
//.....................................................//

// PartnerScreen model.........

class partners {
  String? image, text, text1;
  partners({this.image, this.text, this.text1});
}

final partnersmodel = [
  partners(
      image: nains, text: Partnerscreen_Nain, text1: CategoryScreen_address),
  partners(
      image: restaurant1,
      text: Partnerscreen_diamond,
      text1: CategoryScreen_address),
  partners(
      image: master, text: Partnerscreen_easty, text1: CategoryScreen_address),
  partners(
      image: fradel, text: Partnerscreen_bans, text1: CategoryScreen_address),
  partners(
      image: arbye,
      text: Partnerscreen_restaurant,
      text1: CategoryScreen_address),
  partners(
      image: Resturanr,
      text: Partnerscreen_marqee,
      text1: CategoryScreen_address),
  partners(
      image: arbye, text: Partnerscreen_Nain, text1: CategoryScreen_address),
  partners(
      image: bona, text: Partnerscreen_marqee, text1: CategoryScreen_address),
  partners(
      image: artisan,
      text: Partnerscreen_artsian,
      text1: CategoryScreen_address)
];
// ........................................//

// Storedetailscreen model.....
class storeitem {
  String? image, text, text1, text2;
  storeitem({this.image, this.text, this.text1, this.text2});
}

final storemodel = [
  storeitem(
      image: whiteshoes,
      text: StoredtailScreen_casual,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: mynt,
      text: StoredtailScreen_mynt,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: laces,
      text: StoredtailScreen_laces,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: sohaib,
      text: StoredtailScreen_sohaib,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: men,
      text: StoredtailScreen_men,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: shoes,
      text: StoredtailScreen_shoes,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: male,
      text: StoredtailScreen_males,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: khan,
      text: StoredtailScreen_khan,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
  storeitem(
      image: ladies,
      text: StoredtailScreen_ladies,
      text1: StoredtailScreen_bymr,
      text2: StoredtailScreen_n2),
];
//.....................................//

//Checkoutscreen model........

class check {
  String? image, text, text1, text2, text3, text4;
  check(
      {this.image, this.text, this.text1, this.text2, this.text3, this.text4});
}

final checkmodel = [
  check(
      image: biryani,
      text: Checkoutscreen_Biryani,
      text1: Checkoutscreen_Weight,
      text2: Checkoutscreen_Qty,
      text3: Checkoutscreen_N,
      text4: Checkoutscreen_N2),
  check(
      image: pizza,
      text: Checkoutscreen_Pizza,
      text1: Checkoutscreen_Weight,
      text2: Checkoutscreen_Qty,
      text3: Checkoutscreen_N,
      text4: Checkoutscreen_N2)
];
//........................................//

class billingmodel {
  String? text, text1;
  billingmodel({this.text, this.text1});
}

final billingitem = [
  billingmodel(text: Checkoutscreen_number, text1: Checkoutscreen_04),
  billingmodel(text: Checkoutscreen_Bill, text1: Checkoutscreen_n80),
  billingmodel(text: Checkoutscreen_gst, text1: Checkoutscreen_n3),
  billingmodel(text: Checkoutscreen_special, text1: Checkoutscreen_n10),
  billingmodel(text: Checkoutscreen_coin, text1: Checkoutscreen_N10)
];

//Orderdetail screen model...............
class ordermodel {
  String? text, text1;
  ordermodel({this.text, this.text1});
}

final orderdetail = [
  ordermodel(text: Ordrdetail_customer, text1: Ordrdetail_John),
  ordermodel(text: Ordrdetail_Tota, text1: Ordrdetail_n150),
  ordermodel(text: Ordrdetail_GST, text1: Ordrdetail_n3),
  ordermodel(text: Ordrdetail_Payment, text1: Ordrdetail_Cash),
  ordermodel(text: Ordrdetail_Used, text1: Ordrdetail_1000pts),
  ordermodel(text: Ordrdetail_Date, text1: Ordrdetail_20),
  ordermodel(text: Ordrdetail_Transaction, text1: Ordrdetail_HW736CT57892),
  ordermodel(text: Ordrdetail_Status, text1: Ordrdetail_Paid)
];
//..................................................//
// Favorite screen model

class favorite {
  String? image, text, text1, text2;
  favorite({this.image, this.text, this.text1, this.text2});
}

final favoritemodel = [
  favorite(
      image: nains2,
      text: Fvoritescreen_Shoestrin,
      text1: Fvoritescreen_by,
      text2: StoredtailScreen_n2),
  favorite(
      image: iphone,
      text: Fvoritescreen_IPhone,
      text1: Fvoritescreen_byNain,
      text2: Fvoritescreen_N305),
  favorite(
      image: shoesting,
      text: Fvoritescreen_Shoestring,
      text1: Fvoritescreen_by,
      text2: StoredtailScreen_n2),
  favorite(
      image: code,
      text: Fvoritescreen_Upper,
      text1: Fvoritescreen_by,
      text2: StoredtailScreen_n2),
  favorite(
      image: camera,
      text: Fvoritescreen_DSLR,
      text1: Fvoritescreen_byEl,
      text2: StoredtailScreen_n2),
  favorite(
      image: laptop,
      text: Fvoritescreen_MSI,
      text1: Fvoritescreen_by,
      text2: Fvoritescreen_N500),
];
//............................................//

class partnermodel {
  String? image, text, text1;
  partnermodel({this.image, this.text, this.text1});
}

final parteitem = [
  partnermodel(
      image: nains, text: Partnerscreen_Nain, text1: CategoryScreen_address),
  partnermodel(
      image: restaurant1,
      text: Partnerscreen_diamond,
      text1: CategoryScreen_address),
  partnermodel(
      image: master, text: Partnerscreen_easty, text1: CategoryScreen_address),
];
//...................................//

//Featurescreen model

class featureclass {
  String? image, text, text1;
  featureclass({this.image, this.text, this.text1});
}

final featuremodel = [
  featureclass(
      image: girl_gym, text: HomeScreen_girlgym, text1: Featurescreen_doll),
  featureclass(image: boy, text: HomeScreen_couple, text1: Featurescreen_dol),
  featureclass(image: cream, text: HomeScreen_cream, text1: Featurescreen_doll),
  featureclass(
      image: carp, text: Featurescreen_Sohaib, text1: Featurescreen_doll),
  featureclass(
      image: plumb, text: Featurescreen_khan, text1: Featurescreen_dol),
  featureclass(
      image: clean, text: Featurescreen_Kitchen, text1: Featurescreen_doll),
  featureclass(
      image: malepic, text: Featurescreen_Males, text1: Featurescreen_doll),
  featureclass(
      image: khan1, text: Featurescreen_khan, text1: Featurescreen_dol),
  featureclass(
      image: clean, text: Featurescreen_Kitchen, text1: Featurescreen_doll),
  featureclass(
      image: sohaibcapture,
      text: Featurescreen_Sohaib,
      text1: Featurescreen_doll),
  featureclass(
      image: khan1, text: Featurescreen_khan, text1: Featurescreen_dol),
  featureclass(
      image: clean, text: Featurescreen_Kitchen, text1: Featurescreen_doll),
];
//....................................................//

//Help and support screen
class help {
  String? image, text;
  help({this.image, this.text});
}

final helpmodel = [
  help(image: smallpc, text: help_question),
  help(image: wallatcard, text: help_payment),
  help(image: ciclepic, text: help_prestige),
  help(image: searchicon, text: help_other),
];

//................................................//

//MyCartscreen model
class cart {
  String? text, text1;
  cart({this.text, this.text1});
}

final cartmodel = [
  cart(text: Checkoutscreen_number, text1: Checkoutscreen_04),
  cart(text: Checkoutscreen_Bill, text1: Checkoutscreen_n80),
  cart(text: Mycart_Service, text1: Checkoutscreen_n3),
];
