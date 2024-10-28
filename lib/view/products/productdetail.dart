import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Constant.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/addToCart.dart';
import 'package:prestige/view/shops/storedetail.dart';
import 'package:prestige/view/components/component.dart';
import 'package:prestige/view/googleMap/googleMapScreen.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  String? slug;
  ProductDetailScreen({super.key, this.slug});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(ProductScreen_product,
            fontSize: textSizeLargeMedium, fontWeight: FontWeight.w700),
        actions: [
          Consumer<UserViewModel>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    const AddToCart().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                  icon: Stack(
                    children: [
                       const Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                        color: colorPrimary,
                      ),
                      for (int i = 0; i < value.cartList.length; i++) ...[
                        value.cartList.isEmpty
                            ? const SizedBox()
                            : Container(
                                alignment: Alignment.center,
                                height: 15,
                                width: 15,
                                decoration: const BoxDecoration(
                                    color: colorPrimary,
                                    shape: BoxShape.circle),
                                child: text(value.cartList.length.toString(),
                                    color: white,
                                    fontSize: 8.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontPoppins)),
                      ]
                    ],
                  ));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: HomeViewModel()
            .getSingalFeatureProducts(context, widget.slug.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    const CustomLoadingIndicator().paddingTop(spacing_middle));
          } else if (snapshot.hasError) {
            return Center(
                child: text(snapshot.error.toString(), maxLine: 10)
                    .paddingSymmetric(horizontal: spacing_twinty));
          } else if (!snapshot.hasData) {
            return Center(child: text("No Feature Products", maxLine: 10));
          } else {
            var data = snapshot.data;
            // ignore: prefer_typing_uninitialized_variables
            var images;
            for (var i = 0; i < data["images"].length; i++) {
              images = data["images"][i];
            }
            // List<dynamic> featureData = [];

            // if (snapshot.data['data'] != null &&
            //     snapshot.data['data'].isNotEmpty) {
            //   featureData = snapshot.data['data']
            //       .where((e) => e['featureProduct'] == true)
            //       .toList();
            //   // You can print or use featureData here if needed.
            //   print(featureData.toList());
            // } else {
            //   featureData = [];
            //   // print(featureData);
            // }

            return
                // snapshot.data.isEmpty || featureData.isEmpty == null
                //     ? const Center(child: Text("No Feature Product"))
                //         .paddingSymmetric(vertical: spacing_twinty)
                //     :
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: orientation == Orientation.portrait
                        ? size.height * 0.33
                        : size.height * 0.48,
                    child: PageView.builder(
                      itemCount: 3,
                      onPageChanged: (value) {
                        userViewModel.selectedIndexMethod(value);
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: double.infinity,
                              //height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  color: colorSecondary.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(images,
                                        fit: orientation == Orientation.portrait
                                            ? BoxFit.cover
                                            : BoxFit.fill,
                                        height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.33
                                                : size.height * 0.3,
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width,
                                                errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct, height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.33
                                                : size.height * 0.3,
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width,fit: BoxFit.cover,);
                        },
                                                ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Consumer<UserViewModel>(
                    builder: (context, value, child) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++) ...[
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 5,
                                width: value.selectedIndex == i ? 13 : 5,
                                decoration: BoxDecoration(
                                    color: value.selectedIndex == i
                                        ? textGreenColor
                                        : colorSecondary,
                                    borderRadius: BorderRadius.circular(8)),
                              )
                            ]
                          ]).paddingTop(8);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(data["name"].toString(),
                          color: black,
                          fontSize: textSizeNormal,
                          fontWeight: FontWeight.w500),
                      text("N ${ammoutFormatter(data["price"])}",
                          color: colorPrimary,
                          fontWeight: FontWeight.w600)
                    ],
                  ).paddingOnly(left: 6, right: 8, top: 10),
                  offerContiner(
                    alig: Alignment.center,
                    show: true,
                    size: 13.0,
                    color1: black,
                    color: colorPrimary.withOpacity(0.14),
                    text1: ProductScreen_wants,
                    image: coin2,
                  ).paddingTop(5),
                  const Divider(
                    thickness: 1,
                    color: colorSecondary,
                    indent: 15,
                    endIndent: 15,
                  ).paddingTop(5),
                  InkWell(
                    onTap: () {
                      ShopDetailscreen(
                        slug: data["shopId"]["slug"].toString(),
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: size.width * .09,
                                backgroundColor: colorPrimary,
                                child: ClipOval(
                                    child: Image.network(
                                  data["shopId"]["coverImage"][0],
                                  height: size.width * .16,
                                  width: size.width * .16,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,height: size.width * .16,
                                  width: size.width * .16,
                                  fit: BoxFit.cover,);
                        },
                                )),
                              ),
                               Flexible(
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     text(data["shopId"]["title"].toString(),
                                         fontSize:textSizeLargeMedium),
                                     text(data["shopId"]["address"].toString(),maxLine: 5,overflow: TextOverflow.ellipsis,
                                         fontSize:textSizeSmall)
                                   ],
                                 ).paddingOnly(left: 10, top: 10),
                               ),
                                                 
                            ],
                          ),
                        ),
                        Container(
                          height: 37,
                          width: 37,
                          decoration: BoxDecoration(
                              color: colorSecondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(11)),
                          child: IconButton(
                              onPressed: () {
                                GoogleMapScreen(
                                  coordinates: data["shopId"]["location"]
                                      ["coordinates"],
                                  shopName: data["shopId"]["title"].toString(),
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                              icon: SvgPicture.asset(svg_current)),
                        ),
                      ],
                    ).paddingTop(5),
                  ),
                  const Divider(
                    thickness: 1,
                    color: colorSecondary,
                    indent: 15,
                    endIndent: 15,
                  ).paddingTop(5),
                  text(
                    ProductScreen_about,
                    fontSize: textSizeLargeMedium,
                    fontWeight: FontWeight.w600,
                  ).paddingTop(10),
                  text(data["description"].toString(),
                      isLongText: true,
                      fontSize: textSizeSmall,
                      maxLine: 15,
                      fontWeight: FontWeight.w400,
                      color: colorSecondary),
                  Row(
                    children: [
                      Expanded(
                        child: elevatedButton(
                          context,
                          backgroundColor: white,
                          bodersideColor: textGreenColor,
                          onPress: () {
                            if (data != null) {
                              if (userViewModel.cartList.isEmpty) {
                                // Adding a new key-value pair to the map
                                data["quantity"] = (0) + 1;
                                userViewModel.quantity = 1;
                                userViewModel.cartList.add(data);
                                Timer(const Duration(milliseconds: 200), () {
                                  utils().toastMethod("Item added to cart.",);
                                });
                              } else if (data["shopId"]["_id"].toString() !=
                                  userViewModel.cartList[0]["shopId"]["_id"]
                                      .toString()) {
                                utils().toastMethod(
                                    "Add the Same Shope Products only",backgroundColor: dissmisable_RedColor,color: color_white);
                              } else if (data["_id"].toString() ==
                                  userViewModel.cartList[0]["_id"].toString()) {
                                utils().toastMethod(
                                    "This Product is already added.",backgroundColor: dissmisable_RedColor,color: color_white);
                              } else {
                                // Adding a new key-value pair to the map
                                data["quantity"] = (0) + 1;
                                userViewModel.quantity = 1;
                                userViewModel.cartList.add(data);
                                Timer(const Duration(milliseconds: 200), () {
                                  utils().toastMethod("Item added to cart.");
                                });
                              }
                            }
                          },
                          child: text(ProductScreen_addcar,
                              color: textGreenColor),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: elevatedButton(
                          context,
                          onPress: () {
                           if (data != null) {
                              if (userViewModel.cartList.isEmpty) {
                                // Adding a new key-value pair to the map
                                data["quantity"] = (0) + 1;
                                userViewModel.quantity = 1;
                                userViewModel.cartList.add(data);
                                Timer(const Duration(milliseconds: 200), () {
                                const AddToCart().launch(context,pageRouteAnimation: PageRouteAnimation.Fade);

                                });
                              } else if (data["shopId"]["_id"].toString() !=
                                  userViewModel.cartList[0]["shopId"]["_id"]
                                      .toString()) {
                                utils().toastMethod(
                                    "Add the Same Shope Products only",backgroundColor: dissmisable_RedColor,color: color_white);
                              } else if (data["_id"].toString() ==
                                  userViewModel.cartList[0]["_id"].toString()) {
                                utils().toastMethod(
                                    "This Product is already added.",backgroundColor: dissmisable_RedColor,color: color_white);
                              } else {
                                // Adding a new key-value pair to the map
                                data["quantity"] = (0) + 1;
                                userViewModel.quantity = 1;
                                userViewModel.cartList.add(data);
                                Timer(const Duration(milliseconds: 200), () {
                                  const AddToCart().launch(context,pageRouteAnimation: PageRouteAnimation.Fade);
                                });
                              }
                            }
                          },
                          child: text(ProductScreen_buy, color: white),
                        ),
                      )
                    ],
                  ).paddingTop(spacingBig)
                ],
              ).paddingSymmetric(horizontal: 15, vertical: 10),
            );
          }
        },
      ),
    );
  }
}
