
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/view/categories/subCategoriesscreen.dart';
import 'package:prestige/view/search/GetAllSearchProduct.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:provider/provider.dart';

class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  int page = 1;
  @override
  void initState() {
    super.initState();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // When the user reaches the end of the list, load more data
        if (!searchProvider.pageloading) {
          page++;
          searchProvider.searchProductCategory(
              page, searchController.text.trim().toString());
          // Fetch next page
        }
      }
    });
    searchProvider.searchedProducts.clear();
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
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
        return Stack(alignment: Alignment.center,
          children: [
            Column(
              children: [
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
                          valueKey.searchedProducts.clear();
                          valueKey.searchProductCategory(
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
                                valueKey.searchedProducts.clear();
                                valueKey.searchProductCategory(
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
                      valueKey.searchedProducts.isEmpty&&valueKey.searchedCategories.isEmpty&&valueKey.searchedSubCategories.isEmpty?text(""):
                   Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //searched-Products......................................................>>>
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double containerWidth = (constraints.maxWidth - 40) / 3;
                            double containerHeight = containerWidth * 1.8;
                            double imageHeight = containerHeight * 0.65;
                            double imageWidth = containerWidth;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    text("Products",
                                            fontWeight: FontWeight.w700,
                                            color: black)
                                        .paddingTop(spacing_twinty),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text("See All",
                                                fontSize: textSizeSMedium,
                                                color: colorPrimary,
                                                fontWeight: FontWeight.w500)
                                            .onTap(() {
                                          page = 1;
                                          valueKey.searchedProducts.clear();
                                          valueKey.searchProductCategory(
                                              page, searchController.text.trim());
                                          GetAllSearchProduct(
                                            searchedValue:
                                                searchController.text.toString(),
                                          ).launch(context);
                                        }),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio:
                                        containerWidth / containerHeight,
                                  ),
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: (valueKey.searchedProducts.length > 3
                                      ? 3
                                      : valueKey.searchedProducts.length),
                                  controller: scrollController,
                                  itemBuilder: (context, index) {
                                    var searchData =
                                        valueKey.searchedProducts[index];
                                    return InkWell(
                                        onTap: () {
                                                ProductDetailScreen(
                                                  slug:
                                                      searchData["slug"].toString(),
                                                ).launch(context,
                                                    pageRouteAnimation:
                                                        PageRouteAnimation.Fade);
                                              },
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: colorPrimary.withOpacity(.1),
                                                blurRadius: 7,
                                                spreadRadius: 3,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  searchData["images"][0]
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  height: imageHeight,
                                                  width: imageWidth,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  text(
                                                    searchData["name"].toString(),
                                                    fontSize: textSizeSmall,
                                                    fontWeight: FontWeight.w700,
                                                  ).paddingTop(spacing_middle),
                                                  text(
                                                    "N ${ammoutFormatter(searchData["price"].toString().toInt())}",
                                                    fontSize: textSizeSMedium,
                                                    fontWeight: FontWeight.w700,
                                                    color: textGreenColor,
                                                  ),
                                                ],
                                              ).paddingSymmetric(
                                                horizontal: 8,
                                              ),
                                            ],
                                          )).paddingTop(spacing_twinty),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ).paddingSymmetric(horizontal: spacing_standard_new),
            
                        //searched-Categories......................................................>>>
                    // valueKey.searchedCategories.isEmpty?text("") :   LayoutBuilder(
                    //       builder: (context, constraints) {
                    //         double containerWidth = (constraints.maxWidth - 40) / 3;
                    //         double containerHeight = containerWidth * 1.8;
                    //         double imageHeight = containerHeight * 0.65;
                    //         double imageWidth = containerWidth;
                    //         return Column(
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //               crossAxisAlignment: CrossAxisAlignment.end,
                    //               children: [
                    //                 text("Categories",
                    //                         fontWeight: FontWeight.w700,
                    //                         color: black)
                    //                     .paddingTop(spacing_twinty),
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     text("See All",
                    //                             fontSize: textSizeSMedium,
                    //                             color: colorPrimary,
                    //                             fontWeight: FontWeight.w500)
                    //                         .onTap(() {
                    //                       page = 1;
                    //                       valueKey.searchedCategories.clear();
                    //                       valueKey.searchProductCategory(
                    //                           page, searchController.text.trim());
                    //                       GetAllSearchProduct(
                    //                         searchedValue:
                    //                             searchController.text.toString(),
                    //                       ).launch(context);
                    //                     }),
                    //                     const Icon(
                    //                       Icons.arrow_forward,
                    //                       size: 20,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             GridView.builder(
                    //               gridDelegate:
                    //                   SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 3,
                    //                 crossAxisSpacing: 10,
                    //                 mainAxisSpacing: 10,
                    //                 childAspectRatio:
                    //                     containerWidth / containerHeight,
                    //               ),
                    //               shrinkWrap: true,
                    //               physics: const BouncingScrollPhysics(),
                    //               itemCount:
                    //                   (valueKey.searchedCategories.length > 3
                    //                       ? 3
                    //                       : valueKey.searchedCategories.length),
                    //               controller: scrollController,
                    //               itemBuilder: (context, index) {
                    //                 var searchData =
                    //                     valueKey.searchedCategories[index];
                    //                 return Container(
                    //                     alignment: Alignment.center,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       borderRadius: BorderRadius.circular(10),
                    //                       boxShadow: [
                    //                         BoxShadow(
                    //                           color: colorPrimary.withOpacity(.1),
                    //                           blurRadius: 7,
                    //                           spreadRadius: 3,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     child: Consumer<SubCategoryProvider>(builder: (context, subvalue, child) {
                    //                       return  InkWell(
                    //                          onTap: () {
                    //               subvalue.selectedCategoryId=searchData['_id'];
                    //               const SubCategoriesScreen(
                    //               ).launch(context,
                    //                   pageRouteAnimation: PageRouteAnimation.Fade);
                    //                           },
                    //                         child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment.start,
                    //                         children: [
                    //                           ClipRRect(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(10),
                    //                             child: Image.network(
                    //                               searchData["image"].toString(),
                    //                               fit: BoxFit.cover,
                    //                               height: imageHeight,
                    //                               width: imageWidth,
                    //                             ),
                    //                           ),
                    //                           Column(
                    //                             crossAxisAlignment:
                    //                                 CrossAxisAlignment.start,
                    //                             children: [
                    //                               text(
                    //                                 searchData["title"].toString(),
                    //                                 fontSize: textSizeSmall,
                    //                                 fontWeight: FontWeight.w700,
                    //                               ).paddingTop(spacing_middle),
                    //                               text(
                    //                                 searchData["type"].toString(),
                    //                                 fontSize: textSizeSMedium,
                    //                                 fontWeight: FontWeight.w700,
                    //                                 color: textGreenColor,
                    //                               ),
                    //                             ],
                    //                           ).paddingSymmetric(
                    //                             horizontal: 8,
                    //                           ),
                    //                         ],
                    //                                                                 ),
                    //                       );
                    //                     },)
                                       
                    //                     ).paddingTop(spacing_twinty);
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     ).paddingSymmetric(horizontal: spacing_standard_new),
                      
                        //searched-subCategories......................................................>>>
              //  valueKey.searchedSubCategories.isEmpty?text(""):         LayoutBuilder(
              //             builder: (context, constraints) {
              //               double containerWidth = (constraints.maxWidth - 40) / 3;
              //               double containerHeight = containerWidth * 1.8;
              //               double imageHeight = containerHeight * 0.65;
              //               double imageWidth = containerWidth;
              //               return Column(
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       text("sub Categories",
              //                               fontWeight: FontWeight.w700,
              //                               color: black)
              //                           .paddingTop(spacing_twinty),
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           text("See All",
              //                                   fontSize: textSizeSMedium,
              //                                   color: colorPrimary,
              //                                   fontWeight: FontWeight.w500)
              //                               .onTap(() {
              //                             page = 1;
              //                             valueKey.searchedSubCategories.clear();
              //                             valueKey.searchProductCategory(
              //                                 page, searchController.text.trim());
              //                             GetAllSearchProduct(
              //                               searchedValue:
              //                                   searchController.text.toString(),
              //                             ).launch(context);
              //                           }),
              //                           const Icon(
              //                             Icons.arrow_forward,
              //                             size: 20,
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                   // GridView.builder(
              //                   //   gridDelegate:
              //                   //       SliverGridDelegateWithFixedCrossAxisCount(
              //                   //     crossAxisCount: 3,
              //                   //     crossAxisSpacing: 10,
              //                   //     mainAxisSpacing: 10,
              //                   //     childAspectRatio:
              //                   //         containerWidth / containerHeight,
              //                   //   ),
              //                   //   shrinkWrap: true,
              //                   //   physics: const BouncingScrollPhysics(),
              //                   //   itemCount:
              //                   //       (valueKey.searchedSubCategories.length > 3
              //                   //           ? 3
              //                   //           : valueKey.searchedSubCategories.length),
              //                   //   controller: scrollController,
              //                   //   itemBuilder: (context, index) {
              //                   //     var searchData =
              //                   //         valueKey.searchedSubCategories[index];
              //                   //     return Container(
              //                   //         alignment: Alignment.center,
              //                   //         decoration: BoxDecoration(
              //                   //           color: Colors.white,
              //                   //           borderRadius: BorderRadius.circular(10),
              //                   //           boxShadow: [
              //                   //             BoxShadow(
              //                   //               color: colorPrimary.withOpacity(.1),
              //                   //               blurRadius: 7,
              //                   //               spreadRadius: 3,
              //                   //             ),
              //                   //           ],
              //                   //         ),
              //                   //         child: Consumer<SubCategoryProvider>(builder: (context, subvalue, child) {
              //                   //           return InkWell(
              //                   //              onTap: () {
              //                   //   subvalue.selectedCategoryId=searchData['categoryId'].toString();
              //                   //   subvalue.selectedSubCategoryIndex=searchData['_id'].toString().toInt();
              //                   //   const SubCategoriesScreen(
              //                   //   ).launch(context,
              //                   //       pageRouteAnimation: PageRouteAnimation.Fade);
              //                   //               },
              //                   //             child: Column(
              //                   //             crossAxisAlignment:
              //                   //                 CrossAxisAlignment.start,
              //                   //             children: [
              //                   //               ClipRRect(
              //                   //                 borderRadius:
              //                   //                     BorderRadius.circular(10),
              //                   //                 child: Image.network(
              //                   //                   searchData["image"].toString(),
              //                   //                   fit: BoxFit.cover,
              //                   //                   height: imageHeight,
              //                   //                   width: imageWidth,
              //                   //                 ),
              //                   //               ),
              //                   //               Column(
              //                   //                 crossAxisAlignment:
              //                   //                     CrossAxisAlignment.start,
              //                   //                 children: [
              //                   //                   text(
              //                   //                     searchData["title"].toString(),
              //                   //                     fontSize: textSizeSmall,
              //                   //                     fontWeight: FontWeight.w700,
              //                   //                   ).paddingTop(spacing_middle),
              //                   //                   text(
              //                   //                     searchData["type"].toString(),
              //                   //                     fontSize: textSizeSMedium,
              //                   //                     fontWeight: FontWeight.w700,
              //                   //                     color: textGreenColor,
              //                   //                   ),
              //                   //                 ],
              //                   //               ).paddingSymmetric(
              //                   //                 horizontal: 8,
              //                   //               ),
              //                   //             ],
              //                   //                                                     ),
              //                   //           );
              //                   //         },)
                                        
                                        
              //                   //         ).paddingTop(spacing_twinty);
              //                   //   },
              //                   // ),
                             
              //                 ],
              //               );
              //             },
              //           ).paddingSymmetric(horizontal: spacing_standard_new),
                      
                      ],
                    ),
                  ),
                ),
              ],
            ),
        valueKey.pageloading?const CustomLoadingIndicator():  valueKey.searchedProducts.isEmpty&&valueKey.searchedCategories.isEmpty&&valueKey.searchedSubCategories.isEmpty?text("No Document found"):const SizedBox(),
          
          ],
        );
      }),
    );
  }
}
