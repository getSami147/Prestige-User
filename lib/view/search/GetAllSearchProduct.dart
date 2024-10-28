
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:provider/provider.dart';

class GetAllSearchProduct extends StatefulWidget {
  var searchedValue;
   GetAllSearchProduct({required this.searchedValue, super.key});

  @override
  _GetAllSearchProductState createState() => _GetAllSearchProductState();
}

class _GetAllSearchProductState extends State<GetAllSearchProduct> {
  ScrollController scrollController = ScrollController();

  int page = 1;
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
        if (page!=1&& provider.pageloading) {
          page++;
          provider.getAllProductsAPI(page, context); // Fetch next page
        }
      }
    });
}


  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
      ),
      body: Consumer<SearchProvider>(builder: (context, valueKey, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text("Products", fontWeight: FontWeight.w700, color: black)
                .paddingSymmetric(horizontal: spacing_standard_new)
                .paddingTop(spacing_twinty),
         
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                   double containerWidth = (constraints.maxWidth - 40) / 3;
                    double containerHeight = containerWidth * 1.8;
                    double imageHeight = containerHeight * 0.65;
                    double imageWidth = containerWidth;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: containerWidth / containerHeight,
                      ),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: valueKey.searchedProducts.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        var searchData = valueKey.searchedProducts[index];
                        return Container(
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
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                    onTap: () {
                                      ProductDetailScreen(
                                        slug: searchData["slug"].toString(),
                                      ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        searchData["images"][0].toString(),
                                        fit: BoxFit.cover,
                                        height: imageHeight,
                                        width: imageWidth,
                                      ),
                                    ),
                                  ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                              ).paddingSymmetric(horizontal: 8,),
                            ],
                          )
                        ).paddingTop(spacing_twinty);
                      },
                    );
                  },
                ).paddingSymmetric(horizontal: spacing_standard_new),
              ),
            ),
          ],
        );
      }),
    );
  }
}
