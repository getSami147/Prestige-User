import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/addToCart.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:provider/provider.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> with TickerProviderStateMixin {
  void sortJsonListByTitle(List<dynamic> list) {
    list.sort((a, b) => a['title'].compareTo(b['title']));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: text("SUB CATEGORIES", fontSize: textSizeMedium, fontWeight: FontWeight.w700),
        actions: [
          IconButton(
              onPressed: () {
                const AddToCart().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
              },
              icon: const Icon(Icons.shopping_cart_outlined).paddingRight(10))
        ],
      ),
      body: FutureBuilder(
        future: HomeViewModel().getcategoryapi(context),
        builder: (context, AsyncSnapshot snapshotcategory) {
          if (snapshotcategory.connectionState == ConnectionState.waiting) {
            return Center(
                child: const CustomLoadingIndicator().paddingTop(spacing_middle));
          } else if (snapshotcategory.hasError) {
            return Center(
                child: text(snapshotcategory.error.toString(), maxLine: 10));
          } else if (!snapshotcategory.hasData) {
            return Center(child: text("No Categories", maxLine: 10));
          } else {
            return Column(
              children: [
                //Category
                SizedBox(height: size.height * 0.15,width: size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshotcategory.data['data'].length,
                    itemBuilder: (context, indexCategory) {
                      return Consumer<SubCategoryProvider>(
                        builder: (context, categoryProvider, child) {
                          return SizedBox(
                            width: size.width * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          categoryProvider.selectedSubCategoryId = "";
                                          categoryProvider.setCategory(
                                              snapshotcategory.data['data'][indexCategory]['_id'].toString(), indexCategory);
                                        },
                                        child: ColorFiltered(
                                          colorFilter: categoryProvider.selectedCategoryIndex == indexCategory
                                              ? ColorFilter.mode(colorPrimary.withOpacity(0.75), BlendMode.srcATop)
                                              : const ColorFilter.mode(transparentColor, BlendMode.srcATop),
                                          child: Image.network(
                                            snapshotcategory.data['data'][indexCategory]['image'],
                                            scale: 1.0,
                                            fit: BoxFit.fill,
                                            height: size.height * 0.12,
                                            width: size.width * 0.25,
                                            errorBuilder: (context, error, stackTrace) {
                            return Image.asset(placeholderProduct,fit: BoxFit.fill,
                                            height: size.height * 0.12,
                                            width: size.width * 0.25,);
                          },
                                          ),
                                        ),
                                      ),
                                      categoryProvider.selectedCategoryIndex == indexCategory
                                          ? const Icon(Icons.done, color: Colors.white, size: 25)
                                          : const SizedBox(),
                                    ],
                                  ),
                                ).paddingLeft(5),
                                text(snapshotcategory.data['data'][indexCategory]['title'].toString(),
                                    fontSize: 13.44, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500).paddingLeft(spacing_control)
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Single Get Category
                
                // Container(height: 400,width: 300,color: redColor,),
            
                Expanded(
                  child: Consumer<SubCategoryProvider>(builder: (context, subcategoryProvider, child) {
                    return FutureBuilder(
                      future: HomeViewModel().singlegetcategory(context, subcategoryProvider.selectedCategoryId),
                      builder: (context, AsyncSnapshot snapshotSubcategory) {
                        if (snapshotSubcategory.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: const CustomLoadingIndicator().paddingTop(spacing_middle)).paddingSymmetric(horizontal: spacing_twinty);
                        } else if (snapshotSubcategory.hasError) {
                          return Center(
                              child: text(snapshotSubcategory.error.toString(), maxLine: 10)).paddingSymmetric(vertical: spacing_twinty);
                        } else if (!snapshotSubcategory.hasData) {
                          return Center(child: text("No Subcategories", maxLine: 10));
                        } else {
                            if (snapshotSubcategory
                                        .data['subCategory'] != null) {
                          // debugPrint('sub Catagory ${snapshotSubcategory.data}');
                          dynamic subCategoryData = snapshotSubcategory.data['subCategory']
                              .where((element) => element['categoryId'] == subcategoryProvider.selectedCategoryId)
                              .toList();
                          sortJsonListByTitle(subCategoryData);
                    
                          dynamic myProducts =  snapshotSubcategory.data['products']
                              .where((element) => element['subCategory'] == subcategoryProvider.selectedSubCategoryId)
                              .toList();
                    
                          if (subcategoryProvider.selectedSubCategoryId!.isEmpty && subCategoryData.isNotEmpty) {
                            subcategoryProvider.setSubCategory(subCategoryData[0]['_id'].toString(), 0);
                            myProducts =  snapshotSubcategory.data['products'].where((element) => element['subCategory'] == subCategoryData[0]['_id']).toList();
                          }
                          debugPrint('subCategoryData ${subCategoryData}');
                    
                          return 
                          subCategoryData.isEmpty
                              ? const CustomLoadingIndicator()
                              : Column(
                                  children: [
                                    HorizontalList(
                                      itemCount: subCategoryData.length,
                                      itemBuilder: (context, indexSubcategory) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                subcategoryProvider.setSubCategory(subCategoryData[indexSubcategory]['_id'].toString(), indexSubcategory);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: subcategoryProvider.selectedSubCategoryIndex == indexSubcategory ? colorPrimary : white,
                                                  border: Border.all(
                                                      color: subcategoryProvider.selectedSubCategoryIndex == indexSubcategory
                                                          ? colorPrimary
                                                          : colorPrimary),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: text(subCategoryData[indexSubcategory]['title'], fontSize: textSizeSMedium,
                                                    color: subcategoryProvider.selectedSubCategoryIndex == indexSubcategory ? white : colorPrimary),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).paddingTop(spacing_middle),
                                   
                                   
                                    if (subcategoryProvider.selectedSubCategoryId!.isEmpty)
                                      const Text("Select the Tab first")
                                    else if (myProducts.isEmpty)
                                      text("No Products").paddingTop(spacing_twinty),
                                   for (int i = 0; i < subCategoryData.length; i++)
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: myProducts.length,
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, indexProduct) {
                                            if (myProducts[indexProduct]['subCategory'] == subCategoryData[i]['_id']) {
                                              return InkWell(
                                                onTap: () {
                                                  ProductDetailScreen(
                                                    slug: myProducts[indexProduct]['slug'].toString(),
                                                  ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: black.withOpacity(0.06),
                                                            offset: const Offset(0, 4),
                                                            blurRadius: 24)
                                                      ],
                                                      borderRadius: BorderRadius.circular(10)),
                                                  child: ListTile(
                                                    leading: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        myProducts[indexProduct]['images'][0].toString(),
                                                        fit: BoxFit.cover,
                                                        height: size.height * 0.1,
                                                        width: size.width * 0.2,
                                                        scale: 1.0,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Image.asset(placeholderProduct,fit: BoxFit.cover,
                                                        height: size.height * 0.1,
                                                        width: size.width * 0.2,);
                                                        },
                                                      ),
                                                    ),
                                                    title: text(myProducts[indexProduct]['name'], fontSize: textSizeMedium, fontWeight: FontWeight.w500),
                                                    subtitle: text(myProducts[indexProduct]['description'], fontSize: textSizeSmall,
                                                        fontWeight: FontWeight.w500, color: textGreyColor, overflow: TextOverflow.ellipsis, isLongText: true),
                                                    trailing: text("N ${ammoutFormatter(myProducts[indexProduct]['price'])}",
                                                        fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: colorPrimary, overflow: TextOverflow.ellipsis),
                                                  ),
                                                ).paddingTop(15),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ),
                                   
                                  ],
                                );
                                        }else {
                                      return Center(
                                          child: text("No Subcategories",
                                              maxLine: 10));
                                    }
                        }
                      },
                    );
                  }),
                ),
            
              ],
            );
          }
        },
      ).paddingTop(spacing_twinty).paddingSymmetric(horizontal: spacing_standard_new),
    );
  }
}
