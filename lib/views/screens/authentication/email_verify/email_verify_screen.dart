


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controller/controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class EmailVerifyScreen extends StatelessWidget {
   EmailVerifyScreen({super.key,});
   bool isUpdatePassScreen = false;
   bool isSignUpScreen = false;

   TextEditingController picController = TextEditingController();
   AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.oTPVerify,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Column(
              children: [
                SizedBox(height: 170.h,),
               isUpdatePassScreen == false ? CustomText(text: AppString.checkVerifyEmail,fontsize: 16.sp,): CustomText(text: AppString.checkVerifyEmail1,fontsize: 16.sp,),
                SizedBox(height: 24.h,),
                CustomPinCodeTextField(textEditingController: picController,),
                SizedBox(height: 24.h,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: AppString.dontGetCode,fontsize: 18.sp,),
                    InkWell(
                        onTap: (){
                          authController.resendOTP("${Get.parameters['email']}");
                        },
                        child: CustomText(text: "Resend",fontsize: 18.sp,color: AppColors.primaryColor,)),
                  ],

                ),
                SizedBox(height: 24.h,),
                CustomButtonCommon(
                  loading:authController.forgotOtpLoading.value ,
                  title: AppString.verifyButton, onpress: (){
                  if(Get.parameters['screenType'] == 'forgot'){
                   authController.forgotOtpVerify(picController.text);
                   // Get.toNamed(AppRoutes.setNewPasswordScreen);
                  } else{
                    authController.otpVerify(picController.text);
                  }

                //  isSignUpScreen == true ? Get.toNamed(AppRoutes.loginScreen):Get.toNamed(AppRoutes.setNewPasswordScreen) ;
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
