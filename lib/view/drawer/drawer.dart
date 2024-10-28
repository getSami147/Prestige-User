import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/view/drawer/changePassword.dart';
import 'package:prestige/view/drawer/contectUs.dart';
import 'package:prestige/view/profile/deleteAccount.dart';
import 'package:prestige/view/drawer/biomatricAndQr/biomatricAuthScreen.dart';
import 'package:prestige/view/drawer/notifications/notificationScreen.dart';
import 'package:prestige/view/favorite/favorite.dart';
import 'package:prestige/view/drawer/FAQsScreen.dart';
import 'package:prestige/view/drawer/rewards/invitefriend.dart';
import 'package:prestige/view/drawer/rewards/myreward.dart';
import 'package:prestige/view/drawer/transactions/mytransaction.dart';
import 'package:prestige/view/drawer/termsAndUses.dart';
import 'package:prestige/view/order/orderhistory.dart';
import 'package:provider/provider.dart';
import 'package:prestige/utils/Images.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/utils/constant.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/components/component.dart';
import 'package:prestige/view/drawer/logOut.dart';
import 'package:prestige/view/profile/profileScreen.dart';
import 'package:prestige/viewModel/userViewModel.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${userViewModel.accessToken}'};

    var size = MediaQuery.sizeOf(context);

    return Drawer(
      backgroundColor: color_white,
      child: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                (userViewModel.userImageURl == null ||
                        userViewModel.userImageURl!.isEmpty ||
                        !userViewModel.userImageURl!.startsWith('http'))
                    ? CircleAvatar(
                        radius: 45,
                        backgroundColor: colorPrimary,
                        child: ClipOval(
                            child: Image.asset(
                          profileimage,
                          height: size.width * .20,
                          width: size.width * .20,
                          fit: BoxFit.cover,
                        )),
                      )
                    : CircleAvatar(
                        radius: size.width * .14,
                        backgroundColor: colorPrimary,
                        child: ClipOval(
                            child: Image.network(
                          userViewModel.userImageURl.toString(),
                          height: size.width * .24,
                          width: size.width * .24,
                          fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.asset(placeholderProfile,
                          height: size.width * .24,
                          width: size.width * .24,
                          fit: BoxFit.cover,
                         );
                        },
                          
                        )),
                      ),
                text(userViewModel.name.toString(),
                        fontSize: textSizeLargeMedium,
                        fontWeight: FontWeight.w600)
                    .paddingTop(spacing_middle),
                text(userViewModel.userEmail.toString(),
                    fontSize: 11.0, color: textGreyColor),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  DraweTile(
                    imagename: nav_ic_profile,
                    textName: "Profile",
                    onTap: () {
                      const ProfileScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_oderHistory,
                    textName: "Order History",
                    onTap: () {
                      const OrderHistoryScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_notificationbell,
                    textName: "Notifications",
                    onTap: () {
                      const NotificationScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_creditCard,
                    textName: "My Transactions ",
                    onTap: () {
                      const Mytransactionscreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_favourite,
                    textName: "My Favorites ",
                    onTap: () {
                      const FavoriteScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade,);
                    },
                  ),

                  DraweTile(
                    imagename: drawer_ic_inviteFriend,
                    textName: "Invite Friends",
                    onTap: () {
                      const Invitedfriendscreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_inviteFriend,
                    textName: "My Rewards",
                    onTap: () {
                      const Myrewardscreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  const Divider().paddingTop(spacing_standard_new),
                  DraweTile(
                    imagename: drawer_ic_changePassword,
                    textName: "Change Password",
                    onTap: () {
                      const ChangePassword().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_qrCode,
                    textName: "Profile QR Generate",
                    onTap: () {
                      const BiomatricAuthScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
               
                  DraweTile(
                    imagename: drawer_ic_termsCondition,
                    textName: "Terms & Conditions",
                    onTap: () {
                      const TermsAndUses().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_helpFAQs,
                    textName: "Help & FAQ's",
                    onTap: () {
                      const FAQsScreen().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                 
                  DraweTile(
                    imagename: svg_phone,
                    textName: "Contact us",
                    onTap: () {
                        const ContactUs().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_logOut,
                    textName: "Log Out",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          var provider = Provider.of<UserViewModel>(context,
                              listen: false);
                          // Delete Page (Dialog Box) is Called.............>>>
                          return AccountLogOut(
                            refreshtoken: provider.refreshtoken,
                          );
                        },
                      );
                    },
                  ),
                  DraweTile(
                    imagename: drawer_ic_deleteAccount,
                    textName: "Delete Account",
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          // Delete Page (Dialog Box) is Called.............>>>
                          return DeleteAccount();
                        },
                      );
                    },
                  )
                ],
              ),
            ))
          ],
        )
            .paddingSymmetric(
                horizontal: spacing_large, vertical: spacing_twinty)
            .paddingTop(spacing_twinty)
            .paddingSymmetric(horizontal: spacing_twinty),
      ),
    );
  }
}
