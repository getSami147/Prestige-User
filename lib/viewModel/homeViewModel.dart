// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prestige/models/getAllStatesModel.dart';
import 'package:prestige/repository/homeRepository.dart';
import 'package:prestige/utils/widget.dart';
import 'package:prestige/view/homeScreen/dashboard.dart';

class HomeViewModel with ChangeNotifier {

  int _limit = 15;

  List<dynamic> myTransactions = [];
  List<dynamic> myNotification = [];
  List<dynamic> getOrdersByuser = [];

  List<dynamic> getAllProducts = [];
  List<dynamic> favoriteProducts = [];
  
  List<dynamic> getAllShopData = [];
  List<dynamic> favoriteShops = [];

    //favorite Products & Shop API data

  final homeRepository = HomeRepository();

  bool pageloading = false;
  setPageloading(value) {
    pageloading = value;
    notifyListeners();
  }

  // <<< Get API's==>#########################################################################################
/// getAllNotifications..............................................................>>
Future<List<dynamic>> getMyNotifications(int page, BuildContext context) async {
  try {
    setPageloading(true);
    dynamic newData = await homeRepository.getMyNotifications(context, page, _limit);
    List<dynamic> data = newData["data"];
    // Ensure no duplicate data based on a unique identifier, assuming each notification has an 'id' field
    for (var item in data) {
      if (!myNotification.any((existingItem) => existingItem["_id"] == item["_id"])) {
        myNotification.add(item);
      }
    }
     if (kDebugMode) {
      print("Notification: $myNotification");
    }
    setPageloading(false);
    return myNotification;
  } catch (e) {
    // Handle error
    print("Error fetching notifications: $e");
    return myNotification;
  } finally {
    setPageloading(false);
    notifyListeners();
  }
}


  // getAllShops..............................................................>>
 Future<List<dynamic>> getAllShops(int page, BuildContext context) async {
  try {
    setPageloading(true);
    dynamic newdata = await homeRepository.getAllShops(context, page, _limit);
    List<dynamic> data = newdata["data"];

    // Ensure no duplicate data based on a unique identifier, assuming each item has an '_id' field
    for (var item in data) {
      if (!getAllShopData.any((existingItem) => existingItem["_id"] == item["_id"])) {
        getAllShopData.add(item);
      }
    }
    if (kDebugMode) {
      print("Shops: $getAllShopData");
      print("newdata: $newdata");
    }

    notifyListeners(); // Refresh the UI
     setPageloading(false);
    return getAllShopData;
  } catch (e) {
    // Handle error
    print("Error fetching shops: $e");
    return getAllShopData; // Return current state in case of error
  } finally {
    setPageloading(false);
    notifyListeners();
  }
}

 // getMyTransactions API..............................................................>>
Future<List<dynamic>> getMyTransactions(int page, BuildContext context) async {
  try {
    setPageloading(true);
    dynamic newData = await homeRepository.getMyTransactions(context, page, _limit);
    List<dynamic> data = newData["data"];

    // Ensure no duplicate data based on a unique identifier, assuming each transaction has an 'id' field
    for (var item in data) {
      if (!myTransactions.any((existingItem) => existingItem["_id"] == item["_id"])) {
        myTransactions.add(item);
      }
    }
    if (kDebugMode) {
      print("myTransactions: $newData");
    }
     setPageloading(false);
    return myTransactions;
  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print("Error fetching transactions: $e");
    }
    return myTransactions;
  } finally {
    setPageloading(false);
    notifyListeners();
  }
}


// getOrdersByuser..............................................................>>
Future<List<dynamic>> getOrdersByuserAPI(int page, BuildContext context) async {
  try {
     setPageloading(true);
    dynamic newOrders = await homeRepository.getOrdersByuserAPI(context, page, _limit);
    List<dynamic> data = newOrders["data"];
    // Ensure no duplicate data based on a unique identifier, assuming each order has an 'id' field
    for (var item in data) {
      if (!getOrdersByuser.any((existingItem) => existingItem["_id"] == item["_id"])) {
        getOrdersByuser.add(item);
      }
    }
    if (kDebugMode) {
      print("ordersbyUser: $newOrders");
    }
    notifyListeners();
    return getOrdersByuser;
  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print("Error fetching orders by user: $e");
    }
     setPageloading(false);
    return getOrdersByuser;
  } finally {
     setPageloading(false);
    notifyListeners();
  }
}

  
  // getAllProductsAPI..............................................................>>
Future<List<dynamic>> getAllProductsAPI(int page, BuildContext context) async {
  try {
     setPageloading(true);
    dynamic productData = await homeRepository.getAllProductsAPI(context, page, _limit);
    List<dynamic> data = productData["data"];
    // Ensure no duplicate data based on a unique identifier, assuming each order has an 'id' field
    for (var item in data) {
      if (!getAllProducts.any((existingItem) => existingItem["_id"] == item["_id"])) {
        getAllProducts.add(item);
      }
    }
    if (kDebugMode) {
      print("getAllProducts: $getAllProducts");
    }
    notifyListeners();
    return getAllProducts;
  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print("Error fetching get All Products: $e");
    }
     setPageloading(false);
    return getOrdersByuser;
  } finally {
    setPageloading(false);
    notifyListeners();
  }
}

// // getAllProductsAPI..............................................................>>
// Future<List<dynamic>> getAllProductsAPI(BuildContext context) async {
//   dynamic data = await homeRepository.getAllProductsAPI(context);
//   List<dynamic> newData = data["data"];

//   // Ensure no duplicate data based on a unique identifier, assuming each item has an 'id' field
//   for (var item in newData) {
//     if (!getAllProducts.any((existingItem) => existingItem["_id"] == item["_id"])) {
//       getAllProducts.add(item);
//     }
//   }
//   return getAllProducts;
// }



// favouriteProducts by id API..............................................................>>
Future<void> getFavoriteProducts(BuildContext context) async {
  try {
    setPageloading(true);
    var result = await homeRepository.getfavouriteProducts(context);

    // Clear previous data
    favoriteProducts.clear();

    for (var item in result["data"]) {
      favoriteProducts.add(item);
    }
    if (kDebugMode) {
      print("getFavoriteProducts: $favoriteProducts");
    }
    setPageloading(false);
    notifyListeners();
  } catch (e) {
    setPageloading(false);
    if (kDebugMode) {
      print("Error fetching favorite products: $e");
    }
  }
}

  Future<void> getfavouriteShop(BuildContext context) async {
  try {
    setPageloading(true);
    dynamic result = await homeRepository.getfavouriteShop(context);
    List<dynamic> newData = result['data'];
    // Ensure no duplicate data based on a unique identifier, assuming each item has an '_id' field
    for (var item in newData) {
    List<Map<String, String>> ids = [];

       String id = item["shopId"]["_id"];

      // Add the new data
      ids.add({"_id": id,});
      
      if (!favoriteShops.any((existingItem) => existingItem["_id"] == item["_id"])) {
        favoriteShops.add(item);
        }
    }
    if (kDebugMode) {
      print("Favorite Shops: $favoriteShops");
    }
    setPageloading(false);

  } catch (e) {
    // Handle error
    if (kDebugMode) {
      print("Error fetching favorite shops: $e");
    }
  } finally {
    setPageloading(false);
    notifyListeners(); // Refresh the UI
  }
}


// getshop by Slug..............................................................>>
  Future shopBySlug(BuildContext context, String id) async {
    return homeRepository.shopBySlug(context, id);
  }


  // get Term Uses..............................................................>>
  Future getTermUses(BuildContext context) async {
    return homeRepository.getTermUses(context);
  }

  // get Faqs.............................................................>>
  Future getFaqs(BuildContext context) async {
    return homeRepository.getFaqs(context);
  }

// getAllPointFormula..............................................................>>
  Future getAllPointFormula(BuildContext context) async {
    return homeRepository.getAllPointFormula(context);
  }

  // getPointHistory..............................................................>>
  Future getPointHistory(BuildContext context) async {
    return homeRepository.getPointHistory(context);
  }

// getSingalFeatureProducts..............................................................>>
  Future getInviteFriends(BuildContext context) async {
    return homeRepository.getInviteFriends(context);
  }

// getSingalOrderDetails..............................................................>>
  Future getSingalOrderDetails(BuildContext context, String id) async {
    return homeRepository.getSingalOrderDetails(context, id);
  }

  // getAllStatesAPI..............................................................>>
  Future<GetAllStatesModel> getAllStatesAPI(context) async {
    return homeRepository.getAllStatesAPI(context).then((value) async {
      return GetAllStatesModel.fromJson(value);
    });
  }

  // Get Currentpoint API..............................................................>>
  Future getCurrentpointAPI(BuildContext context) async {
    return homeRepository.getCurrentpointAPI(context,);
  }

  //getUserDashboard ==>> OverView //.................................>>
  Future getUserDashboard(BuildContext context) async {
    return homeRepository.getUserDashboard(context);
  }

// GetAlloffer API..............................................................>>
  Future getofferapi(BuildContext context) async {
    return homeRepository.getalloffer(context);
  }

// single get API..............................................................>>
  Future singlegetapi(BuildContext context, String id) async {
    return homeRepository.singlegetoffer(context, id);
  }

// GetAllcategory API.
  Future getcategoryapi(BuildContext context) async {
    return homeRepository.getallcategory(context);
  }

// getSingalFeatureProducts..............................................................>>
  Future getSingalFeatureProducts(BuildContext context, String id) async {
    return homeRepository.getSingalFeatureProducts(context, id);
  }

// single get API..............................................................>>
  Future singlegetcategory(BuildContext context, String id) async {
    return homeRepository.singlegetcategory(context, id);
  }

  // <<< Post API's ==>#########################################################################################
  // Place order.........................................................>>
  Future placeOrderAPI(Map<String, dynamic> data, BuildContext context) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    homeRepository.placeOrderAPI(data, context).then((value) {
      if (kDebugMode) {
        print('placeOrderAPI: $value');
      }
      utils().flushBar(context, "Order Successfully Placed,Thank You.");
      getOrdersByuser.clear();
      getOrdersByuserAPI(1, context);
      notifyListeners();
      const Dashboard().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }).onError((error, stackTrace) {
      finish(context);
      if (kDebugMode) {
        print('placeOrderAPI error: ${error}');
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // sendGiftAPI.........................................................>>
  Future sendGiftAPI(Map<String, dynamic> data, context) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    homeRepository.sendGiftAPI(data, context).then((value) {
      // print('value: $value');
      finish(context);
      utils().flushBar(context,"Points successfully gifted.");
      const Dashboard().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
      // utils().flushBar(context, "Congrats! Gift sant");
    }).onError((error, stackTrace) {
      finish(context);
      if (kDebugMode) {
        print('sendGiftAPI error: $error');
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

  // inviteFriendsPost.........................................................>>
  Future inviteFriendsPost(String email, context) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    Map<String, dynamic> data = {"email": email};
    homeRepository.inviteFriendsPost(data, context).then((value) {
      if (kDebugMode) {
        print('inviteFriendsPost: $value');
      }
      utils().flushBar(context,"Invitation successfully sent.");
      const Dashboard().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }).onError((error, stackTrace) {
      finish(context);
      if (kDebugMode) {
        print('inviteFriendsPost error: $error');
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }

 // Post Contect US.........................................................>>
  Future contectUsPostAPI(Map<String,String> data,context) async {
     showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const CustomLoadingIndicator(),
    );
    homeRepository.contectUsPostAPI(data, context).then((value) {
      if (kDebugMode) {
        print('contectUsPostAPI: $value');
      }
      utils().flushBar(context, "Thank you! Your message has been successfully sent. We will get back to you shortly.");
      const Dashboard().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }).onError((error, stackTrace) {
      finish(context);
      if (kDebugMode) {
        print('contectUsPostAPI error: $error');
      }
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
    });
  }
// FavoriteProduct.........................................................>>
  Future addFavoriteProduct(
      Map<String, dynamic> data, BuildContext context) async {
    homeRepository.postfavorite(data, context).then((value) async {
  utils().flushBar(context,"Product successfully added to favorites.");
  //  await getFavoriteProducts(context);
      notifyListeners();
    }).onError((error, stackTrace) {
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
      if (kDebugMode) {
        // print('addFavoriteProduct error: $error');
      }
      
    });
  }
 

  // FavoriteShop.........................................................>>
  Future addFavoriteShop(Map<String, String> data, BuildContext context) async {
   await homeRepository.postfavoriteshop(data, context).then((value) {
      utils().flushBar(context, "Shop successfully added to favorites.");
    }).onError((error, stackTrace) {
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: whiteColor);
      if (kDebugMode) {
        // print('addFavoriteShops error: $error');
      }
    });
  }

  // Delete APIs  ==>#########################################################################################
//deletefavoriteProduct
  Future<void> removeFavoriteProduct(String id, BuildContext context) async {
    try {
      await homeRepository.removefavoriteProduct(id, context);
      utils().flushBar(context,"Product successfully removed from inventory.");
      notifyListeners();
    } catch (error) {
      utils().flushBar(context, error.toString());
      if (kDebugMode) {
        // print(error.toString());
      }
    }
  }

  //DeleteShop
  Future<void> removefavoriteshop(String id, BuildContext context) async {
    try {
      await homeRepository.deletefavoriteshop(id, context).then((value) {
        // utils().flushBar(context, "Shop successfully removed from inventory.");
        toast("Shop successfully removed");
      notifyListeners(); //refresh it
      },);
    } catch (error) {
      utils().flushBar(context, error.toString(),backgroundColor: redColor,textcolor: white);
      if (kDebugMode) {
        // print(error.toString());
      }
    }
  }
}
