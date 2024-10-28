import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/offer/prestigeSingleOffer.dart';
import 'package:prestige/viewModel/homeViewModel.dart';

class PrestigeOffer extends StatefulWidget {
  const PrestigeOffer({super.key});

  @override
  State<PrestigeOffer> createState() => _PrestigeOfferState();
}

class _PrestigeOfferState extends State<PrestigeOffer> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(prestige_Prestige,
            fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: FutureBuilder(
        future: HomeViewModel().getofferapi(context),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    const CustomLoadingIndicator().paddingTop(spacing_middle));
          } else if (snapshot.hasError) {
            return Center(child: text(snapshot.error.toString(), maxLine: 10));
          } else if (snapshot.hasError) {
            return Center(child: text(snapshot.error.toString(), maxLine: 10));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(snapshot.data['message'].toString(),
                      fontSize:textSizeLargeMedium, fontWeight: FontWeight.w600),
                  ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data=snapshot.data['data'][index];
                      return Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  black.withOpacity(0.2), BlendMode.srcATop),
                              child: InkWell(
                                onTap: () {
                                  PrestigeSingleOffer(
                                    id: snapshot.data['data'][index]['_id'],
                                  ).launch(context,
                                      pageRouteAnimation:
                                          PageRouteAnimation.Fade);
                                },
                                child: Image.network(
                                  snapshot.data['data'][index]['image']
                                      .toString(),
                                  height: orientation == Orientation.portrait
                                      ? size.height * .22
                                      : size.height * .5,
                                  width:size.width,
                                  fit: orientation == Orientation.portrait
                                      ? BoxFit.cover
                                      : BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              placeholderProduct,
                              height: size.height * .22,
                              fit: BoxFit.cover,
                            );
                          },
                                ).paddingTop(20),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              text( "${data['percentage'].toString()} % OFF",
                              fontSize: textSizeXXLarge,
                                  fontWeight: FontWeight.w700,
                                  color: white),
                              text(prestige_grab.toString(),
                                  fontSize: textSizeSMedium,
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ],
                          ).paddingOnly(left: 20, top: 20)
                            , Positioned(
                              bottom: spacing_twinty,
                              right: spacing_twinty,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: spacing_standard,horizontal: spacing_middle),
                                decoration: BoxDecoration(
                                   color: colorPrimary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:InkWell(
                                  onTap: () {
                                     PrestigeSingleOffer(
                                    id: snapshot.data['data'][index]['_id'],
                                  ).launch(context,
                                      pageRouteAnimation:
                                          PageRouteAnimation.Fade);
                                  },
                                  child: text(prestige_sea,
                                        color: white,fontSize: textSizeSmall,),
                                ))
                              
                            )
                            
                       ],
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ).paddingSymmetric(horizontal: spacing_standard_new),
    );
  }
}