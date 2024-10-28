import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/drawer/memberShip/memberShipAlertBox.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class Checkoutscreen extends StatefulWidget {
  const Checkoutscreen({super.key});

  @override
  State<Checkoutscreen> createState() => _CheckoutscreenState();
}

class _CheckoutscreenState extends State<Checkoutscreen> {
  @override
  void initState() {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.cartTotalPoints =
        cartTotalToPoints(userViewModel.total.toDouble());
    // print("point :${double.parse(userViewModel.cartTotalPoints.toStringAsFixed(2))}");
    // TODO: implement initState
    super.initState();
  }

  var select = Checkoutscreen_pickup;
  // Point Conversion
  double cartTotalToPoints(double cartTotal) {
    double limit = 0.03;
    double points = cartTotal / limit / 100;
    return points;
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    // if (kDebugMode) {
    //   print("cartTotalPoints :${double.parse(userViewModel.cartTotalPoints.toStringAsFixed(2))}");
    //   print("User prestigePoints :${userViewModel.prestigePoint}");

    // }

    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: text(Checkoutscreen_check,
            fontSize:textSizeLargeMedium, fontWeight: FontWeight.w700),
      ),
      body: FutureBuilder(
        future: HomeViewModel().getAllPointFormula(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    const CustomLoadingIndicator().paddingTop(spacing_middle));
          } else if (snapshot.hasError) {
            return Center(child: text(snapshot.error.toString(), maxLine: 10))
                .paddingAll(10);
          } else if (!snapshot.hasData) {
            return Center(child: text("No Formula", maxLine: 10));
          } else {
            var data;

            if (snapshot.data != null && snapshot.data.isNotEmpty) {
              data =
                  snapshot.data['data'].firstWhere((e) => e['limit'] == true);
            } else {
              data = null;
            }
            print('pointsEarned: ${data["pointsEarned"]}');
            var earnedPoints = data["pointsEarned"];
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Consumer<UserViewModel>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(Checkoutscreen_Prestige,
                              fontSize: textSizeSMedium, fontWeight: FontWeight.w600)
                          .paddingTop(10),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xff252525).withOpacity(0.11),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                text(ammoutFormatter((userViewModel.prestigePoint is double ? userViewModel.prestigePoint  : double.tryParse(userViewModel.prestigePoint.toString()))?.toInt() ?? 0),
                                    color: textGreenColor.withOpacity(0.4),
                                  
                                    fontWeight: FontWeight.w600),
                                const SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  coin2,
                                  height: 20,
                                ),
                              ],
                            ),

                            Container(
                              alignment: Alignment.center,
                              height: 29,
                              decoration: BoxDecoration(
                                  color: const Color(0xff034542).withOpacity(.4),
                                  borderRadius: BorderRadius.circular(6)),
                              child: text(
                                      "N ${ammoutFormatter((userViewModel.currentNira is double ? userViewModel.currentNira  : double.tryParse(userViewModel.currentNira.toString()))?.toInt() ?? 0)}",
                                      fontSize: textSizeSMedium,
                                      fontWeight: FontWeight.w600)
                                  .paddingSymmetric(horizontal: spacing_middle),
                            ),
                            //   const Spacer(),
                            //   InkWell(
                            //     onTap: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) => CouponScreen(),
                            //       ).then((value) {
                            //         // coupon = value[0]["data"][0];
                            //         // couponController = value[1];
                            //         //  print("coupon: ${coupon}");
                            //         // if (coupon != null) {
                            //         //   applyCoupon(coupon, totalPrice.toDouble());
                            //         //   // finalValue = Coupon.fromJson(coupon)!.applyCoupon(totalPrice.toDouble());
                            //         //   setState(() {});
                            //         // }
                            //       });
                            //     },
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       height: 26,
                            //       width: 54,
                            //       decoration: BoxDecoration(
                            //           color: textGreenColor,
                            //           borderRadius: BorderRadius.circular(27)),
                            //       child: text(Checkoutscreen_Use,
                            //           fontSize: textSize,
                            //           fontWeight: FontWeight.w600,
                            //           color: white),
                            //     ).paddingRight(10),
                            //   ),
                            //
                          ],
                        ).paddingSymmetric(horizontal: spacing_middle),
                      ).paddingTop(spacing_middle),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(value.cartList[0]["shopId"]["title"].toString(),
                                  fontSize: textSizeLargeMedium, fontWeight: FontWeight.w600)
                              .paddingTop(spacing_twinty),
                         ListView.builder(
                      itemCount: userViewModel.cartList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: black.withOpacity(0.07),
                                        blurRadius: 24,
                                        offset: const Offset(0, 4))
                                  ]),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      alignment: Alignment.center,
                                      userViewModel.cartList[index]["images"][0]
                                          .toString(),
                                      height: orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.height *
                                              0.078
                                          : MediaQuery.of(context).size.height *
                                              0.2,
                                      width: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.2
                                          : MediaQuery.of(context).size.height *
                                              0.2,
                                      fit: BoxFit.cover,
                                       errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,height: orientation ==
                                              Orientation.portrait
                                          ? MediaQuery.of(context).size.height *
                                              0.078
                                          : MediaQuery.of(context).size.height *
                                              0.2,
                                      width: orientation == Orientation.portrait
                                          ? MediaQuery.of(context).size.width *
                                              0.2
                                          : MediaQuery.of(context).size.height *
                                              0.2,
                                      fit: BoxFit.cover,);
                        },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        text(
                                            value.cartList[index]["name"]
                                                .toString(),overflow: TextOverflow.ellipsis,
                                      
                                            fontWeight: FontWeight.w600),
                                        text(
                                                value.cartList[index]["type"]
                                                    .toString(),
                                                fontSize: textSizeSmall,
                                                fontWeight: FontWeight.w400)
                                            .paddingTop(5),
                                        text(
                                                value.cartList[index]['quantity']
                                                    .toString(),
                                                fontSize: textSizeSmall,
                                                fontWeight: FontWeight.w400)
                                            .paddingTop(5),
                                      ],
                                    ).paddingLeft(spacing_middle),
                                  ),
                                  // const Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text(
                                          "N ${ammoutFormatter(value.cartList[index]["price"])}",overflow: TextOverflow.ellipsis,
                                          fontSize: textSizeSMedium,
                                          fontWeight: FontWeight.w600,
                                          color: colorSecondary),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (value.cartList[index]
                                                      ['quantity'] >
                                                  1) {
                                                value.cartList[index]
                                                    ['quantity']--;
                                                value.updateCartPrices();
                                              }
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: textGreenColor
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Icon(
                                                Icons.remove,
                                                color: white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          text(value.cartList[index]['quantity']
                                              .toString()),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              value.cartList[index]
                                                  ['quantity']++;
                                              value.updateCartPrices();
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                  color: textGreenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: const Icon(
                                                Icons.add,
                                                color: white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ).paddingSymmetric(
                                  horizontal: spacing_middle,
                                  vertical: spacing_twinty),
                            ).paddingTop(spacing_twinty),
                            Positioned(
                                top: spacing_twinty,
                                right: 5,
                                child: InkWell(
                                    onTap: () {
                                      value.removeFromCart(index);
                                      setState(() {});
                                    userViewModel.updateCartPrices();

                                      // if (kDebugMode) {
                                      //   print("cartlength ${userViewModel.cartList.length}");
                                      // }
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: dissmisable_RedColor,
                                    ))),
                          ],
                        );
                      },
                    ),
                     text(Checkoutscreen_Billing,fontWeight: FontWeight.w600)
                              .paddingTop(spacing_thirty),
                          Container(
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xff252525)
                                          .withOpacity(0.11),
                                      blurRadius: 15,
                                      offset: const Offset(0, 4))
                                ]),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomBillingRow(
                                  text0: "Number of Items",
                                  text1: value.cartList.length.toString(),
                                ),
                                const SizedBox(
                                  height: spacing_middle,
                                ),
                                CustomBillingRow(
                                  text0: "Bill",
                                  text1:"N ${ammoutFormatter(value.total.toString().toInt())}",
                                ),
                                // const SizedBox(
                                //   height: spacing_middle,
                                // ),
                                // CustomBillingRow(
                                //   text0: "Service Tax",
                                //   text1: "",
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                            
                                const Divider(
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                CustomBillingRow(
                                  text0: Checkoutscreen_total,
                                  text1: "N ${ammoutFormatter(value.total.toString().toInt())}",
                                  titleColor: colorPrimary,
                                  traillingColor: colorPrimary,
                                  trallingFontWeight: FontWeight.w600,
                                  leadingFontWeight: FontWeight.w600,
                                )
                              ],
                            ).paddingSymmetric(vertical: spacing_middle),
                          ).paddingTop(10),
                        ],
                      ).paddingSymmetric(vertical: 10),
                      text(Checkoutscreen_payment,fontWeight: FontWeight.w600)
                          .paddingTop(10),
                      // Consumer<UserViewModel>(
                      //   builder: (context, value, child) {
                      //     return Column(
                      //       children: [
                      //         //cashpoint Method..............
                      //         paymentMethodTile(
                      //           leadingImage: coin2,
                      //           title: Checkoutscreen_pickup,
                      //           subtitle: Checkoutscreen_ready,
                      //           value: Checkoutscreen_CashPointMethod,
                      //           groupValue: value.selectedMethod,
                      //           onChanged: (newValue) {
                      //             value.setSelectedMethod(newValue);
                      //             if (kDebugMode) {
                      //               print(
                      //                   "payment Method: ${value.selectedMethod.toString()}");
                      //             }
                      //           },
                      //         ),
                      //         //cash..............
                      //         paymentMethodTile(
                      //           leadingImage: handcash,
                      //           title: Checkoutscreen_cash,
                      //           subtitle: Checkoutscreen_usingCash,
                      //           value: Checkoutscreen_CashMethod,
                      //           groupValue: value.selectedMethod,
                      //           onChanged: (newValue) {
                      //             value.setSelectedMethod(newValue);
                      //             if (kDebugMode) {
                      //               print(
                      //                   "payment Method: ${value.selectedMethod.toString()}");
                      //             }
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
                     
                      Consumer<UserViewModel>(
                        builder: (context, userView, child) {
                          return SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: userView.prestigePoint! >=
                                      earnedPoints
                                  ? () {
                                     if(userView.membership==false){
                                      showDialog(barrierDismissible: false,
                                context: context,builder: (context) {
                                      // Delete Page (Dialog Box) is Called.............>>>
                                      return  MemberShipAlertBox();
                                    },
                                  );
                                     
                                     }else if (userView.prestigePoint! >=
                                          userView.cartTotalPoints) {
                                        Map<String, dynamic> data = {
                                          "userId":
                                              userView.userId.toString(),
                                          "receiver_phone":
                                              userView.contact.toString(),
                                          "receiver_Email": userView
                                              .userEmail
                                              .toString(),
                                          "receiver_Name":
                                              userView.name.toString(),
                                          "items": [
                                            for (int index = 0;
                                                index <
                                                    userView
                                                        .cartList.length;
                                                index++) ...[
                                              {
                                                "productId": userView
                                                    .cartList[index]["_id"]
                                                    .toString(),
                                                "quantity": userView
                                                        .cartList[index]
                                                    ['quantity'],
                                                "type": userView
                                                    .cartList[index]["type"]
                                                    .toString(),
                                                "categoryId": userView
                                                    .cartList[index]["category"]
                                                    .toString(),
                                                "name": userView
                                                    .cartList[index]["name"]
                                                    .toString(),
                                                "basePrice": userView
                                                    .cartList[index]["price"],
                                                "image": userView
                                                    .cartList[index]["images"]
                                                        [0]
                                                    .toString(),
                                                "description": userView
                                                    .cartList[index]
                                                        ["description"]
                                                    .toString(),
                                                "shopId": userView
                                                    .cartList[index]["shopId"]
                                                        ["_id"]
                                                    .toString()
                                              },
                                            ]
                                          ],
                                          "totalPrice": userView.total,
                                          "orderStatus": "PENDING",
                                          "orderHistory": [],
                                          "PaymentHistory": [],
                                          "orderType": "apporder",
                                          "point": 0,
                                          "cash": 0,
                                          "paymentMethod": "point"
                                        };
                                        HomeViewModel().placeOrderAPI(
                                            data, context);
                                        // print(data);
                                      } else {
                                        utils().toastMethod(
                                            "Your Point is less then cart Points");
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorPrimary),
                              child: text(Checkoutscreen_conform,
                                  color: white,
                                  fontWeight: FontWeight.w600),
                            ).paddingTop(20),
                          );

                          //   elevatedButton(
                          //     loading: loadingValue.loading,
                          //     context,
                          //     bodersideColor: userViewModel.prestigePoint!<=earnedPoints?unselectedcontainer:colorPrimary,
                          //  onPress: userViewModel.prestigePoint!<=earnedPoints?  () {

                          //       if (userViewModel.prestigePoint!<earnedPoints) {
                          //         utils().toastMethod("user Prestige Points should not less from earned points");
                          //       }else if(userViewModel.prestigePoint!<userViewModel.cartTotalPoints){
                          //         utils().toastMethod("user Prestige Points should not less cart Total Points");

                          //       }else {
                          //          Map<String, dynamic> data = {
                          //         "userId": userViewModel.userId.toString(),
                          //         "receiver_phone":
                          //             userViewModel.contact.toString(),
                          //         "receiver_Email":
                          //             userViewModel.userEmail.toString(),
                          //         "receiver_Name": userViewModel.name.toString(),
                          //         "items": [
                          //           for (int index = 0;
                          //               index < userViewModel.cartList.length;
                          //               index++) ...[
                          //             {
                          //               "productId": userViewModel.cartList[index]
                          //                       ["_id"]
                          //                   .toString(),
                          //               "quantity": userViewModel.cartList[index]
                          //                   ['quantity'],
                          //               "type": userViewModel.cartList[index]
                          //                       ["type"]
                          //                   .toString(),
                          //               "categoryId": userViewModel
                          //                   .cartList[index]["category"]
                          //                   .toString(),
                          //               "name": userViewModel.cartList[index]
                          //                       ["name"]
                          //                   .toString(),
                          //               "basePrice": userViewModel.cartList[index]
                          //                   ["price"],
                          //               "image": userViewModel.cartList[index]
                          //                       ["images"][0]
                          //                   .toString(),
                          //               "description": userViewModel
                          //                   .cartList[index]["description"]
                          //                   .toString(),
                          //               "shopId": userViewModel.cartList[index]
                          //                       ["shopId"]
                          //                   .toString()
                          //             },
                          //           ]
                          //         ],
                          //         "totalPrice": userViewModel.total,
                          //         "orderStatus": "PENDING",
                          //         "orderHistory": [],
                          //         "PaymentHistory": [],
                          //         "orderType": "apporder",
                          //         "point": 0,
                          //         "cash": 0,
                          //         "paymentMethod": "point"
                          //       };
                          //       loadingValue.placeOrderAPI(data, context);
                          //       // print(data);
                          //       }

                          //     }:null,
                          //     child: text(Checkoutscreen_conform,
                          //         color: white,
                          //         fontWeight: FontWeight.w600),
                          //   ).paddingTop(20);
                        },
                      )
                    ],
                  ).paddingSymmetric(horizontal: 15, vertical: 10);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomBillingRow extends StatelessWidget {
  String? text0, text1;
  Color? titleColor, traillingColor;
  dynamic trallingFontWeight, leadingFontWeight;

  CustomBillingRow({
    this.traillingColor,
    this.text0,
    this.text1,
    this.titleColor,
    this.trallingFontWeight=FontWeight.w500,this.leadingFontWeight=FontWeight.w400,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(text0.toString(), fontSize: textSizeSMedium, color: titleColor,fontWeight: leadingFontWeight),
        text(text1.toString(),
            fontSize: textSizeSMedium, fontWeight:trallingFontWeight, color: traillingColor)
      ],
    ).paddingSymmetric(horizontal: spacing_middle);
  }
}

Widget paymentMethodTile(
    {required String leadingImage,
    required String title,
    String? subtitle,
    required var value,
    required var groupValue,
    required Function(dynamic) onChanged}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff252525).withOpacity(0.11),
          blurRadius: 15,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: ListTile(
      leading: Image.asset(
        leadingImage,
        fit: BoxFit.cover,
        height: 25,
      ),
      title: text(title,fontWeight: FontWeight.w600)
          .paddingTop(8),
      subtitle: text(subtitle, fontSize:textSizeSmall, fontWeight: FontWeight.w400),
      trailing: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    ),
  ).paddingTop(spacing_standard_new);
}
