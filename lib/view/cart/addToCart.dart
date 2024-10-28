import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/checkout.dart';
import 'package:prestige/view/googleMap/googleMapScreen.dart';
import 'package:prestige/viewModel/Prestigemdel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void initState() {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
// ConstantFile.carttotal=0;
    userViewModel.updateCartPrices();
    if (kDebugMode) {
      print("user Total: ${userViewModel.total}");
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    // if (kDebugMode) {
    //   print("CartData: ${userViewModel.cartList}");
    // }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(Mycart_MyCart, fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: userViewModel.cartList.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: colorPrimary,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Your Cart in empty")
                // gradientText(myText: "Your Cart in empty", fontSize: textSizeSMedium)
              ],
            )
          : SingleChildScrollView(child: Consumer<UserViewModel>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text("Items: ${value.cartList.length.toString()}",
                            fontSize: textSizeLargeMedium, fontWeight: FontWeight.w600),
                        Container(
                          alignment: Alignment.center,
                          height: 37,
                          width: 37,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: dissmisable_RedColor.withOpacity(0.2)),
                          child: IconButton(
                              onPressed: () {
                                value.clearCart();
                                setState(() {});
                                print(
                                    "cartlength ${userViewModel.cartList.length}");
                              },
                              icon: const Icon(
                                Icons.delete_sharp,
                                color: dissmisable_RedColor,
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        text(value.cartList[0]["shopId"]["title"].toString(),
                            fontSize: textSizeSMedium, ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            GoogleMapScreen(
                                    coordinates: value.cartList[0]["shopId"]
                                        ["location"]["coordinates"],
                                    shopName: value.cartList[0]["shopId"]
                                            ["title"]
                                        .toString())
                                .launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: textGreenColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: black.withOpacity(0.07),
                                      blurRadius: 24,
                                      offset: Offset(0, 4))
                                ]),
                            height: 23,
                            width: 68,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.track_changes,
                                    color: white,
                                    size: 15,
                                  ),
                                  text(Ordrdetail_Track,
                                      fontSize: textSizeSMedium,
                                      fontWeight: FontWeight.w600,
                                      color: white)
                                ]),
                          ),
                        )
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     text(Mycart_Verified,
                    //         fontWeight: FontWeight.w600),
                    //     const Icon(
                    //       Icons.verified,
                    //       color: Colors.green,
                    //     ).paddingLeft(spacing_middle)
                    //   ],
                    // ).paddingTop(10),
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      text(
                                          "N ${ammoutFormatter(value.cartList[index]["price"]
                                          )}",overflow: TextOverflow.ellipsis,
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
                    text(Checkoutscreen_Billing,
                            fontSize: textSizeSMedium, fontWeight: FontWeight.w600)
                        .paddingTop(10),
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
                          const SizedBox(
                            height: spacing_middle,
                          ),

                          // custombillingrow(
                          //   text0: "Service Tax",
                          //   text1: "",
                          // ),

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
                            leadingFontWeight:FontWeight.w600

                          )
                        ],
                      ).paddingSymmetric(vertical: spacing_middle),
                    ).paddingTop(10),
                    elevatedButton(
                      context,
                      onPress: () {
                        const Checkoutscreen().launch(context,
                            pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      child: text(Mycart_Checkout, color: white),
                    ).paddingTop(20).paddingSymmetric(horizontal: spacing_standard_new)
                  ],
                ).paddingSymmetric(horizontal: 15, vertical: 10);
              },
            )),
    );
  }
}
