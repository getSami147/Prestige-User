import 'package:flutter/foundation.dart';

class SubCategoryProvider with ChangeNotifier {
  // List<Map<String, String>> favoriteshop = [];


  String selectedCategoryId = '';
  int selectedCategoryIndex = 0;
  String? selectedSubCategoryId = '';
  int selectedSubCategoryIndex = 0;

  //setCatagroyId and Index..................
  void setCategory(String categoryId, int index) {
    selectedCategoryId = categoryId;
    selectedCategoryIndex = index;
    notifyListeners();
  }

  //setSubCatagroyId and Index..................
   setSubCategory(String subCategoryId, int index) {
    selectedSubCategoryId = subCategoryId;
    selectedSubCategoryIndex = index;
    notifyListeners();
  }


}
