import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/addToCart.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/viewModel/Prestigemdel.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class ProductSeeAllScreen extends StatefulWidget {
  const ProductSeeAllScreen({super.key});

  @override
  State<ProductSeeAllScreen> createState() => _ProductSeeAllScreenState();
}

class _ProductSeeAllScreenState extends State<ProductSeeAllScreen> {
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
        // if (page != 1 && provider.pageloading) {
          page++;
          provider.getAllProductsAPI(page, context); // Fetch next page
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text("All Products",
            fontSize: textSizeLargeMedium, fontWeight: FontWeight.w600),
        actions: [
          IconButton(
                  onPressed: () {
                    const AddToCart().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
              .paddingRight(5)
        ],
      ),
      body: Consumer<HomeViewModel>(
  builder: (context, feature, child) {
    if (feature.getAllProducts == null || feature.getAllProducts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: spacing_twinty),
          child: Text("No Products"),
        ),
      );
    } else {

      return LayoutBuilder(builder: (context, constraints) {
        double containerWidth = (constraints.maxWidth - 25) / 3;
              double containerHeight = containerWidth * 1.5;
              double imageHeight = containerHeight * 0.65;
              double imageWidth = containerWidth;
return     GridView.builder(
         shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: feature.getAllProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: containerWidth / containerHeight,
                ),
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
                ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
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
                            images.isNotEmpty ? images[0] : placeholderProduct,
                            fit: BoxFit.cover,
                            height: imageHeight,
                            width:imageWidth,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(placeholderProduct,height: imageHeight,fit: BoxFit.cover,
                            width:imageWidth,);
                            },
                          ),
                        ),
                        Positioned(
                          right: -10,
                          top: -6,
                          child: IconButton(
                            onPressed: () async {
                              if (productId.isNotEmpty) {
                                bool isFavorite = feature.favoriteProducts.any(
                                  (favProduct) => favProduct['productId']?["_id"] == productId,
                                );

                                if (isFavorite) {
                                  var favoriteProduct = feature.favoriteProducts.firstWhere(
                                    (favProduct) => favProduct['productId']?["_id"] == productId,
                                    orElse: () => null,
                                  );

                                  if (favoriteProduct != null) {
                                    String favoriteId = favoriteProduct["_id"]?.toString() ?? '';

                                    try {
                                      await feature.removeFavoriteProduct(favoriteId, context);
                                      feature.favoriteProducts.removeWhere(
                                        (favProduct) => favProduct['productId']?["_id"] == productId,
                                      );
                                      feature.notifyListeners();
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print('Error unfavoriting product: $e');
                                      }
                                    }
                                  } else {
                                    if (kDebugMode) {
                                      print('Favorite product not found in the list');
                                    }
                                  }
                                } else {
                                  Map<String, dynamic> data = {
                                    "userId": userViewModel.userId.toString(),
                                    "productId": productId,
                                    "shopId": product['shopId']?.toString() ?? ''
                                  };
                                  await feature.addFavoriteProduct(data, context);
                                  feature.favoriteProducts.add({
                                    "productId": {
                                      "_id": productId
                                    }
                                  });
                                  feature.notifyListeners();
                                }
                              }
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: feature.favoriteProducts.any(
                                (favProduct) => favProduct['productId']?["_id"] == productId,
                              ) ? Colors.red : colorPrimary,
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
                      ).paddingOnly(left: spacing_control, top: spacing_standard),
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
            ),
          );
        },
      ).paddingTop(spacing_standard_new);
   
      },).paddingSymmetric(horizontal: spacing_standard_new);
    }
  },
)
,

    );
  }
}
