
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends GetxController {

  RxBool isLoaded = false.obs;

  Widget loading({
    required BuildContext context,
    required double containerHeight,
    required double containerWidth,
    required Color loadedColor,
  }) {
    return Container(
      height: containerHeight,
      width: containerWidth,
      child: Center(
        child: CircularProgressIndicator(color: loadedColor,),
      ),
    );
  }
}