

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class ChangePasswordScreen extends StatefulWidget {
   ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
TextEditingController oldPasswordController = TextEditingController();

TextEditingController newPasswordController = TextEditingController();

TextEditingController reTypePasswordController = TextEditingController();
ProfileController profileController = Get.put(ProfileController());
final GlobalKey<FormState> changePasKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: (){Get.toNamed(AppRoutes.bottomBarScreen);},
            child: CustomText(text: AppString.changePass,fontsize: 18.sp,)),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Form(
              key: changePasKey,
              child: Column(
                children: [
                  SizedBox(height: 130.h,),
                  CustomText(text: AppString.changePass,fontsize: 24.sp,color: AppColors.primaryColor,),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: oldPasswordController,
                    isPassword: true,
                    hintText: AppString.oldPass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Password';
                      }else if(!AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: newPasswordController,
                    isPassword: true,
                    hintText: AppString.newPass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Password';
                      }else if(!AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller: reTypePasswordController,
                    isPassword: true,
                    hintText: AppString.reTypePass,
                    borderColor: AppColors.primaryColor,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.passIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Password';
                      }else if(!AppConstants.validatePassword(value)){
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h,),
                  InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.forgotScreen);
                      },
                      child: CustomText(text: AppString.forgotPass,fontsize: 20.sp,color: AppColors.primaryColor,)),
                  SizedBox(height: 24.h,),
                  CustomButtonCommon(title: AppString.changePass, onpress: (){
                    if(changePasKey.currentState!.validate()){
                      profileController.changePassword(
                        oldPass:oldPasswordController.text,
                        newPass: newPasswordController.text,
                        conPass: reTypePasswordController.text,
                      );
                    }
                   // Get.toNamed(AppRoutes.congratulationsScreen, arguments: true);
                   //  Get.off(()=> const CongratulationsScreen(isPassChange: true,),preventDuplicates: false);
                 //   Get.off(()=> const SettingsCongratulationsScreen(),preventDuplicates: false);
                  },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
