import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/shops/storedetail.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:provider/provider.dart';

import '../products/productdetail.dart';

class SearchedFShopsFProducts extends StatefulWidget {
  const SearchedFShopsFProducts({super.key});

  @override
  _SearchedFShopsFProductsState createState() =>
      _SearchedFShopsFProductsState();
}

class _SearchedFShopsFProductsState extends State<SearchedFShopsFProducts> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int page = 1;
  @override
  void initState() {
    super.initState();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // When the user reaches the end of the list, load more data
        // if (!searchProvider.pageloading) {
          page++;
          searchProvider.searchedFShopsFProduct(
              page, searchController.text.trim().toString());
          // Fetch next page
        // }
      }
    });
  }

  @override
  void dispose() {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    print("dispose");
    scrollController.removeListener(() {});
    searchController.clear();
    searchController.dispose();
    searchProvider.searchedShops.clear();
    searchProvider.searchedProducts.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
      ),
      body: Consumer<SearchProvider>(builder: (context, valueKey, child) {
        return Column(
          children: [
            // TextFormField Search
            Center(
              child: Container(
                height: 45,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.1),
                          spreadRadius: 5,
                          blurRadius: 5)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (value) {
                      page = 1;
                      valueKey.searchedShops.clear();
                      valueKey.searchedFShopsFProduct(
                          page, searchController.text.trim());
                    },
                    autofocus: true,
                    cursorColor: colorPrimary,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: InkWell(
                          onTap: () {
                            page = 1;
                            valueKey.searchedShops.clear();
                            valueKey.searchedFShopsFProduct(
                                page, searchController.text.trim());
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                 valueKey.searchedShops.isEmpty
                        ? text("")
                        : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //searchedShopsAPI......................................................>>>
                              text("Favorite Shop",
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSizeLargeMedium)
                                  .paddingOnly(
                                      left: spacing_twinty,
                                      top: spacing_twinty),
                        
                              ListView.builder(
                                itemCount: valueKey.searchedShops.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      ShopDetailscreen(
                                        slug: valueKey.searchedShops[index]
                                                ["shopId"]['slug']
                                            .toString(),
                                      ).launch(context,
                                          pageRouteAnimation:
                                              PageRouteAnimation.Fade);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      black.withOpacity(0.06),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 24)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                valueKey.searchedShops[index]
                                                        ["shopId"]['coverImage']
                                                        [0]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                height: size.height * 0.08,
                                                width: size.width * 0.16,
                                              ),
                                            ),
                                            title: text(
                                              valueKey.searchedShops[index]
                                                      ["shopId"]['title']
                                                  .toString(),
                                              fontSize: textSizeSMedium,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            subtitle: text(
                                              valueKey.searchedShops[index]
                                                      ["shopId"]['description']
                                                  .toString(),
                                              fontSize: textSizeSmall,
                                              fontWeight: FontWeight.w400,
                                              color: textGreyColor,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            trailing:
                                                Consumer<HomeViewModel>(
                                              builder: (context, shopValue, child) {
                                                return 
                                                IconButton(
                                onPressed: () async {
                              

                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: redColor,
                              ));
                                              },
                                            )
                                            )
                                            ).paddingTop(10),
                                  );
                                },
                              ),
                              valueKey.searchedProducts.isEmpty
                                  ? text("No Favorite Products ").paddingTop(spacing_twinty)
                                  : text("Favorite Products",
                                          fontWeight: FontWeight.w500,
                                          fontSize: textSizeLargeMedium)
                                      .paddingOnly(
                                          left: spacing_twinty,
                                          top: spacing_twinty)
                            ],
                          ),
                        ),
                
                    //searchedProductsAPI...........................................
                     valueKey.pageloading
                    ? const CustomLoadingIndicator()
                    : valueKey.searchedProducts.isEmpty
                        ? text("No Favorite Products")
                        : RefreshIndicator(onRefresh: () async {
                          await valueKey.searchedFShopsFProduct(page, "");
                        }, child: LayoutBuilder(
                          builder: (context, constraints) {
                double containerWidth = (constraints.maxWidth - 40) / 3;
                double containerHeight = containerWidth * 1.8;
                double imageHeight = containerHeight * 0.65;
                double imageWidth = containerWidth;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: valueKey.searchedProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: containerWidth / containerHeight,
                  ),
                  itemBuilder: (context, index) {
                    var filterData = valueKey.searchedProducts[index];
                   
                    return InkWell(
                      onTap: () {
                        ProductDetailScreen(
                          slug: filterData['productId']['slug'].toString(),
                        ).launch(context,
                            pageRouteAnimation: PageRouteAnimation.Fade);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  filterData['productId']["images"][0].toString(),
                                  fit: BoxFit.cover,
                                  height: imageHeight,
                                  width: imageWidth,
                                ),
                              ),
                              Consumer<HomeViewModel>(builder: (context, value, child) {
                                return   Positioned(
                                top: -10,
                                right: -8,
                                child: IconButton(
                                  onPressed: () async {
                                 
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                              },)
                            
                            ],
                          ),
                          Text(
                            filterData['productId']["name"].toString(),
                            style: const TextStyle(
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w700,color: colorPrimary
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                           "N ${ammoutFormatter(filterData['productId']["price"])}",
                            style: const TextStyle(
                              fontSize: textSizeSMedium,
                              fontWeight: FontWeight.w700,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).paddingTop(20);
                          },
                        )
                        ),
                  ],
                ),
              ),
            ),
           
          ],
        ).paddingTop(spacing_twinty);
      }).paddingSymmetric(horizontal: 16),
    );
  }
}
