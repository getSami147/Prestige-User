import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/addToCart.dart';
import 'package:prestige/view/homeScreen/dashboard.dart';
import 'package:prestige/view/favorite/favoriteProducts.dart';
import 'package:prestige/view/favorite/favoriteShops.dart';
import 'package:prestige/view/search/searchedFShopsFProducts.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  List favoritetext = [Fvoritescreen_Products, Fvoritescreen_Partners];
  @override
  Widget build(BuildContext context) {
    TabController control = TabController(length: 2, vsync: this);
    int selectedtab=0;
    print("selected tab: ${control.index}");
    setState(() {
      
    });
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(Fvoritescreen_Favorite,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
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
      
      body: Column(children: [
              InkWell(
                      onTap: () {
                   var searchProvider = Provider.of<SearchProvider>(context,listen: false);     
                   const SearchedFShopsFProducts().launch(context).then((value) {
                      searchProvider.searchedShops.clear();
                      searchProvider.searchedShops.clear();
                      
                   });
                      },
                      child: Container(
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
                          children: [
                            const Icon(
                              Icons.search,
                              size: 20.0,
                            ),
                            text("Search here...",fontSize: textSizeSMedium,)
                            .paddingLeft(spacing_middle)
                          ],
                        ).paddingAll(15),
                      )).paddingTop(20),
        
        TabBar(
          dividerHeight: 0,
            controller: control,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.only(right: 6),
            labelColor: black,
            unselectedLabelColor: const Color(0xff747688),
            indicatorColor: black,
            tabs: [
              for (int i = 0; i < favoritetext.length; i++) ...[
                Tab(
                  text: favoritetext[i].toString(),
                )
              ]
            ]).paddingTop(spacing_twinty),
       Expanded(
            child: TabBarView(controller: control, children: [
          FavoriteProductsScreen(),
          const FavoriteShops(),
        ]))
      ]).paddingSymmetric(horizontal: 15),
    );
  }
}
