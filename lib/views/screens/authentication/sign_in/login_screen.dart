
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController(text:"info.nurislamrajib@gmail.com");
    TextEditingController passController = TextEditingController(text: "1qazxsw2");
    LoadingWidget loadingWidget = Get.put(LoadingWidget());
    final GlobalKey<FormState> _logKey = GlobalKey<FormState>();
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.signIn,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: _logKey,
              child: Column(
                children: [
                  SizedBox(height: 160.h,),
                  CustomText(text: AppString.signInContinue, fontsize: 24.sp,color: AppColors.primaryColor,),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: emailController,
                    hintText: AppString.enterYourEmail,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.email, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Email';
                      }else if(!AppConstants.emailValidate.hasMatch(value)){
                        return "Invalid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: passController,
                    isPassword: true,
                    hintText: AppString.enterYourPass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Password';
                      }else if(value.length < 8 || !AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h,),
                  Obx(() {
                   return CustomButtonCommon(
                      loading: authController.loadingLoading.value == true,
                      title: AppString.signIn,
                      onpress: () {
                        if (_logKey.currentState!.validate()) {
                          authController.loginHandle(
                              emailController.text, passController.text);
                        }
                      },);
                  }
                  ),
                  SizedBox(height: 24.h,),
                  InkWell(
                    onTap: (){Get.toNamed(AppRoutes.forgotScreen,
                    parameters: {
                      'email': emailController.text
                    }
                    );},
                      child: CustomText(text: AppString.forgotPass, fontsize: 20.sp,color: AppColors.primaryColor,)),
                  SizedBox(height: 24.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: AppString.dontHaveAccount, fontsize: 20.sp,),
                      InkWell(
                          onTap: (){
                            Get.toNamed(AppRoutes.signUpScreen);
                          },
                          child: CustomText(text: AppString.signUpButton, fontsize: 20.sp,color: AppColors.primaryColor,)),
                    ],
                  ),




                ],
                        ),
            ),
                ),
        ),
      ),
    );
  }
}
