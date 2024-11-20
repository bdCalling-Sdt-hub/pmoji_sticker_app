

import 'package:get/get.dart';

import '../views/screens/screens.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String onboardingScreen = "/onboardingScreen.dart";
  static const String signUpScreen = "/signUpScreen.dart";
  static const String emailVerifyScreen = "/emailVerifyScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String forgotScreen = "/forgotScreen.dart";
  static const String setNewPasswordScreen = "/setNewPassword.dart";
  static const String homeScreen = "/homeScreen.dart";
  static const String homeDetailsScreen = "/homeDetailsScreen.dart";
  static const String notificationScreen = "/notification.dart";
  static const String paymentMethod = "/paymentMethod.dart";
  static const String promoCodeScreen = "/promoCodeScreen.dart";
  static const String congratulationsScreen = "/congratulationsScreen.dart";
  static const String myPmojisScreen = "/myPmojisScreen.dart";
  static const String pmojisCartScreen = "/pmojisCartScreen.dart";
  static const String myProfileScreen = "/myProfileScreen.dart";
  static const String myEditProfileScreen = "/myEditProfileScreen.dart";
  static const String settingsScreen = "/settingsScreen.dart";
  static const String changePassScreen = "/changePassScreen.dart";
  static const String privacyPolicyScreen = "/privacyPolicyScreen.dart";
  static const String aboutScreen = "/aboutScreen.dart";
  static const String termConScreen = "/termConScreen.dart";
  static const String bottomBarScreen = "/bottomBarScreen.dart";

  static List<GetPage> get routes => [
         GetPage(name: splashScreen, page: () =>  SplashScreen()),
         GetPage(name: onboardingScreen, page: () =>  OnboardingScreen()),
         GetPage(name: signUpScreen, page: () => SignUpScreen()),
         GetPage(name: emailVerifyScreen, page: () => EmailVerifyScreen()),
         GetPage(name: loginScreen, page: () =>  LoginScreen()),
         GetPage(name: forgotScreen, page: () => const ForgotPasswordScreen()),
         GetPage(name: setNewPasswordScreen, page: () =>  SetNewPasswordScreen()),
         GetPage(name: homeScreen, page: () =>  HomeScreen()),
         GetPage(name: homeDetailsScreen, page: () =>   HomeDetailsScreen()),
         GetPage(name: notificationScreen, page: () =>  NotificationScreen()),
         GetPage(name: paymentMethod, page: () => const  PaymentScreen()),
         GetPage(name: promoCodeScreen, page: () =>   PromoCodeScreen()),
         GetPage(name: congratulationsScreen, page: () =>  CongratulationsScreen(isPassChange: Get.arguments ?? true,)),
         GetPage(name: myPmojisScreen, page: () =>   MyPmojisScreen()),
         GetPage(name: pmojisCartScreen, page: () =>   PmojisCartScreen()),
         GetPage(name: myProfileScreen, page: () =>   MyProfileScreen()),
         GetPage(name: myEditProfileScreen, page: () => ProfileEditScreen()),
         GetPage(name: settingsScreen, page: () => const SettingsScreen()),
         GetPage(name: changePassScreen, page: () =>  ChangePasswordScreen()),
         GetPage(name: privacyPolicyScreen, page: () =>  PrivacyScreen()),
         GetPage(name: aboutScreen, page: () =>  AboutScreen()),
         GetPage(name: termConScreen, page: () =>  TermAndCondition()),
         GetPage(name: bottomBarScreen, page: () => const BottomBar()),
      ];
}
