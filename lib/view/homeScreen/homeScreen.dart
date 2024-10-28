import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Colors.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/view/categories/subCategoriesscreen.dart';
import 'package:prestige/view/components/component.dart';
import 'package:prestige/view/drawer/drawer.dart';
import 'package:prestige/view/googleMap/googleMapScreen.dart';
import 'package:prestige/view/drawer/memberShip/memberservice.dart';
import 'package:prestige/view/drawer/transactions/mytransaction.dart';
import 'package:prestige/view/offer/prestigeoffer.dart';
import 'package:prestige/view/products/productSeeAllScreen.dart';
import 'package:prestige/view/giftAndPoint/giftAndPoints.dart';
import 'package:prestige/view/search/homeSearch.dart';
import 'package:prestige/view/shops/shopsScreen.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/onbondingmodel.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool show = false;
  int page = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    // Using SchedulerBinding to delay execution until after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getFavoriteProducts(context).then((value) {
        provider.getAllProductsAPI(page, context);
      });
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // When the user reaches the end of the list, load more data
        if (page != 1 && provider.pageloading) {
          page++;
          provider.getAllProductsAPI(page, context); // Fetch next page
        }
      }
    });
  }

  // String? idstore;
  // String? productid;
  @override
  Widget build(BuildContext context) {
    print("object");
    var size = MediaQuery.sizeOf(context);
    var subcategorProvider =
        Provider.of<SubCategoryProvider>(context, listen: false);
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      drawer: const DrawerScreen(),
      key: scaffoldKey,
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: size.width * .9,
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: Consumer<UserViewModel>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (value.userImageURl == null ||
                        value.userImageURl!.isEmpty ||
                        !value.userImageURl!.startsWith('http'))
                      ClipOval(
                        child: Image.asset(
                          profileimage,
                          height: size.height * (40 / size.height),
                          width: size.width * (40 / size.width),
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      ClipOval(
                        child: Image.network(
                          value.userImageURl.toString(),
                          height: size.height * (40 / size.height),
                          width: size.width * (40 / size.width),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              placeholderProfile,
                              height: size.height * (40 / size.height),
                              fit: BoxFit.cover,
                              width: size.width * (40 / size.width),
                            );
                          },
                        ),
                      ),
                  ],
                ).center(),
              ),
            ).paddingLeft(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text("Welcome",
                    fontSize: textSizeMedium,
                    fontWeight: FontWeight.w700,
                    color: textGreyColor),
                Consumer<UserViewModel>(
                    builder: (context, value, child) => text(
                        value.name.toString(),
                        fontSize: textSizeNormal,
                        fontWeight: FontWeight.w700,
                        color: black))
              ],
            ).paddingLeft(10),
          ],
        ),
        actions: [
          Consumer<UserViewModel>(
              builder: (context, value, child) => IconButton(
                  onPressed: () async {
                    try {
                      await value.getCurrentLocationPermission();

                      GoogleMapScreen(
                        coordinates: [value.mylat, value.mylng],
                        shopName: "Your Location",
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    } catch (e) {
                      // Handle the error here
                      utils().flushBar(
                          context, "You need to turn on the Location first.",
                          textcolor: Colors.white, backgroundColor: redColor);
                    }
                  },
                  icon: SvgPicture.asset(svg_current))).paddingRight(
              spacing_middle)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  var searchProvider =
                      Provider.of<SearchProvider>(context, listen: false);
                  const HomeSearch().launch(context).then((value) {
                    searchProvider.searchedProducts.clear();
                    searchProvider.searchedCategories.clear();
                    searchProvider.searchedSubCategories.clear();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff252525).withOpacity(0.11),
                            blurRadius: 15,
                            offset: const Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 20.0,
                      ),
                      text("Search here...",
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w400,
                              color: textGreyColor)
                          .paddingLeft(spacing_middle)
                    ],
                  ).paddingAll(15),
                )),
            FutureBuilder(
              future: HomeViewModel().getCurrentpointAPI(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: const CustomLoadingIndicator()
                          .paddingTop(spacing_middle));
                } else if (snapshot.hasError) {
                  return Center(
                          child: text(snapshot.error.toString(), maxLine: 10))
                      .paddingAll(10);
                } else if (!snapshot.hasData) {
                  return Center(child: text("No Current Point", maxLine: 10));
                } else {
                  var data = snapshot.data;
                  userViewModel.prestigePoint =
                      double.parse(data["currentPoint"].toStringAsFixed(1));
                  userViewModel.currentNira =
                      double.parse(data["equivalenceNaira"].toStringAsFixed(1));

                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colorPrimary),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        data == null || data.isEmpty
                            ? Center(
                                child: text("No Current Point",
                                    color: white, maxLine: 10))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  text(HomeScreen_TotalPrestige,
                                      fontSize: textSizeSMedium, color: white),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        svg_coin,
                                        height: 25,
                                      ),
                                      text("$HomeScreen_pts ${ammoutFormatter((data["currentPoint"] is double ? data["currentPoint"] : double.tryParse(data["currentPoint"].toString()))?.toInt() ?? 0)}",
                                              fontSize: textSizeSMedium,
                                              fontWeight: FontWeight.w500,
                                              color: white)
                                          .paddingLeft(spacing_standard),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                       "N ${ammoutFormatter((data["equivalenceNaira"] is double ? data["equivalenceNaira"] : double.tryParse(data["equivalenceNaira"].toString()))?.toInt() ?? 0)}",
                                     
                                      // "$HomeScreen_n ${ammoutFormatter((data["equivalenceNaira"] is double ? data["equivalenceNaira"] : double.tryParse(data["equivalenceNaira "].toString()))?.toInt() ?? 0)}",
                                      style: const TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis),
        ).paddingLeft(5),
                                  )
                                ],
                              ).paddingSymmetric(horizontal: spacing_middle),
                        const DottedLine(
                          direction: Axis.horizontal,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: white,
                        ).paddingOnly(left: 10, right: 5, top: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                              HomeScreen_Membership,
                              color: white,
                              fontSize: textSizeSMedium,
                            ),
                            text(
                              userViewModel.membership == true
                                  ? "Active"
                                  : "Non Active",
                              color: white,
                            )
                          ],
                        ).paddingOnly(
                          left: 10,
                          right: 10,
                          top: 10,
                        )
                      ],
                    ).paddingAll(spacing_middle),
                  ).paddingTop(spacing_twinty);
                }
              },
            ),
            InkWell(
              onTap: () {
                const ProductSeeAllScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              child: Row(
                children: [
                  text(HomeScreen_featured, fontWeight: FontWeight.w700),
                  const Spacer(),
                  text(
                    HomeScreen_seen,
                    fontWeight: FontWeight.w600,
                    fontSize: textSizeSMedium,
                    color: bgColor,
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: bgColor,
                  )
                ],
              ).paddingOnly(left: 10, top: spacing_twinty),
            ),
            Consumer<HomeViewModel>(
              builder: (context, feature, child) {
                if (feature.pageloading && feature.getAllProducts.isEmpty) {
                  return const CustomLoadingIndicator();
                } else if (feature.getAllProducts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: spacing_twinty),
                      child: Text("No Feature Product"),
                    ),
                  );
                } else {
                  return HorizontalList(
                    itemCount: (feature.getAllProducts.length > 5
                        ? 5
                        : feature.getAllProducts.length),
                    itemBuilder: (context, index) {
                      var product = feature.getAllProducts[index];

                      if (product == null) {
                        return Container(); // or any placeholder widget
                      }

                      var productId = product["_id"]?.toString() ?? '';
                      var images = product["images"] ?? [];
                      var slug = product["slug"]?.toString() ?? '';
                      var name = product["name"]?.toString() ?? '';
                      var price = product["price"] ?? 0;

                      if (productId.isEmpty) {
                        return Container(); // or any placeholder widget
                      }

                      return InkWell(
                        onTap: () {
                          if (productId.isNotEmpty) {
                            ProductDetailScreen(
                              slug: slug,
                            ).launch(context,
                                pageRouteAnimation: PageRouteAnimation.Fade);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 24,
                                offset: const Offset(0, 4),
                                spreadRadius: 0,
                                color: const Color(0xff000000).withOpacity(.1),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: size.height * 0.23,
                            width: size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        images.isNotEmpty
                                            ? images[0]
                                            : placeholderProduct,
                                        fit: BoxFit.cover,
                                        height: size.height * 0.16,
                                        width: size.width * 0.3,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              placeholderProduct);
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      right: -10,
                                      top: -6,
                                      child: IconButton(
                                        onPressed: () async {
                                          if (productId.isNotEmpty) {
                                            bool isFavorite =
                                                feature.favoriteProducts.any(
                                              (favProduct) =>
                                                  favProduct['productId']
                                                      ?["_id"] ==
                                                  productId,
                                            );

                                            if (isFavorite) {
                                              var favoriteProduct = feature
                                                  .favoriteProducts
                                                  .firstWhere(
                                                (favProduct) =>
                                                    favProduct['productId']
                                                        ?["_id"] ==
                                                    productId,
                                                orElse: () => null,
                                              );

                                              if (favoriteProduct != null) {
                                                String favoriteId =
                                                    favoriteProduct["_id"]
                                                            ?.toString() ??
                                                        '';

                                                try {
                                                  await feature
                                                      .removeFavoriteProduct(
                                                          favoriteId, context);
                                                  feature.favoriteProducts
                                                      .removeWhere(
                                                    (favProduct) =>
                                                        favProduct['productId']
                                                            ?["_id"] ==
                                                        productId,
                                                  );
                                                   feature.getAllProductsAPI(page, context);
    
                                                  feature.notifyListeners();
                                                } catch (e) {
                                                  if (kDebugMode) {
                                                    print(
                                                        'Error unfavoriting product: $e');
                                                  }
                                                }
                                              } else {
                                                if (kDebugMode) {
                                                  print(
                                                      'Favorite product not found in the list');
                                                }
                                              }
                                            } else {
                                              Map<String, dynamic> data = {
                                                "userId": userViewModel.userId
                                                    .toString(),
                                                "productId": productId,
                                                "shopId": product['shopId']
                                                        ?.toString() ??
                                                    ''
                                              };
                                              await feature.addFavoriteProduct(
                                                  data, context);
                                              feature.favoriteProducts.add(product);
                                                   feature.getFavoriteProducts(context);
                                              
                                              feature.notifyListeners();

                                            }
                                          }
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: feature.favoriteProducts.any(
                                            (favProduct) =>
                                                favProduct['productId']
                                                    ?["_id"] ==
                                                productId,
                                          )
                                              ? Colors.red
                                              : colorPrimary,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: textSizeSmall,
                                    fontWeight: FontWeight.w700,
                                  ).paddingOnly(
                                      left: spacing_control,
                                      top: spacing_standard),
                                ),
                                text(
                                  "N ${ammoutFormatter(price)}",
                                  fontSize: textSizeSMedium,
                                  fontWeight: FontWeight.w700,
                                  color: colorPrimary,
                                ).paddingOnly(left: 6),
                              ],
                            ).paddingBottom(spacing_middle),
                          ),
                        ).paddingLeft(10),
                      );
                    },
                  ).paddingTop(spacing_standard_new);
                }
              },
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              offerContiner(
                alig: Alignment.center,
                ontap: () {
                   PrestigeOffer().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                },
                color1: white,
                size: 12.0,
                show: false,
                color: textGreenColor,
                heigth: size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.33,
                text1: HomeScreen_prestigeoffer,
                image: coin2,
              ),
              offerContiner(
                alig: Alignment.center,
                ontap: () {
                  const GiftAndPointScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                },
                color1: white,
                size: 12.0,
                show: true,
                color: textGreenColor,
                heigth: size.height * 0.05,
                width: size.width * 0.38,
                text1: HomeScreen_giftpoint,
                image: coin2,
              ),
            ])
                .paddingTop(spacing_standard_new)
                .paddingSymmetric(horizontal: spacing_middle),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                for (int i = 0; i < slidingCardModel.length; i++)
                  SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      slidingCardModel[i].onTap),
                            );
                          },
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                              color:
                                  slidingCardModel[i].color?.withOpacity(0.13),
                              border: Border.all(
                                  color: slidingCardModel[i].bordercolor),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                text(slidingCardModel[i].text.toString(),
                                    fontSize: textSizeNormal,
                                    fontWeight: FontWeight.w600),
                                text(slidingCardModel[i].text1.toString(),
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500,
                                    isLongText: true,
                                    isCentered: true),
                                Container(
                                  height: size.height * 0.05,
                                  width: size.height * 0.2,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                        color: slidingCardModel[i].bordercolor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      text(
                                        slidingCardModel[i].text2.toString(),
                                        fontSize: textSizeSMedium,
                                      ),
                                      const SizedBox(width: 10),
                                      Image.asset(copy, height: 15),
                                    ],
                                  ),
                                ).paddingTop(10),
                              ],
                            ),
                          ).paddingRight(10),
                        ),
                      ],
                    ).paddingTop(10),
                  ),
              ],
            ).paddingTop(spacing_middle),
            text(HomeScreen_CATEGORIES, fontWeight: FontWeight.w700)
                .paddingTop(5),
            FutureBuilder(
              future: HomeViewModel().getcategoryapi(context),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: const CustomLoadingIndicator()
                          .paddingTop(spacing_middle));
                } else if (snapshot.hasError) {
                  return Center(
                      child: text(snapshot.error.toString(), maxLine: 10));
                } else if (!snapshot.hasData) {
                  return Center(child: text("No Categories", maxLine: 10));
                } else {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      // Determine crossAxisCount based on screen width
                      int crossAxisCount = constraints.maxWidth > 400
                          ? 5
                          : constraints.maxWidth > 300
                              ? 4
                              : 3;

                      double imageHeight =
                          constraints.maxWidth > 400 ? 100 : 90;
                      double imageWidth = constraints.maxWidth > 300 ? 90 : 90;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: (imageWidth / (imageHeight + 55)),
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              subcategorProvider.setCategory(
                                  snapshot.data['data'][index]['_id'], index);
                              const SubCategoriesScreen().launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Fade);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data['data'][index]['image']
                                        .toString(),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(placeholderProduct,fit: BoxFit.cover,);
                                    },
                                    height: imageHeight,
                                    width: imageWidth,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                text(
                                        snapshot.data['data'][index]['title']
                                            .toString(),
                                        fontSize: 13.44,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        isLongText: true)
                                    .paddingOnly(
                                        top: spacing_control,
                                        left: spacing_control)
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ).paddingTop(spacing_middle),
            elevatedButton(context, onPress: () {
              const Memberservicescreen()
                  .launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
            },
                    borderRadius: 8.0,
                    child: text(HomeScreen_member,
                        fontWeight: FontWeight.w600, color: white))
                .paddingTop(10),
            elevatedButton(
              context,
              backgroundColor: colorPrimary,
              bodersideColor: colorPrimary,
              onPress: () {
                const Mytransactionscreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              borderRadius: 8.0,
              child: text(HomeScreen_recent,
                  fontWeight: FontWeight.w600, color: white),
            ).paddingTop(10),
            elevatedButton(
              context,
              backgroundColor: colorPrimary,
              bodersideColor: colorPrimary,
              onPress: () {
                const ShopScreen().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              borderRadius: 8.0,
              child: text(HomeScreen_prestige,
                  color: white,
                  fontSize: textSizeMedium,
                  fontWeight: FontWeight.w600),
            ).paddingTop(10),
          ],
        ).paddingSymmetric(horizontal: 15, vertical: 20),
      ),
    );
  }
}
