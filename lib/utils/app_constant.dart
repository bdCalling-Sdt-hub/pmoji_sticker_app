
class AppConstants{

  ///=======================Prefs Helper data===============================>
  static const String role = "role";
  // static String roleMock = 'roleMock';
  static String bearerToken = 'token';
  static String email = 'email';
  static String isLogged = 'true';
  static String userId = 'id';
  static String userName = 'name';
  static String image = '';
  static String promoCode = '';

  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{8,}$');
    return regex.hasMatch(value);
  }
}
enum Status { loading, completed, error, internetError }