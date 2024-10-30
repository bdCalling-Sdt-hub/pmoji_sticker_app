
import 'dart:convert';

import 'package:get/get.dart';

import '../helpers/helpers.dart';
import '../routes/app_routes.dart';
import '../service/service.dart';
import '../utils/utils.dart';



class PromoCodeController extends GetxController{

  ///==============promo Code==========
@override
  void onInit() {
    // TODO: implement onInit
  sendPromoCode();
    super.onInit();
  }
  RxBool isPromoCodeLoading = false.obs;
RxString promoCode = "".obs;
 Future<void> sendPromoCode({
    String? proCode,
  }) async {
    isPromoCodeLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = {
      "promoCode": '$proCode',
    };
    var response = await ApiClient.postData(
        ApiConstants.promoCodePassEndPoint, jsonEncode(body),
        headers: headers
    );

    print("=======>Promo code:: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      promoCode.value = response.body['data']['promoCode'];
      print(promoCode.value);
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      Get.toNamed(AppRoutes.congratulationsScreen, arguments: false,preventDuplicates: false);


      isPromoCodeLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      isPromoCodeLoading(false);
    }
  }

}