

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controller/controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';


class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

// TextEditingController nameController = TextEditingController();
//
// TextEditingController emailController = TextEditingController();
//
// TextEditingController passController = TextEditingController();
//
// TextEditingController conPassController = TextEditingController();

   AuthController authController = Get.find<AuthController>();

   final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Sign Up", fontsize: 18.sp),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
         padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                children: [
                  SizedBox(height: 120.h,),
                  CustomText(text: "Let’s Create Your Account ", fontsize: 24.sp, color: AppColors.primaryColor,),
                  SizedBox(height: 24.h,),
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  authController.nameController,
                      hintText: AppString.enterYourName,
                      borderColor: AppColors.primaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.profile, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  authController.emailController,
                      hintText: AppString.enterYourEmail,
                      borderColor: AppColors.primaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.email, color:
                        AppColors.primaryColor, height: 20.h, width: 20.w),
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
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller:  authController.passController,
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
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CustomTextField(
                      controller: authController.conPassController,
                      isPassword: true,
                      hintText: AppString.enterYourPassCon,
                      borderColor: AppColors.primaryColor,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.passIcon, color:
                        AppColors.primaryColor, height: 24.h, width: 24.w),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your Confirm Password';
                        }else if(value !=  authController.passController.text){
                          return "Password Not Match";
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),

                  Obx(()=>
                 CustomButtonCommon(
                      loading: authController.signUpLoading.value == true,
                      title: AppString.signUpButton, onpress: (){
                      if(_fromKey.currentState!.validate()){
                        authController.signUpHandle();
                      }
                    //  Get.off(()=> EmailVerifyScreen(isUpdatePassScreen: false, isSignUpScreen: true,),preventDuplicates:  false);
                    },),
                  ),
                  SizedBox(height: 80.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: AppString.allReadyAccount,fontsize: 20.sp,),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.loginScreen);
                          },
                          child: CustomText(
                              text: AppString.signIn,
                              color: AppColors.primaryColor,fontsize: 20.sp,),),
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
