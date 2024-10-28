import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:provider/provider.dart';

class Mytransactionscreen extends StatefulWidget {
  const Mytransactionscreen({super.key});

  @override
  State<Mytransactionscreen> createState() => _MytransactionscreenState();
}

class _MytransactionscreenState extends State<Mytransactionscreen> {
    int page=1;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.getMyTransactions(page, context); // Fetch initial data
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        
          page++;
          homeViewModel.getMyTransactions(page, context); // Fetch next page
        
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: text(MyTransaction_My_Transactions,
              fontSize: textSizeLarge, fontWeight: FontWeight.w700),
          
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            List transaction = value.myTransactions;
              // Sort the list in descending order by createdAt field
          transaction.sort((a, b) {
            DateTime dateA = DateTime.parse(a["createdAt"]);
            DateTime dateB = DateTime.parse(b["createdAt"]);
            return dateB.compareTo(dateA); // For descending order
          });
            if (value.pageloading && transaction.isEmpty) {
              return const Center(child: CustomLoadingIndicator());
            } else if (transaction.isEmpty) {
              return const Center(child: Text("No Transaction"));
            } else {
              return SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),

                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: transaction.length,
                      itemBuilder: (context, transactionindex) {

                        // if (kDebugMode) {
                        //   print("TLength: ${transaction.length}");
                        // }
                        return Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.11,
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
                                leading: SvgPicture.asset(
                                  svg_SplashIcon,
                                  height: 35,
                                ),
                                title: text(
                                    transaction[transactionindex]["paymentMethod"].toString(),
                                    fontSize: textSizeSMedium,
                                    fontWeight: FontWeight.w500,
                                    isLongText: true),
                                subtitle: text(formatDateTime(transaction[transactionindex]["createdAt"].toString(),) ,
                                    fontSize: textSizeSmall,
                                    fontWeight: FontWeight.w400,
                                    color: colorSecondary),
                                trailing: Column(
                                  children: [
                                    text(
                                    "N ${ammoutFormatter(double.parse(transaction[transactionindex]["amount"].toString()).toInt())}",

                                      fontSize: textSizeSMedium,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    text(
                                       "${(transaction[transactionindex]["PrestigePoint"].toString().toInt())} Points ",
                                        color: colorPrimary,
                                        fontSize: textSizeSMedium,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ))).paddingTop(10);
                                
                      },
                    ).paddingSymmetric(horizontal: 15),
                                        SizedBox(height: 30,),

                    if (page!=1&& value.pageloading)
                      const CircularProgressIndicator()
                          .paddingTop(spacing_thirty)
                  ],
                ),
              );
            }
          },
        ));
  }
}

class customcontainerrow extends StatelessWidget {
  String? text1;
  VoidCallback? ontap;
  Color? color, color1, color2;
  var size;
  customcontainerrow({
    this.size,
    this.color,
    this.color1,
    this.color2,
    this.ontap,
    this.text1,
    super.key,
    required this.orientation,
  });

  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.07
            : MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.06),
                  offset: Offset(0, 4),
                  blurRadius: 24)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text(text1.toString(),
                    fontSize: size,
                    fontWeight: FontWeight.w600,
                    color: color1)
                .paddingLeft(10),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                  color: color2,
                ))
          ],
        ),
      ).paddingTop(20),
    );
  }
}
