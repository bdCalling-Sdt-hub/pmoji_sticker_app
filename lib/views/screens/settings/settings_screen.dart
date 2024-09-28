
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: AppString.settings,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                CustomContainerText(title: AppString.changePass, onpress: (){
                  Get.toNamed(AppRoutes.changePassScreen);
                },textAlign: TextAlign.left, fontSize: 16.sp,),
                SizedBox(height: 20.h,),
                CustomContainerText(title: AppString.privacyPolicy, onpress: (){
                  Get.toNamed(AppRoutes.privacyPolicyScreen);
                },textAlign: TextAlign.left, fontSize: 16.sp,),
                SizedBox(height: 20.h,),
                CustomContainerText(title: AppString.termCon, onpress: (){
                  Get.toNamed(AppRoutes.termConScreen);
                },textAlign: TextAlign.left, fontSize: 16.sp,),
                SizedBox(height: 20.h,),
                CustomContainerText(title: AppString.aboutUs, onpress: (){
                  Get.toNamed(AppRoutes.aboutScreen);
                },textAlign: TextAlign.left, fontSize: 16.sp,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
