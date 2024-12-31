
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../controller/controller.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../bottom_bar.dart';
import '../screens.dart';


class OnboardingScreen extends StatelessWidget {
   OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading:  SizedBox.shrink(),
        title: CustomText(text: "Pmoji",fontsize: 30,fontWeight: FontWeight.w400,color: AppColors.primaryColor,)
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 64.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 32.w),
                child: Image.asset(AppImages.pmoji,height: 411.h,width: 330.w,),
              ),
              SizedBox(height: 92.h,),
              CustomText(text: AppString.onBoardText,fontsize: 24.sp,fontWeight: FontWeight.w400,color: AppColors.hitTextColor000000, left: 20.w,right: 20.w,),
              SizedBox(height: 24.h,),
              CustomButtonCommon(title: AppString.onBoardTextStart, onpress: () async{
                  Get.toNamed(AppRoutes.loginScreen,preventDuplicates: false);

              //  Get.toNamed(AppRoutes.loginScreen);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
