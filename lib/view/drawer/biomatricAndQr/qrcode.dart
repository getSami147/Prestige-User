import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/string.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qrcodescreen extends StatefulWidget {
  const Qrcodescreen({super.key});

  @override
  State<Qrcodescreen> createState() => _QrcodescreenState();
}

class _QrcodescreenState extends State<Qrcodescreen> {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var size = MediaQuery.sizeOf(context);
    print("Prestige no:${userViewModel.prestigeNumber.toString()}");
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: black),
          title: text(QRcode_QR, fontSize: textSizeLarge, fontWeight: FontWeight.w700),
        ),
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 237, 237),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      height: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.45
                          : MediaQuery.of(context).size.width * 0.35,
                      width: orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.45
                          : MediaQuery.of(context).size.width * 0.35,
                      child: Container(
                        alignment: Alignment.center,
                        height: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.25
                            : MediaQuery.of(context).size.width * 0.15,
                        width: orientation == Orientation.portrait
                            ? MediaQuery.of(context).size.height * 0.25
                            : MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: QrImageView(
                          data: userViewModel.prestigeNumber.toString(),
                          size: orientation == Orientation.portrait
                              ? MediaQuery.of(context).size.height * 0.2
                              : MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ).paddingSymmetric(horizontal: spacing_standard_new),
                    Positioned(
                      top: -30,
                      child: Column(
                        children: [
                          Consumer<UserViewModel>(
                            builder: (context, value, child) => Column(
                              children: [
                                value.userImageURl == null||value.userImageURl!.isEmpty
                                    ? ClipOval(
                                        child: Image.asset(
                                        profileimage,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ))
                                    : ClipOval(
                                        child: Image.network(
                                        value.userImageURl.toString(),
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      )),
                              ],
                            ),
                          ),
                          text(
                            userViewModel.name.toString(),
                         fontSize: textSizeLarge,
                                fontWeight: FontWeight.w500,
                                color: textGreenColor
                          ).paddingTop(spacing_middle),
                        ],
                      ),
                    )
                  ],
                ).paddingTop(spacing_xxLarge),
                text("Your Prestige+ Number is Private",
                        fontSize: textSizeNormal,
                        maxLine: 3,
                        fontWeight: FontWeight.w500,
                        color: textGreenColor)
                    .paddingTop(spacing_twinty),
                const Spacer(),
               ],
            ).paddingSymmetric(horizontal: 15),
          ),
        ]));
  }
}
