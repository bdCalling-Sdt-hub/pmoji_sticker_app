

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() async{
      var  token = await PrefsHelper.getString(AppConstants.bearerToken);
      if(token != "" && token != null){
        Get.toNamed(AppRoutes.bottomBarScreen,preventDuplicates: false);
      }else{
        Get.toNamed(AppRoutes.onboardingScreen,preventDuplicates: false);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 64.w),
                child: Image.asset(
                  AppImages.splashImg1,
                  color: AppColors.cardColorE9F2F9,
                ),
              ),
            ],
          ),
        )
    );
  }
}
