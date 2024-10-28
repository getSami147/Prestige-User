class AppUrls {
  // Base Url....
  static var baseUrl = "https://prestigereward.vercel.app/api/";
  // static var baseUrl = "http://13.245.10.125:3000/api/";

  // Base Url....
  static var urlLogin = "${baseUrl}auth/login";
  static var urlSignUp = "${baseUrl}auth/signup";
  static var urlVerfityaccountOTP = "${baseUrl}auth/verify-otp-by-email";
  static var urlResandOTP = "${baseUrl}auth/regenerate-otp";
  static var urlCompleteProfile = "${baseUrl}auth/complete-profile";
  static var urlDevicetoken = "${baseUrl}users/devicetoken";
  static var urlGetAllStates = "${baseUrl}states/all";
  static var urlLogOut = "${baseUrl}auth/logout";
  static var urlupdatePassword = "${baseUrl}auth/update-password";
  static var urlForgotPassword = "${baseUrl}auth/forgot";
  static var urlUpdateMe = "${baseUrl}users/update-me";
  static var urlGetMe = "${baseUrl}users/me";
  static var urlDeleteMe = "${baseUrl}users/delete-me";
  static var urlResetPassword = "${baseUrl}userAuth/reset-password?token=";

// GetAll
  static var urlPostfavoriteProduct = "${baseUrl}favourite-product";
  static var urlNotification = "${baseUrl}notification";
  static var urlPointFormula = "${baseUrl}point";
  static var urlPlaceOrder = "${baseUrl}order";
  static var urlGetPointHistory = "${baseUrl}point-history";
  static var urlGetByIdInviteFriend = "${baseUrl}referral-history/userdetails";
  static var urlMyTransaction = "${baseUrl}transaction";
  static var urlFeatureproduct = "${baseUrl}product";
  static var urlTermUses = "${baseUrl}term-uses?page=1&limit=1000";
  static var urlFaqs= "${baseUrl}faqs?page=1&limit=1000";
  static var urlgift = "${baseUrl}gift";
  static var urloffer = "${baseUrl}offer";
  static var urlcategory = "${baseUrl}category";
  static var urlFavouriteProduct = "${baseUrl}favourite-product";
  static var urlProductSearch = "${baseUrl}product/search?q=";
  static var urlorderSearch = "${baseUrl}order/searchbyuser";
  static var urlShopSearch = "${baseUrl}favourite-shop/search-items";
  static var urlGetAllShop = "${baseUrl}shop";
  static var urlInviteFriendPost = "${baseUrl}invite-friend";
  static var urlfavoriteshop = "${baseUrl}favourite-shop";
  static var urlContactUs = "${baseUrl}contactus";

// GetByID
  static var urlDeleteproduct = "${baseUrl}favourite-product/";
  static var urlSingleOrderDetails = "${baseUrl}order/";
  static var urlOrderByuser = "${baseUrl}order/by-user/";
  static var urluserdashbaord = "${baseUrl}admindashbaord/user";
  static var urlgetoffer1 = "${baseUrl}offer/";
  static var urlgetcategory1 = "${baseUrl}subcategory/category/";
  static var urlSingleFeatureproduct = "${baseUrl}product/slug/";
  static var urlUpdateOrder = "${baseUrl}order/update-status/";
  static var urlCurrentpoint = "${baseUrl}currentpoint/by-userid/";
  static var urlshopbyslug = "${baseUrl}shop/slug/";
  static var urldelectshop = "${baseUrl}favourite-shop/";
}
