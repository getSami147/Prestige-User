import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() =>
      _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text("Help and FAQs",
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: FutureBuilder(
            future: HomeViewModel().getFaqs(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: const CustomLoadingIndicator()
                        .paddingTop(spacing_middle));
              } else if (snapshot.hasError) {
                return Center(
                        child: text(snapshot.error.toString(),
                            isCentered: true, maxLine: 10))
                    .paddingSymmetric(horizontal: spacing_standard_new);
              } else if (!snapshot.hasData) {
                return Center(child: text("No points Found ", maxLine: 10));
              } else {
    return snapshot.data["data"].isEmpty?const Center(child: Text("No data")):
     ListView.builder(
             physics: const BouncingScrollPhysics(),
             shrinkWrap: true,
             itemCount: snapshot.data["data"].length,
             itemBuilder: (context, index) {
               var data = snapshot.data["data"][index];
               return ExpansionTile(expandedCrossAxisAlignment: CrossAxisAlignment.start,
                 shape: const RoundedRectangleBorder(side: BorderSide.none),
                 initiallyExpanded: false,
                 iconColor: colorPrimary,
                 tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                 title: text(data["title"].toString(),
                     fontSize: textSizeLargeMedium,
                     color: colorPrimary,
                     fontWeight: FontWeight.w500),
                     childrenPadding: const EdgeInsets.symmetric(horizontal: spacing_middle,vertical: 0),
                   
                 children: [
                    text(data["type"].toString(),
                     fontSize: textSizeLargeMedium,
                     color: colorPrimary,
                     fontWeight: FontWeight.w500),
                   DateWidget(createdAt: data["createdAt"].toString()),
                   HtmlToFlutter(data: data["body"].toString())
                 ],
               );
             },
           ).paddingTop(spacing_twinty);}})
    );
  }
}
