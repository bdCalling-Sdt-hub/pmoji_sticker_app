
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/controller.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class SetNewPasswordScreen extends StatelessWidget {
   SetNewPasswordScreen({super.key});

   final GlobalKey<FormState> resetPassKey = GlobalKey<FormState>();
   TextEditingController passController = TextEditingController();
   TextEditingController secondPassController = TextEditingController();
   AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.setNewPass,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: resetPassKey,
              child: Column(
                children: [
                  SizedBox(height: 190.h,),
                  CustomText(text: AppString.setYourNewPass,fontsize: 24.sp, color: AppColors.primaryColor,),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: passController,
                    isPassword: true,
                    hintText: AppString.setNewPass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value == value.isEmpty){
                        return 'Please enter your Password';
                      }else if(!AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                    },
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: secondPassController,
                    isPassword: true,
                    hintText: AppString.setNewPass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value == value.isEmpty){
                        return 'Please enter your Password';
                      }else if(!AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                    },
                  ),
                  SizedBox(height: 24.h,),
                  Obx(()=>
                  CustomButtonCommon(
                      loading: authController.resendLoading.value == true,
                      title: AppString.setPassButton, onpress: (){
                        authController.resetPassword(passController.text, secondPassController.text);
                    },),
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
