import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/shops/storedetail.dart';
import 'package:prestige/view/search/searchedFShopsFProducts.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int page = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.getfavouriteShop(context).then((_) {
        provider.getAllShops(page, context); // Fetch initial shop data
      });
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Load more data when reaching the end of the list
        if (!provider.pageloading) {
          page++;
          provider.getAllShops(page, context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: text(
          "Partners",
          fontSize: textSizeLarge,
          fontWeight: FontWeight.w700,
        ),
        actions: [const Icon(Icons.shopping_cart_outlined).paddingRight(10)],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          if (value.pageloading && value.getAllShopData.isEmpty) {
            return const Center(child: CustomLoadingIndicator());
          } else if (value.getAllShopData.isEmpty) {
            return Center(child: text("No Shop"));
          } else {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    var searchProvider =
                        Provider.of<SearchProvider>(context, listen: false);
                    const SearchedFShopsFProducts().launch(context).then((_) {
                      searchProvider.searchedShops.clear();
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
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 20.0),
                        text("Search here...", fontSize: textSizeSMedium)
                            .paddingLeft(spacing_middle),
                      ],
                    ).paddingAll(15),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await value.getAllShops(page, context);
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: value.getAllShopData.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var shopData = value.getAllShopData[index];
                        bool isFavorite = value.favoriteShops.any(
                          (shop) =>
                              shop["shopId"]["_id"] ==
                              shopData['_id'].toString(),
                        );

                        return GestureDetector(
                          onTap: () {
                            ShopDetailscreen(
                              slug: shopData['slug'].toString(),
                            ).launch(context,
                                pageRouteAnimation: PageRouteAnimation.Fade);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.06),
                                  offset: const Offset(0, 4),
                                  blurRadius: 24,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  shopData['coverImage'][0].toString(),
                                  fit: BoxFit.cover,
                                  height: size.height * 0.08,
                                  width: size.width * 0.16,
                                  errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,fit: BoxFit.cover,
                                  height: size.height * 0.08,
                                  width: size.width * 0.16,);
                        },
                                ),
                              ),
                              title: text(
                                shopData['title'].toString(),
                                fontSize: textSizeSMedium,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: text(
                                shopData['description'].toString(),
                                fontSize: textSizeSmall,
                                fontWeight: FontWeight.w400,
                                color: textGreyColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  var userViewModel=Provider.of<UserViewModel>(context,listen: false);
                                if (isFavorite) {
                                  var favoriteShop = value.favoriteShops.firstWhere(
                                    (shop) => shop["shopId"]["_id"] == shopData['_id'].toString(),
                                    orElse: () => null,
                                  );

                                  if (favoriteShop != null) {
                                    String favoriteId = value.favoriteShops[index]["_id"];

                                    try {
                                      // Attempt to remove the favorite shop
                                      await value.removefavoriteshop(favoriteId, context);

                                      // Remove from local list immediately to update UI
                                      value.favoriteShops.removeWhere(
                                        (shop) => shop["shopId"]["_id"] == shopData['_id'].toString(),
                                      );

                                      // Notify listeners to update the UI
                                      value.notifyListeners();

                                      // Optionally, refresh the favorite shops from the API
                                      // await value.getfavouriteShop(context);
                                    } catch (e) {
                                      print('Error unfavoriting shop: $e');
                                    }
                                  } else {
                                    print('Favorite shop not found in the list');
                                  }
                                } else {
                                  // Add to favorites
                                  Map<String, String> data = {
                                    "userId": userViewModel.userId.toString(),
                                    "shopId": shopData['_id'].toString(),
                                  };
                                  await value.addFavoriteShop(data, context);
                                  await value.getfavouriteShop(context);


                                  // Add to local list immediately to update UI
                                  // value.favoriteShops.add({
                                  //   "shopId": {"_id": shopData['_id'].toString()}
                                  // });

                                  // Notify listeners to update the UI
                                  value.notifyListeners();

                                  // Optionally, refresh the favorite shops from the API
                                }
                              },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: isFavorite ? Colors.red : colorPrimary,
                                ),
                              ),
                            ),
                          ).paddingTop(10),
                        );
                      },
                    ),
                  ),
                ),
                if (page!=1&& value.pageloading)
                  const CircularProgressIndicator().paddingTop(spacing_middle),
              ],
            );
          }
        },
      ).paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }
}
