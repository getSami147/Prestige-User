import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/cart/checkout.dart';
import 'package:prestige/viewModel/homeViewModel.dart';

class PrestigeSingleOffer extends StatefulWidget {
  String? id;
  PrestigeSingleOffer({this.id, super.key});

  @override
  State<PrestigeSingleOffer> createState() => _PrestigeSingleOfferState();
}

class _PrestigeSingleOfferState extends State<PrestigeSingleOffer> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    print("OfferId:${widget.id}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        title: text(prestige_Prestige,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: FutureBuilder(
              future:
                  HomeViewModel().singlegetapi(context, widget.id.toString()),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: const CustomLoadingIndicator()
                          .paddingTop(spacing_middle));
                } else if (snapshot.hasError) {
                  return Center(
                      child: text(snapshot.error.toString(), maxLine: 10));
                } else if (snapshot.hasError) {
                  return Center(
                      child: text(snapshot.error.toString(), maxLine: 10));
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                black.withOpacity(0.2), BlendMode.srcATop),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data['image'].toString(),
                                height: orientation == Orientation.portrait
                                    ? size.height * .22
                                    : size.height * .5,
                                width: size.width,
                                fit: orientation == Orientation.portrait
                                    ? BoxFit.cover
                                    : BoxFit.fill,
                              ).paddingTop(20),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text(
                                  "${snapshot.data['percentage']}%OFF",
                                  fontSize: textSizeXXLarge,
                                  fontWeight: FontWeight.w700,
                                  color: white),
                            ],
                          ).paddingOnly(left: 20, top: 20)
                        ],
                      ),
                      CustomBillingRow(
                        text0: prestige_Offer,
                        text1: "${snapshot.data['percentage']}%OFF",
                        traillingColor: colorPrimary,
                      ).paddingTop(15),
                      const Divider(
                        thickness: 1,
                      ).paddingTop(10),
                      text(prestige_Offersdetails,
                              fontSize:textSizeLargeMedium, fontWeight: FontWeight.w600)
                          .paddingTop(10),
                      const customlinecontainer(),
                      customprestige(
                        text0: prestige_OfferCode,
                        text2: "",
                        text1: snapshot.data['offerDetails']['offerCode']
                            .toString(),
                        color: textGreyColor,
                        color1: colorPrimary,
                      ).paddingTop(10),
                      customprestige(
                        text0: prestige_Earn,
                        text2: "",
                        text1: snapshot.data['offerDetails']['earnPoints']
                            .toString(),
                        color: textGreyColor,
                        color1: colorPrimary,
                      ).paddingTop(10),
                      customprestige(
                        text0: prestige_Valid,
                        text2: "",
                        text1:formatDateTime(snapshot.data['valideUntil'].toString()) ,
                        color: textGreyColor,
                        color1: colorPrimary,
                      ).paddingTop(10),
                      const Divider().paddingTop(10),
                      text(prestige_how,
                              fontSize:textSizeLargeMedium, fontWeight: FontWeight.w600)
                          .paddingTop(10),
                      const customlinecontainer(),
                      customprestige1(
                        text0: "",
                        text1:
                            snapshot.data['howToClaim'][0]['steps'].toString(),
                        color: textGreyColor,
                      ).paddingTop(10),
                      elevatedButton(
                        context,
                        onPress: () {
                        },
                        child: text(prestige_Checkout,
                            fontSize: textSizeMedium,
                            fontWeight: FontWeight.w500,
                            color: white),
                      ).paddingTop(spacingBig),
                    ],
                  );
                }
              },
            ).paddingSymmetric(horizontal: 15),
          ),
        ],
      ),
    );
  }
}

class customlinecontainer extends StatelessWidget {
  const customlinecontainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 2,
      decoration: BoxDecoration(
          color: dissmisable_RedColor, borderRadius: BorderRadius.circular(3)),
    );
  }
}

class customprestige extends StatelessWidget {
  String? text0, text1, text2;
  Color? color, color1, color2;
  customprestige({
    this.text2,
    this.color2,
    this.color,
    this.color1,
    this.text0,
    this.text1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 3,
          backgroundColor: textGreyColor,
        ).paddingTop(10),
        SizedBox(
          width: 5,
        ),
        text(text0,
                fontSize: textSizeSMedium, fontWeight: FontWeight.w600, color: color)
            .paddingTop(10),
        text(text2,
                fontSize: textSizeSMedium, fontWeight: FontWeight.w600, color: color2)
            .paddingTop(10),
        SizedBox(
          width: 5,
        ),
        text(text1,
                fontSize: textSizeSMedium, fontWeight: FontWeight.w600, color: color1)
            .paddingTop(10)
      ],
    );
  }
}

class customprestige1 extends StatelessWidget {
  String? text0, text1;
  Color? color;
  customprestige1({
    this.color,
    this.text0,
    this.text1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text(text0,
            fontSize: textSizeSMedium, fontWeight: FontWeight.w600, color: color),
        const SizedBox(
          width: 5,
        ),
        text(text1,
            fontSize: textSizeSMedium,
            fontWeight: FontWeight.w600,
            color: color,
            isLongText: true)
      ],
    );
  }
}
