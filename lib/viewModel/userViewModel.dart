import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/authView/logIn.dart';
import 'package:prestige/view/homeScreen/dashboard.dart';

class UserViewModel with ChangeNotifier {


//Current coordinates//..........................................
  double mylat = 0.0;
  double mylng = 0.0;
  // AddToCart..................................................
  List<Map<String, dynamic>> cartList = [];
  int quantity = 1;
  var total;
  var subPrice;
  var cartTotalPoints;



// Remove Products by Index from Cart...........................
  void removeFromCart(int index) {
    cartList.removeAt(index);
    utils().toastMethod("Product is remove form cart");
    updateCartPrices();
    notifyListeners();
  }

  //clear the whole Cart.........................................
  void clearCart() {
    cartList.clear();
    utils().toastMethod("The cart is cleared");
    // notifyListeners();
  
  }

//updateCartPrices................................................
  void updateCartPrices() {
    total=0;
    for (int i = 0; i <cartList.length; i++) {
      subPrice = cartList[i]['quantity'] *cartList[i]["price"];
      total = (total + subPrice);
      if (kDebugMode) {
        print(cartList[i]['quantity']);
        print("subPrice: ${subPrice}");
        print("total: ${total}");
      }
      notifyListeners();
    }
  }

// Calander Select date///............................................
  DateTime selectedDate = DateTime.now();
  void setSelectedDate(DateTime date) {
    selectedDate = date;
    if (kDebugMode) {
      print(selectedDate);
    }
    notifyListeners();
  }

// Image Picker Profile................................................
  File? _image;
  File? get image => _image;
  Future getImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      utils().toastMethod("'image picked");
      notifyListeners();
    } else {
      utils().toastMethod("'images not picked");
      // print('images not picked');
    }
  }

  //SignUp dropdown.......................................................
  String _selectedGender = "Male";
  String? _selectedCountry;

  String get selectedGender => _selectedGender;
  String? get selectedCountry => _selectedCountry;

    String? selectedState;
  String? selectedLGAs;

// setSelected State....................................>>>
  void setSelectedState(String? states) {
    selectedState = states;
    notifyListeners(); // Notify listeners when data changes
  }
// setSelected State LGAs....................................>>>
  void setSelectedLGAs(String? lga) {
    selectedLGAs = lga;
    notifyListeners(); // Notify listeners when data changes
  }

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners(); // Notify listeners when data changes
  }

// image Sliding (Product details)
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  selectedIndexMethod(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  //SignUp CheckBox
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void setIsChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  // remove share Prefence data.......................>>
  void remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

// Get User Token...........................................................>>>
  String?preloginToken;
  String? accessToken;
  String? refreshtoken;
  String? userId;
  String? name;
  String? userEmail;
  String? contact;
  String? userDateOfBirth;
  String? referralCode;
  String? prestigeNumber;
  String? userImageURl;
  bool? isProfileCompleted;
  bool? membership;
  double? prestigePoint;
  var currentNira;
  void getUserTokens() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    
    preloginToken = sp.getString("preloginToken");
    accessToken = sp.getString("accessToken");
    refreshtoken = sp.getString("refreshToken");
    userId = sp.getString("userId");
    name = sp.getString("name");
    userEmail = sp.getString("email");
    contact = sp.getString("contact");
    userDateOfBirth = sp.getString("DOB");
    referralCode=sp.getString("referralCode");
    prestigeNumber=sp.getString("prestigeNumber");
    userImageURl = sp.getString("userImageURl");
    membership = sp.getBool("Membership");
    notifyListeners();
  }

  signupToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    preloginToken = sp.getString("preloginToken");
    notifyListeners();
    // print("accessToken: $accessToken");
  }

  // isCheack Login ..........................................................>>>
  late bool hasExpired;
  void isCheckLogin(context) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    preloginToken = sp.getString("preloginToken");
    isProfileCompleted = sp.getBool("isProfileCompleted");

    hasExpired = JwtDecoder.isExpired(accessToken.toString());
    Map<String, dynamic>? decodedToken =
        JwtDecoder.decode(accessToken.toString());

    if (kDebugMode) {
      print("hasExpired: $hasExpired");
      print("decodedToken: $decodedToken");
    }
    accessToken == null || hasExpired || isProfileCompleted == false
        ? const LoginScreen().launch(context)
        : const Dashboard().launch(context);
    notifyListeners();
  }

// Location premission
  Future<void> getCurrentLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      notifyListeners();
      if (permission == LocationPermission.denied) {
        print("Location permission is denied");
        return Future.error("Location permission is denied");
      }
    }

    if (await Permission.location.isPermanentlyDenied) {
      Geolocator.openAppSettings();
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mylat = position.latitude;
    mylng = position.longitude;
    notifyListeners();
  }
  //Cupertino Switch
  bool switchValue = false;
  void toggleSwitch(bool newValue) {
    switchValue = newValue;
    notifyListeners();
  }

// Payment Method //.................
  // String _selectedMethod = "cashpoint"; // Default selection

  // String get selectedMethod => _selectedMethod;
  // void setSelectedMethod(String newValue) {
  //   _selectedMethod = newValue;
  //   notifyListeners();
  // }

  
}
