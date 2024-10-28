import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/res/appUrl.dart';
import 'package:prestige/utils/colors.dart';
import 'package:prestige/view/authView/alldone.dart';
import 'package:prestige/view/authView/completingProfile.dart';
import 'package:prestige/view/authView/restPassword.dart';
import 'package:prestige/view/authView/welcomePage.dart';
import 'package:prestige/viewModel/services/notificationServices.dart';
import 'package:provider/provider.dart';
import 'package:prestige/repository/authRepository.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:prestige/view/authView/otpVerification.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:http/http.dart' as http;

import '../view/homeScreen/dashboard.dart';

class AuthViewModel with ChangeNotifier {
  String? deviceToken;
  final authRepository = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
//getMeApi
  Future<void> getMeApi(
    BuildContext context,
  ) async {
    //  authRepository.getMeApi(context).then((value) => {});
    return authRepository.getMeApi(context);
  }

// Post APIs ==> #########################################################################################
// signUP API Formdata format...........>>
  Future signUpformData(dynamic data, BuildContext context) async {
    setLoading(true);
    await authRepository.signUpformData(data, context).then((value) async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      //pre login Token For complete Profile or signUp details
      sp.setString(
          "preloginToken", value["token"]["access"]["token"].toString());
      if (kDebugMode) {
        print('value: $value');
      }
      setLoading(false);
      OtpVerification(
        email: data["email"],
      ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
    }).onError((error, stackTrace) {
      setLoading(false);
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
      if (kDebugMode) {
        print("SignUp Error: ${error.toString()}");
      }
    });
  }

// Login API..............................................................>>
  Future<void> loginApi(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    authRepository.loginApi(data).then((value) async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      //pre login Token For complete Profile or signUp
      sp.setString(
          "preloginToken", value["token"]["access"]["token"].toString());

      if (value["user"]["isProfileCompleted"] == false) {
        setLoading(false);
        const CompleteProfileScreen().launch(context);
      } else if (value["user"]["role"] == "user") {
        sp.setString(
            "accessToken", value["token"]["access"]["token"].toString());
        sp.setString(
            "refreshToken", value["token"]["refresh"]["token"].toString());
        sp.setString("userId", value["user"]["_id"].toString());
        sp.setString("name", value["user"]["name"].toString());
        sp.setString("email", value["user"]["email"].toString());
        sp.setString("DOB", value["user"]["DOB"].toString());
        sp.setString("contact", value["user"]["contact"].toString());
        sp.setString("userImageURl", value["user"]["image"].toString());
        sp.setString("referralCode", value["user"]["referralCode"]);
        sp.setString("prestigeNumber", value["user"]["prestigeNumber"]);
        sp.setBool("isProfileCompleted", value["user"]["isProfileCompleted"]);
        sp.setBool("Membership", value["user"]["Membership"]);
        setLoading(false);
        // ignore: use_build_context_synchronously
        updateDeviceToken(
            value["token"]["access"]["token"].toString(), context);
      } else {
        setLoading(false);
        utils().flushBar(context, "You can only login with user account.");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print("Login debug:  ${error.toString()}");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
      if (error.toString().contains("Please verify")) {
        if (kDebugMode) {
          print("Launching OTP verification...");
        }
        OtpVerification(email: data["email"]).launch(context);
      }
    });
  }

  // verifyOTP.........................................................>>
  Future verifyOTP(Map<String, dynamic> data, BuildContext context) async {
    setLoading(true);
    authRepository.verifyOTP(data, context).then((value) {
      utils().flushBar(context, value["message"]);
      setLoading(false);
      const CompleteProfileScreen().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print("OTP verify debug:  ${error.toString()}");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // ResendOTP.........................................................>>
  Future<void> resandOTP(String email, BuildContext context) async {
    Map<String, String> data = {
      "email": email,
    };
    authRepository.resandOTP(data, context).then((value) {
      utils().flushBar(context, value["message"]);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("resandOTP debug:  ${error.toString()}");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // logOutApi..............................................................>>
  Future<void> logOutApi(
      Map<String, dynamic> data, BuildContext context) async {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Content-Type': 'application/json'};
    authRepository.logOutApi(data, headers).then((value) {
      // print("LogOut response:  ${value.toString()}");
      userViewModel.remove();
      const LoginScreen().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
        isNewTask: true,
      );
      utils().flushBar(context, value["message"].toString());
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("LogOut error:  ${error.toString()}");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // forgot Password Api..............................................................>>
  Future<void> forgotApi(var email, BuildContext context) async {
    setLoading(true);
    authRepository.forgotApi({
      "email": email,
    }).then((value) {
      setLoading(false);
      const ResetPassword().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
      );
      utils().flushBar(context, value["message"].toString());
    }).onError((error, stackTrace) {
      // setLoading(false);
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // Update APIs ==>#########################################################################################
  //updateDeviceToken..............................................................>>
  Future updateDeviceToken(String accessToken, BuildContext context) async {
    deviceToken = await NotificationServices().getToken(context);

    // var provider = Provider.of<UserViewModel>(context, listen: false);
    Map<String, dynamic> data = {"deviceToken": deviceToken.toString()};
    authRepository
        .updateDeviceToken(data, accessToken, context)
        .then((value) async {
      if (kDebugMode) {
        print("updateDeviceToken: ${value["data"]["deviceToken"]}");
      }

      const Dashboard().launch(
        context,
        pageRouteAnimation: PageRouteAnimation.Fade,
        isNewTask: true,
      );
      // ignore: use_build_context_synchronously
      utils().flushBar(context, "Congratulations! You have successfully\n logged in.",backgroundColor: colorPrimary,textcolor: white);
      // Alldonescreen(
      //   value: value,
      // ).launch(context,
      //     isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
      // utils().flushBar(context, "Congrats you are Profile has been Updated");
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("updateDeviceToken error: $error");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  //completeProfile..............................................................>>
  Future completeProfile(
      Map<String, dynamic> data, BuildContext context) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    authRepository.completeProfile(data, context).then((value) async {
      if (value["message"].toString().contains("No document")) {
        finish(context); // Close the loading dialog
        utils().flushBar(context, value["message"].toString());
      } else {
        if (kDebugMode) {
          print("completeProfile: ${value}");
        }
        finish(context); // Close the loading dialog
        Alldonescreen(
          value: value,
        ).launch(context,
            isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
      }
      // utils().flushBar(context, "Congrats you are Profile has been Updated");
    }).onError((error, stackTrace) {
      finish(context); // Close the loading dialog
      if (kDebugMode) {
        print("completeProfile error: $error");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  Future changePassword(dynamic data, BuildContext context) async {
    setLoading(true);
    authRepository.changePassword(data, context).then((value) async {
      if (kDebugMode) {
        print("updatePassword: ${value}");
      }
      const Dashboard().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
      setLoading(false);
      // utils().flushBar(context, "Congrats you are Profile has been Updated");
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print("updatePassword error: $error");
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

// updateMeformData format...........>>
  Future updateMeformData(
      Map<String, String> data, BuildContext context) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    await authRepository.updateMeformData(data, context).then((value) async {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString("name", value["data"]["name"].toString());
      sp.setString("userImageURl", value["data"]["image"].toString());
      sp.setString("DOB", value["data"]["DOB"].toString());
      sp.setString("contact", value["data"]["contact"].toString());
      sp.setBool("Membership", value["data"]["Membership"]);

      if (kDebugMode) {
        print('value: $value');
      }
      finish(context); // Close the loading dialog
      const Dashboard().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }).onError((error, stackTrace) {
      finish(context); // Close the loading dialog
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
      if (kDebugMode) {
        print("Update Profile Error: ${error.toString()}");
      }
    });
  }

  // Delete APIs ==>#########################################################################################
  // DeleteMe..............................................................>>
  Future<void> deleteMe(BuildContext context) async {
    authRepository.deleteMe(context).then((value) async {
      if (kDebugMode) {
        print("deleteMe response: ${value.toString()}");
      }
      UserViewModel().remove();
      const welcomePage().launch(context,
          isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
      utils().flushBar(context, value["message"]);
    }).onError((error, stackTrace) {
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  resetPasswordAPI(var password, var token) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${AppUrls.baseUrl}auth/resetpassword/$token'));
    request.body = json.encode({"password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
