import 'package:flutter/foundation.dart';
import 'package:prestige/utils/widget.dart';
import 'package:provider/provider.dart';
import 'package:prestige/data/network/networkApiServices.dart';
import 'package:prestige/res/appUrl.dart';
import 'package:prestige/viewModel/userViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  NetworkApiServices apiServices = NetworkApiServices();

  // getAllNotifications...........
  Future getMyNotifications(context, int page, int limit) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlNotification}?userId=${provider.userId}&page=$page&limit=$limit",
          headers);
          
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getAllShops...........
  Future getAllShops(context, int page, int limit) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlGetAllShop}?page=$page&limit=$limit", headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getAllProductsAPI...........
  Future getAllProductsAPI(context,int page, int limit) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi("${AppUrls.urlFeatureproduct}?page=$page&limit=$limit", headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
    // getTermUses...........
  Future getTermUses(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlTermUses, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
    // getFaqs...........
  Future getFaqs(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlFaqs, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  

  // getAllPointFormula...........
  Future getAllPointFormula(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlPointFormula, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getPointHistory...........
  Future getPointHistory(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlGetPointHistory}?userId=${provider.userId.toString()}",
          headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getInviteFriends...........
  Future getInviteFriends(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlGetByIdInviteFriend, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // <<< Get API's..........................>>> //
  //searchProductCategory.................................
  Future<dynamic> searchProductCategory(String query, int page) async {
    final  sp = await SharedPreferences.getInstance();
    var accessToken= sp.getString("accessToken");
    var headers = {'Authorization': 'Bearer $accessToken'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlProductSearch}$query&limit=15&page=$page", headers);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("repo  error : ${e.toString()}");
      }
      throw e.toString();
    }
  }

    //searchOrders...................................>>
  Future<dynamic> searchOrders(String query, int page) async {
    final  sp = await SharedPreferences.getInstance();
    var accessToken= sp.getString("accessToken");
    var headers = {'Authorization': 'Bearer $accessToken'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlorderSearch}?q=$query&limit=15&page=$page", headers);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("repo  error : ${e.toString()}");
      }
      throw e.toString();
    }
  }
    
 //searchedShopsAPI...................................>>
 Future<dynamic> searchedFShopsFProduct(String query, int page) async {
    final  sp = await SharedPreferences.getInstance();
    var accessToken= sp.getString("accessToken");
    var headers = {'Authorization': 'Bearer $accessToken'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlShopSearch}?q=s&limit=15&page=$page&populate=shopId productId", headers);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("repo  error : ${e.toString()}");
      }
      throw e.toString();
    }
  }

  // getMyTransactions...........
  Future getMyTransactions(context, int page, int limit) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlMyTransaction}?userId=${provider.userId.toString()}&page=$page&limit=$limit",
          headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getSingalOrderDetails...........
  Future<dynamic> getSingalOrderDetails(context, String id) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          AppUrls.urlSingleOrderDetails + id, headers);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

// getAllStatesAPI.....
  Future<dynamic> getAllStatesAPI(context) async {
    try {
      dynamic response = await apiServices.getApi(AppUrls.urlGetAllStates, {});
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //getCurrentpointAPI...........
  Future<dynamic> getCurrentpointAPI(context,) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
     var accessToken = sp.getString("accessToken");
     var userId = sp.getString("userId");
    // var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer $accessToken'};

   

    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlCurrentpoint +userId.toString(), headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //getAllFeatureProducts...........

  Future getFeatureProducts(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlFeatureproduct, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

//Getallofferapi
  Future getalloffer(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(AppUrls.urloffer, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // getSingalFeatureProduct...........
  Future<dynamic> getSingalFeatureProducts(context, String id) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          AppUrls.urlSingleFeatureproduct + id, headers);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //single getoffer Api...........
  Future<dynamic> singlegetoffer(context, String id) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlgetoffer1 + id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

//Getallcategoryapi
  Future<dynamic> getallcategory(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi("${AppUrls.urlcategory}/all", headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //single getsinglecategory Api...........
  Future<dynamic> singlegetcategory(context, String id) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlgetcategory1 + id, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //getOrdersByuser
  Future<dynamic> getOrdersByuserAPI(context,int page,int limit) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlOrderByuser +provider.userId.toString()}?page=$page&limit=$limit", headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  //getUserDashboard ==>> OverView //.................................>>
  Future<dynamic> getUserDashboard(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          AppUrls.urluserdashbaord, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
  //favouriteProducts
  Future<dynamic> getfavouriteProducts(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
          "${AppUrls.urlFavouriteProduct}?populate=productId shopId&userId=${provider.userId.toString()}",
          headers,
          );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //favouriteProducts
  Future getfavouriteShop(context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response = await apiServices.getApi(
        "${AppUrls.urlfavoriteshop}?populate=shopId&userId=${provider.userId.toString()}",
        headers,
        // query: "populate=productId shopId"
      );
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

// hassan get.....................>>

  // GetShopbySlug............
  Future<dynamic> shopBySlug(context, String id) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.getApi(AppUrls.urlshopbyslug + id, headers);

      return response;
    } catch (e) {
      throw e.toString();
    }
  }

// <<< Post API's==>########################>>> //
// PlaceOrderAPI...........
  Future<dynamic> placeOrderAPI(Map<String, dynamic> data, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${provider.accessToken}'
    };
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlPlaceOrder, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

// sendGiftAPI...........
  Future<dynamic> sendGiftAPI(Map<String, dynamic> data, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${provider.accessToken}'
    };
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlgift, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  // Invite Friend Post...........
  Future inviteFriendsPost(Map<String, dynamic> data, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${provider.accessToken}'
    };
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlInviteFriendPost, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
    //contectUsPostAPI...........
  Future contectUsPostAPI(Map<String, dynamic> data, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${provider.accessToken}'
    };
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlContactUs, headers);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  //PostFavoriteproduct
  Future<dynamic> postfavorite(Map<String, dynamic> data, context) async {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userViewModel.accessToken}'
    };

    try {
      dynamic response = await apiServices.postApi(
          data, AppUrls.urlPostfavoriteProduct, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //PostFavoritShop
  Future<dynamic> postfavoriteshop(Map<String, String> data, context) async {
    var userViewModel = Provider.of<UserViewModel>(context, listen: false);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userViewModel.accessToken}'
    };
    try {
      dynamic response =
          await apiServices.postApi(data, AppUrls.urlfavoriteshop, headers);

      return response;
    } catch (e) {
      rethrow;
    }
  }


//  // Update Me API //...................................................>>>
//    // Update Me Profile.................................................>>
//   Future<dynamic> updateCommentApi(dynamic data,String id,context) async {
//         var provider=Provider.of<UserViewModel>(context,listen: false);
//         var headers = {
//   'Content-Type': 'application/json',
//   'Authorization': 'Bearer ${provider.accessToken}'};
//     try {
//       dynamic response = await apiServices.updateApi(data, AppUrls.urlCommentUpdate+id, headers);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }


//   // Delete APIs //.......................................................>>>
  // removefavoriteProduct Deleteby Id......................................................>>>
  Future<dynamic> removefavoriteProduct(String id, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.deleteApi(AppUrls.urlDeleteproduct + id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Deletebyshop Id......................................................>>>
  Future<dynamic> deletefavoriteshop(String id, context) async {
    var provider = Provider.of<UserViewModel>(context, listen: false);
    var headers = {'Authorization': 'Bearer ${provider.accessToken}'};
    try {
      dynamic response =
          await apiServices.deleteApi(AppUrls.urldelectshop + id, headers);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
