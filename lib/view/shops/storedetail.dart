import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/res/appUrl.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/view/googleMap/googleMapScreen.dart';
import 'package:prestige/viewModel/Prestigemdel.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class ShopDetailscreen extends StatefulWidget {
  String? slug;
  ShopDetailscreen({super.key, required this.slug});

  @override
  State<ShopDetailscreen> createState() => _ShopDetailscreenState();
}

class _ShopDetailscreenState extends State<ShopDetailscreen> {
  Map featureData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeatureProduct();
  }

  Future<void> getFeatureProduct() async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    print("Slug${widget.slug}");
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    var response = await http.get(
        Uri.parse('${AppUrls.baseUrl}shop/slug/${widget.slug.toString()}'),
        headers: headers);

    var data = jsonDecode(response.body);
    // SubCategory().feature(data);
    setState(() {
      featureData = data;
      if (kDebugMode) {
        print(featureData);
      }
    });

    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        title: text(StoredtailScreen_Store,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future:
                  HomeViewModel().shopBySlug(context, widget.slug.toString()),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: const CustomLoadingIndicator()
                          .paddingTop(spacing_middle));
                } else if (snapshot.hasError) {
                  return Center(
                      child: text(snapshot.error.toString(), maxLine: 10));
                } else if (!snapshot.hasData) {
                  return Center(child: text("No Subcategries", maxLine: 10));
                } else {
                  var data = snapshot.data['shop'];

                  // var doc = snapshot.data['docs'];
                  var images, logo, image, title, des;
                  for (var i = 0; i < data["coverImage"].length; i++) {
                    images = data["coverImage"][i];
                    title = data["title"];
                    des = data["description"];
                  }
                  // for (var i = 0; i < doc.length; i++) {
                  //   image = doc[i]["images"][0];
                  //   title1 = doc[i]["name"];
                  //   price = doc[i]["price"];
                  // }

                  for (var i = 0; i < data["logo"].length; i++) {
                    logo = data["logo"][i];
                  }
                  return data.isEmpty
                      ? Center(
                          child:
                              text("No Shop Detail").paddingTop(spacing_twinty))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomLeft,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  child: Image.network(images,
                                          fit: orientation ==
                                                  Orientation.portrait
                                              ? BoxFit.cover
                                              : BoxFit.fill,
                                          height: orientation ==
                                                  Orientation.portrait
                                              ? size.height * 0.25
                                              : size.height * 0.4,
                                          width: orientation ==
                                                  Orientation.portrait
                                              ? size.width
                                              : size.width
                                              ,errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,fit: orientation ==
                                                  Orientation.portrait
                                              ? BoxFit.cover
                                              : BoxFit.fill,
                                          height: orientation ==
                                                  Orientation.portrait
                                              ? size.height * 0.25
                                              : size.height * 0.4,
                                          width: orientation ==
                                                  Orientation.portrait
                                              ? size.width
                                              : size.width);
                        },
                                              )
                                      .paddingTop(5),
                                ),
                                Positioned(
                                  bottom: -30,
                                  left: 15,
                                  child: CircleAvatar(
                                    radius: orientation == Orientation.portrait
                                        ? size.width * .08
                                        : size.width * .05,
                                    backgroundColor: colorPrimary,
                                    child: ClipOval(
                                        child: Image.network(
                                      logo,
                                      height:
                                          orientation == Orientation.portrait
                                              ? size.width * .16
                                              : size.width * .1,
                                      width: orientation == Orientation.portrait
                                          ? size.width * .16
                                          : size.width * .1,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,height:
                                          orientation == Orientation.portrait
                                              ? size.width * .16
                                              : size.width * .1,
                                      width: orientation == Orientation.portrait
                                          ? size.width * .16
                                          : size.width * .1,
                                      fit: BoxFit.cover,);
                        },
                                    )),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(title,
                                    fontSize: textSizeLarge,fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis),
                                Container(
                                  height: 37,
                                  width: 37,
                                  decoration: BoxDecoration(
                                      color:
                                          colorSecondary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(11)),
                                  child: IconButton(
                                      onPressed: () {
                                        GoogleMapScreen(
                                          coordinates: data['location']
                                              ['coordinates'],
                                          shopName: title,
                                        ).launch(context,
                                            pageRouteAnimation:
                                                PageRouteAnimation.Fade);
                                      },
                                      icon: SvgPicture.asset(svg_current)),
                                ),
                              ],
                            ).paddingTop(spacingBig),
                            const Divider(
                              thickness: 1,
                              color: colorSecondary,
                              indent: 10,
                              endIndent: 10,
                            ).paddingTop(5),
                            text("About",
                                fontSize: textSizeLargeMedium, fontWeight: FontWeight.w600),
                            text(
                              des,
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              maxLine: 10,
                              isLongText: true,
                            ),
                            const Divider(
                              thickness: 1,
                              color: colorSecondary,
                              indent: 10,
                              endIndent: 10,
                            ).paddingTop(5),
                            // doc.isEmpty
                            //     ? Center(
                            //         child: text("No Product")
                            //             .paddingTop(spacing_twinty))
                          ],
                        );
                }
              },
            ),
            text("Products", fontSize:textSizeLargeMedium, fontWeight: FontWeight.w600)
                .paddingTop(spacing_middle),
            featureData.isEmpty
                ? Center(
                    child: const CustomLoadingIndicator()
                        .paddingTop(spacing_twinty))
                : featureData['docs'].isEmpty
                    ? Center(
                        child: const Text(
                          "No Products",
                          style: TextStyle(fontSize: textSizeMedium),
                        ).paddingSymmetric(vertical: spacing_thirty),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: featureData['docs'].length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio:
                                orientation == Orientation.portrait
                                    ? 0.78
                                    : 0.8),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ProductDetailScreen(
                                slug: featureData['docs'][index]['slug']
                                    .toString(),
                              ).launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Fade);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 24,
                                        offset: const Offset(0, 4),
                                        spreadRadius: 0,
                                        color: const Color(0xff000000)
                                            .withOpacity(.1))
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        featureData['docs'][index]['images'][0]
                                            .toString(),
                                        fit: orientation == Orientation.portrait
                                            ? BoxFit.contain
                                            : BoxFit.fill,
                                        height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.12
                                                : size.height * 0.25,
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width * 0.2,
                                                errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,  fit: orientation == Orientation.portrait
                                            ? BoxFit.contain
                                            : BoxFit.fill,
                                        height:
                                            orientation == Orientation.portrait
                                                ? size.height * 0.12
                                                : size.height * 0.25,
                                        width:
                                            orientation == Orientation.portrait
                                                ? size.width
                                                : size.width * 0.2,);
                        },),
                                  ),
                                  text(
                                      featureData['docs'][index]['name']
                                          .toString(),
                                      isLongText: true,
                                      fontSize: textSizeSMedium,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500),
                                  text('N ${ammoutFormatter(featureData['docs'][index]['price'])}',
                                      fontSize: textSizeSmall,
                                      fontWeight: FontWeight.w700,
                                      color: colorPrimary),
                                ],
                              ).paddingSymmetric(horizontal: spacing_middle),
                            ),
                          );
                        },
                      ).paddingTop(10)
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
