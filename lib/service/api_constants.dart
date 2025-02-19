
class ApiConstants{
  ///===================Live Server===========================
 static const String baseUrl = "https://pmojis.com/api/v1";
 static const String imageBaseUrl = "https://pmojis.com";

  ///===================Local Server===========================
  // static const String baseUrl = "http://10.0.80.210:7070/api/v1";
  // static const String imageBaseUrl = "http://10.0.80.210:7070";

  static const String signUpEndPoint = "/user/register";
  static const String signInEndPoint = "/user/login";
  static const String verifyEmailEndPoint = "/user/verify-otp";
  static const String forgotPassEndPoint = "/user/forget-password";
  static const String resendOtpEndPoint = "/user/resend";
  static const String resetPassEndPoint = "/user/reset-password";



  static  String allStickerEndPoint() => "/sticker/all?limit=100";
  static String singleStickerEndPoint(String id) => "/sticker/sticker-detail?id=$id";

  static const String userMoreInformationEndPoint = "/user/information";
  static const String allMyPmojiEndPoint = "/sticker/my-sticker";
  static const String passCartIdiEndPoint = "/cart/add-to-cart";
  static const String getCartEndPoint = "/cart/my-cart";
  static const String getUserEndPoint = "/user/information";
  static const String updateProfileEndPoint = "/user/update";
  static const String changePassEndPoint = "/user/change-password";
  static const String promoCodePassEndPoint = "/promo-code/use-promo";
  static const String notificationEndPoint = "/notification/my-notification";
  static String singleStickerDeleteEndPoint(String id) => "/cart/delete?stickerId=$id";

}