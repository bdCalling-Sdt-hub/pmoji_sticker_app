
import 'package:get/get.dart';

import '../../models/user_info_response_model.dart';
import '../../service/service.dart';

class UserController extends GetxController{

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
  RxBool isUserLoading = false.obs;
  Rx<UserInfoResponseModel> userModel = UserInfoResponseModel().obs;
  getUserData() async{
    isUserLoading(true);
    var response = await ApiClient.getData(ApiConstants.userMoreInformationEndPoint);
    print("user------------>${response.body}");
    if(response.statusCode == 200 || response.statusCode == 201){
      userModel.value = UserInfoResponseModel.fromJson(response.body['data']['information']);
      isUserLoading(false);
    }else{
      isUserLoading(false);
    }
  }
}