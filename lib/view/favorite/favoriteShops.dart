import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/view/shops/storedetail.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class FavoriteShops extends StatefulWidget {
  const FavoriteShops({super.key});

  @override
  State<FavoriteShops> createState() => _FavoriteShopsState();
}

class _FavoriteShopsState extends State<FavoriteShops> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<HomeViewModel>(context, listen: false);
    provider.getfavouriteShop(context);
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);

    return Consumer<HomeViewModel>(
      builder: (context, shopValue, child) {
        if (shopValue.pageloading&& shopValue.favoriteShops.isEmpty) {
          return Center(
            child: const CustomLoadingIndicator().paddingTop(spacing_twinty),
          );
        }
        if (shopValue.favoriteShops.isEmpty) {
          return  Center(
            child: text(
              "No Shop Partners",
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await shopValue.getfavouriteShop(context);
          },
          child: ListView.builder(
            itemCount: shopValue.favoriteShops.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {

              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ShopDetailscreen(
                        slug: shopValue.favoriteShops[index]['shopId']
                                ['slug']
                            .toString(),
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                      // print(
                      //     "Slug: ${shopValue.favoriteShops['data'][index]['shopId']['slug']}");
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.06),
                                  offset: Offset(0, 4),
                                  blurRadius: 24)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              shopValue.favoriteShops[index]['shopId']
                                      ['coverImage'][0]
                                  .toString(),
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
                              shopValue.favoriteShops[index]['shopId']
                                      ['title']
                                  .toString(),
                              fontSize: textSizeMedium,
                              fontWeight: FontWeight.w500),
                          trailing: IconButton(
                              onPressed: () async {
                                await shopValue.removefavoriteshop(
                                    shopValue.favoriteShops[index]
                                        ['_id'],
                                    context);

                                      shopValue.favoriteShops.removeWhere(
                                        (shop) => shop["shopId"]["_id"] ==shopValue.favoriteShops[index]
                                        ["shopId"]["_id"].toString(),
                                      );
                                      shopValue.notifyListeners();

                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: redColor,
                              )),
                        )).paddingTop(10),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
