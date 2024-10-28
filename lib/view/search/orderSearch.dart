
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/products/productdetail.dart';
import 'package:prestige/view/categories/subCategoriesscreen.dart';
import 'package:prestige/view/search/GetAllSearchProduct.dart';
import 'package:prestige/view/order/orderdetail.dart';
import 'package:prestige/view/order/orderhistory.dart';
import 'package:prestige/viewModel/subCategoryProvider.dart';
import 'package:prestige/viewModel/searchProvider.dart';
import 'package:provider/provider.dart';

class OrderSearch extends StatefulWidget {
  const OrderSearch({super.key});

  @override
  _OrderSearchState createState() => _OrderSearchState();
}

class _OrderSearchState extends State<OrderSearch> {
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
          searchProvider.searchOrders(
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
                          valueKey.searchedOrders.clear();
                          valueKey.searchOrders(
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
                                valueKey.searchedOrders.clear();
                                valueKey.searchOrders(
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
                      // valueKey.searchedOrders.isEmpty?text(""):
                   Expanded(
                  child: 
                  SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: valueKey.searchedOrders.length,
                              // +
                              //     (viewModel.orderloading ? 1 : 0),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                 var searchData =
                                        valueKey.searchedOrders[index];
                                return Customorder(
                                  image: pending,
                                  title: searchData["orderNo"]
                                      .toString(),
                                  subTitle: DateFormat("yMMMMEEEEd").format(
                                      DateTime.parse(searchData
                                              ["createdAt"]
                                          .toString())),
                                  endTrialing: "View", onTapEndTrialing: () {
                                     // view Details
                                    Orderdetailscreen(
                                            id:searchData["_id"]
                                                .toString())
                                        .launch(context,
                                            pageRouteAnimation:
                                                PageRouteAnimation.Fade);
                                    },
                                );
                              },
                            ).paddingSymmetric(horizontal: 15),
                          ),

                ),
              ],
            ),
        valueKey.pageloading?const CustomLoadingIndicator():valueKey.searchedOrders.isEmpty?text("No Document found"):const SizedBox(),
          
          ],
        );
      }),
    );
  }
}
