
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../service/service.dart';

class NotificationController extends GetxController{
  final ScrollController scrollController = ScrollController();
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);

  void loadMore() {
    print('=====> ${totalPage > page.value}');
    if (totalPage > page.value) {
      page.value++;
      update();
      getNotificationData();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  void _addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
          loadMore();
        print("load more true");
      }
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    notificationList.clear();
    getNotificationData();
    _addScrollListener();
    super.onInit();
  }


  RxBool isNotiLoading = false.obs;

  RxList<AllNotificationResponseModel> notificationList = <AllNotificationResponseModel>[].obs;
  Future<void> getNotificationData() async{
isNotiLoading(true);
      var response = await ApiClient.getData("${ApiConstants.notificationEndPoint}?page=${page.value}");

      print("Notification body ==================${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        totalPage = jsonDecode(response.body['data']['totalPages'].toString());
        currectPage = jsonDecode(response.body['data']['currentPage'].toString());
        totalResult = jsonDecode(response.body['data']['totalNotifications'].toString()) ?? 0;
        var responseData = response.body;
        notificationList.value = List<AllNotificationResponseModel>.from(
          responseData['data']['notifications'].map(
                (element) => AllNotificationResponseModel.fromJson(element),
          ),
        );
        isNotiLoading(false);
      }else{
        ToastMessageHelper.errorMessageShowToster(response.body['message']);
        isNotiLoading(false);
      }
    }

}