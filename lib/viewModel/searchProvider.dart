import 'package:flutter/material.dart';
import 'package:prestige/repository/homeRepository.dart';

class SearchProvider extends ChangeNotifier {
  final homerepository = HomeRepository();

  List searchedProducts = [];
  List searchedCategories = [];
  List searchedSubCategories = [];
  List searchedOrders = [];
  List searchedShops = [];
  bool pageloading = false;
  setPageloading(value) {
    pageloading = value;
    notifyListeners();
  }

  ///searchProductCategory
  Future searchProductCategory(int page, query) async {
    setPageloading(true);
    try {
      var data = await homerepository.searchProductCategory(query, page);
      if (page == 1) {
        searchedProducts.clear();
        searchedCategories.clear();
        searchedSubCategories.clear();
        searchedProducts = data["products"];
        searchedCategories = data["categories"];
        searchedSubCategories = data["subCategories"];
      } else {
        searchedProducts = data["products"];
        searchedCategories = data["categories"];
        searchedSubCategories = data["subCategories"];
      }
    } catch (e) {
      if (page == 1) {
        searchedProducts.clear();
        searchedCategories.clear();
        searchedSubCategories.clear();
      }
    } finally {
      setPageloading(false);
      notifyListeners();
    }
  }

//searchOrders...................................>>
  Future searchOrders(int page, query) async {
    setPageloading(true);
    try {
      var data = await homerepository.searchOrders(query, page);
// print(data);
      if (page == 1) {
        searchedOrders.clear();
        searchedOrders = data["docs"];
      } else {
        searchedOrders = data["docs"];
        
      }
    } catch (e) {
      if (page == 1) {
        searchedOrders.clear();
      }
    } finally {
      setPageloading(false);
      notifyListeners();
    }
  }
 
 //partner Search...................................>>
  Future searchedFShopsFProduct(int page, query) async {
    setPageloading(true);
    try {
      var data = await homerepository.searchedFShopsFProduct(query, page);
// print(" data searchedFShopsFProduct : ${data}");
      if (page == 1) {
        searchedShops.addAll( data["favouriteShops"]);
        searchedProducts.addAll( data["favouriteProducts"]);
        // searchedProducts = data["favouriteProducts"];
print("searchedProducts : ${searchedProducts}");

      } else {
       searchedShops.addAll( data["favouriteShops"]);
        searchedProducts.addAll( data["favouriteProducts"]);
        
        
      }
    } catch (e) {
     return e.toString();
     
    } finally {
      setPageloading(false);
      notifyListeners();
    }
  }

}



