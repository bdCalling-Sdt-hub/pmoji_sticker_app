
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../routes/app_routes.dart';
import '../../service/service.dart';
import '../../utils/utils.dart';

class AuthController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conPassController = TextEditingController();

 // UserData userData = Get.find<UserData>();
  RxBool signUpLoading = false.obs;
  ///===========Sing up===========<>
  Future<void> signUpHandle(
      // String nameController,
      // String email,
      // String password,
      // String conPassword
      ) async{
    signUpLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passController.text,
      "confirmPassword": conPassController.text
    };
    var response = await ApiClient.postData(
        ApiConstants.signUpEndPoint,
        jsonEncode(body),
      headers: headers,
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      var data = response.body['data'];
     await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
     await PrefsHelper.setString(AppConstants.email, emailController.text);
      print("pritn tokkkkken :: ${data['token']}");
      Get.toNamed(AppRoutes.emailVerifyScreen, parameters: {
        'email':emailController.text
      });
      ToastMessageHelper.successMessageShowToster(
          response.body['message'].toString());
      signUpLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      signUpLoading(false);
    }
  }



///===========Otp Verify===========<>
RxBool verifyLoading = false.obs;
   otpVerify(String otp,) async{
    verifyLoading(true);
  String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "otp": otp,
    };
    var response = await ApiClient.postData("/user/verify-otp",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      print("token==================> ${response.body['data']}");
      // var data = response.body['data'];
      // await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
      Get.toNamed(AppRoutes.loginScreen,);
      ToastMessageHelper.successMessageShowToster(
          response.body['message'].toString());
      verifyLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      verifyLoading(false);
    }
    }



///===========login===========<>

  RxBool loadingLoading = false.obs;
loginHandle(String email, String password) async{
  loadingLoading(true);
     var headers = {'Content-Type': 'application/json'};
     var body =
         {
           'email': email,
           'password': password
         };

     
     var response = await ApiClient.postData(ApiConstants.signInEndPoint, jsonEncode(body),
     headers: headers
     );

     
     print("tokennnnnn =========== ${response.body}");
     if(response.statusCode == 200 || response.statusCode == 201){
       var data = response.body['data'];
       await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
       await PrefsHelper.setString(AppConstants.email, email);
       await PrefsHelper.setString(AppConstants.userId, data['user']['id']);
       await PrefsHelper.setString(AppConstants.userName, data['user']['name']);
       Get.toNamed(AppRoutes.bottomBarScreen,);
       ToastMessageHelper.successMessageShowToster(response.body['message']);
       loadingLoading(false);
     }else{
       loadingLoading(false);
       ToastMessageHelper.errorMessageShowToster(response.body['message']);

     }
}



///===================Forgot Password ======================


  RxBool forgotLogin = false.obs;
   forgotHandle(String email, screenType) async {
  forgotLogin(true);
  var body = {
    'email': email
  };

  var response = await ApiClient.postData(
      ApiConstants.forgotPassEndPoint,
      jsonEncode(body));

  if (response.statusCode == 200 || response.statusCode == 201) {
    var data = response.body['data'];
    await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
    ToastMessageHelper.successMessageShowToster(response.body['message']);
    Get.toNamed(AppRoutes.emailVerifyScreen,
        parameters: {"screenType": "forgot", 'email': email});
    forgotLogin(false);
  } else {
    {
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      forgotLogin(false);
    }
  }
}



///==========================Resend========<>

RxBool resendLoading = false.obs;

resendOTP(String email) async{
  resendLoading(true);
  String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $bearerToken'
  };
  var body = {"email": email};
  print(body['email']);
  var response = await ApiClient.postData(
    ApiConstants.resendOtpEndPoint,
    jsonEncode(body),
    headers: headers
  );
  print("responseeeeeeeeee ${response.body}");
  if(response.statusCode == 200 || response.statusCode == 201){
    ToastMessageHelper.successMessageShowToster(response.body['message']);
    resendLoading(false);
  }
}



  ///===========Otp Verify===========<>
  RxBool forgotOtpLoading = false.obs;
  forgotOtpVerify(String forgotOtp, String email) async{
    forgotOtpLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {
      "otp": forgotOtp,
    };
    var response = await ApiClient.postData("/user/verify-forget-otp?email=$email",
        jsonEncode(body),
        headers: headers
    );
    print("dataaaaaaaaaaaaaaa ${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      print("token==================> ${response.body['data']}");
      // var data = response.body['data'];
      // await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
      Get.toNamed(AppRoutes.setNewPasswordScreen);
      ToastMessageHelper.successMessageShowToster(
          response.body['message'].toString());
      forgotOtpLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message'].toString());
      print("token==================> ${response.body['data']}");
      forgotOtpLoading(false);
    }
  }





  ///===============reset password ========================<>
  RxBool isResetLoading = false.obs;
  resetPassword(String firstController, String secondController) async{

    isResetLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "password":firstController,
      "confirmPassword":secondController
    };
    
    var response = await ApiClient.postData("${ApiConstants.resetPassEndPoint}?email=${emailController.text}", jsonEncode(body),headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201){
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      Get.toNamed(AppRoutes.loginScreen);
      isResetLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      isResetLoading(false);
    }

  }

}


