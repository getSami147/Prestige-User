import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/homeViewModel.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';

class GiftAndPointScreen extends StatefulWidget {
  const GiftAndPointScreen({super.key});

  @override
  State<GiftAndPointScreen> createState() => _GiftAndPointScreenState();
}

class _GiftAndPointScreenState extends State<GiftAndPointScreen> {
  TextEditingController pointsController=TextEditingController();
  TextEditingController prestigeNumberController=TextEditingController();
  FocusNode prestigeFocusNode=FocusNode();
  FocusNode pointsFocusNode=FocusNode();
    final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        title: text(gift_Gift, fontSize: textSizeLarge, fontWeight: FontWeight.w700),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  giftpic,
                  height: MediaQuery.of(context).size.height * 0.3
                      
                ).paddingTop(10),
              ),
              Center(
                child: text(gift_Giftpoint,
                        fontSize: textSizeNormal,
                        fontWeight: FontWeight.w600,
                        color: textGreenColor)
                    .paddingTop(spacing_thirty),
              ),
              
              text(gift_nymber,
                      fontSize: textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: textGreenColor)
                  .paddingTop(20),
              CustomTextFormField(context,
                        focusNode: pointsFocusNode,
                        controller: pointsController,
                        hintText: gift_nymber,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of points';
                              } 
                              return null;
                            },
                        onFieldSubmitted: (value) {
                          utils().formFocusChange(
                              context, pointsFocusNode, prestigeFocusNode);
                        },
                      ).paddingTop(spacing_middle),
              text(gift_recipi,
                      fontSize: textSizeSmall,
                      fontWeight: FontWeight.w400,
                      color: textGreenColor)
                  .paddingTop(20),
                   CustomTextFormField(context,
                        focusNode: prestigeFocusNode,
                        controller: prestigeNumberController,
                        hintText: gift_enter,
                         validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the sender prestige number';
                              } 
                              return null;
                            },
                      ).paddingTop(spacing_middle),
             
              Center(
                child: elevatedButton(
                  context,
                  height: 47.0,
                  width: 221.0,
                  backgroundColor: colorPrimary,
                  bodersideColor: colorPrimary,
                  onPress: () {
                    if (formkey.currentState!.validate()) {
                           Map<String,dynamic>data={
                      "prestigeNumber":prestigeNumberController.text.toString(),
                      "prestigePoint":pointsController.text.toInt(),
                    };
                    HomeViewModel().sendGiftAPI(data, context);
                    if (kDebugMode) {
                      print(data);
                    }
                    }
                   
                   
                  },
                  child: text(gift_sent,
                      fontSize: textSizeLargeMedium,
                      fontWeight: FontWeight.w500,
                      color: white),
                ).paddingTop(spacingBig),
              )
            ],
          ).paddingSymmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }
}
