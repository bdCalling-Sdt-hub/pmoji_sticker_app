
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../service/service.dart';
import '../../utils/utils.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getUserData();
    getPrivacyData();
    getTermData();
    getAboutData();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    getUserData();
    super.dispose();
  }
  var imageFile = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  // Function to pick image from the gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Function to pick image from the camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }


  var profileData = {}.obs; // Initial profile data


  /// ============get profile=============
  RxBool isProfile = false.obs;
  RxString promoCode = ''.obs;
  Rx<ProfileResponseModel> getUserDataModel = ProfileResponseModel().obs;
 getUserData() async {
    try{
      isProfile(true);
      var response = await ApiClient.getData(ApiConstants.getUserEndPoint);
      print("usertData========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.setString(AppConstants.promoCode, response.body['data']['information']["promoCode"]);
        getUserDataModel.value = ProfileResponseModel.fromJson(response.body['data']);
        promoCode.value = response.body['data']['information']["promoCode"];
        isProfile(false);
      }else{
        isProfile(false);
      }
    }
    catch(e){
     // ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isProfile(false);
    }
  }


  ///=================Edit Profile===================
  RxBool updateProfileLoading = false.obs;

 updateProfile({
   File? image,
   String? name,
   phone, address
  }) async {
    updateProfileLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];

    var body = {
      "name": '$name',
      "address": '$address',
      "phone": '$phone',
    };
    var response = await ApiClient.postMultipartData(
        ApiConstants.updateProfileEndPoint, body,
        multipartBody: multipartBody);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      await PrefsHelper.setString(AppConstants.userName, response.body['data']['name']);
      await PrefsHelper.setString(AppConstants.phone, response.body['data']['phone'].toString());
     await PrefsHelper.setString(AppConstants.image, response.body['data']['image']["publicFileURL"]);
      ToastMessageHelper.successMessageShowToster('Profile Updated Successful');

      getUserData();
      update();
      updateProfileLoading(false);
    }else{
      updateProfileLoading(false);
    }
  }




  ///=================Change Password===================
  RxBool changePassLoading = false.obs;
  changePassword({
    String? oldPass, newPass, conPass
  }) async {
    changePassLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = {
      "oldPassword": '$oldPass',
      "newPassword": '$newPass',
      "confirmPassword": '$conPass',
    };
    var response = await ApiClient.postData(
        ApiConstants.changePassEndPoint, jsonEncode(body),
      headers: headers
       );

    print("=======>change pass:: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      ToastMessageHelper.successMessageShowToster(response.body['message']);
      changePassLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      changePassLoading(false);
    }
  }




  /// ============get Privacy Policy=============
  RxBool isPrivacy = false.obs;
  RxList<PrivacyResponseModel> getPrivacyModel = <PrivacyResponseModel>[].obs;
  Future<void> getPrivacyData() async {
    try{
      isPrivacy(true);
      var response = await ApiClient.getData("/privacy/all");
      print("usertData========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body;
        getPrivacyModel.value = List<PrivacyResponseModel>.from(
          responseData['data'].map(
                (element) => PrivacyResponseModel.fromJson(element),
          ),
        );
        isPrivacy(false);
      }else{
        isPrivacy(false);
      }
    }
    catch(e){
      ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isPrivacy(false);
    }
  }


  /// ============get Term and Condition Policy=============
  RxBool isTerm = false.obs;
  RxList<TermAndConResponseModel> getTermModel = <TermAndConResponseModel>[].obs;
  Future<void> getTermData() async {
    try{
      isTerm(true);
      var response = await ApiClient.getData("/terms/all");
      print("usertData========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body;
        getTermModel.value = List<TermAndConResponseModel>.from(
          responseData['data'].map(
                (element) => TermAndConResponseModel.fromJson(element),
          ),
        );
        isTerm(false);
      }else{
        isTerm(false);
      }
    }
    catch(e){
      ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isTerm(false);
    }
  }





  /// ============get About =============
  RxBool isAbout = false.obs;
  RxList<AboutResponseModel> getAboutModelList = <AboutResponseModel>[].obs;
  Future<void> getAboutData() async {
    try{
      isAbout(true);
      var response = await ApiClient.getData("/about/all");
      print("usertData========>${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body;
        getAboutModelList.value = List<AboutResponseModel>.from(
          responseData['data'].map(
                (element) => AboutResponseModel.fromJson(element),
          ),
        );
        isAbout(false);
      }else{
        isAbout(false);
      }
    }
    catch(e){
      ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isAbout(false);
    }
  }



}