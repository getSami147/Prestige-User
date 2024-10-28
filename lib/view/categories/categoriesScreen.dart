import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/addToCart.dart';
import 'package:prestige/view/categories/subCategoriesscreen.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: text(HomeScreen_CATEGORIES,
            fontSize:textSizeMedium, fontWeight: FontWeight.w700),
        actions: [
          IconButton(
              onPressed: () {
                const AddToCart().launch(context,
                    pageRouteAnimation: PageRouteAnimation.Fade);
              },
              icon: const Icon(Icons.shopping_cart_outlined).paddingRight(10))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Consumer<SubCategoryProvider>(builder: (context, subcategorProvider, child) {
              return   FutureBuilder(
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
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data['data'].length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                            childAspectRatio:
                                orientation == Orientation.portrait ? 0.61 : 0.8
                            //mainAxisExtent: 120
                            ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                             subcategorProvider.setCategory(subcategorProvider.selectedCategoryId=snapshot.data['data'][index]['_id'], index);

                              const SubCategoriesScreen(
                              ).launch(context,
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
                                    height: orientation == Orientation.portrait
                                        ? size.height * .1
                                        : size.height * .4,
                                    width: orientation == Orientation.portrait
                                        ? size.width * 9
                                        : size.width,
                                    fit: BoxFit.fill,
                                     errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProduct,height: orientation == Orientation.portrait
                                        ? size.height * .1
                                        : size.height * .4,
                                    width: orientation == Orientation.portrait
                                        ? size.width * 9
                                        : size.width,
                                    fit: BoxFit.fill,);
                        },
                                  ),
                                ),
                                Center(
                                  child: text(
                                      snapshot.data['data'][index]['title']
                                          .toString(),
                                      fontSize: 13.44,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      isLongText: true).paddingOnly(top: spacing_control,left: spacing_control),
                                )
                              ],
                            ),
                          );
                        });
                  }
                });
         
            },)
           ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }
}
