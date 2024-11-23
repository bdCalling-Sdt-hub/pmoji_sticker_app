

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controller/controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}


class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState(){
    authController.emailController.text = Get.parameters['email'] ?? '';
    super.initState();
  }

  final GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  AuthController authController = Get.find<AuthController>();
  //TextEditingController emailController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.forgotPass1,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
          child: SingleChildScrollView(
            child: Form(
              key: forgotKey,
              child: Column(
                children: [
                  SizedBox(height: 210.h,),
                  CustomText(text: AppString.enterForgotEmail,fontsize: 20.sp,),
                  SizedBox(height: 24.h,),
                  CustomTextField(
                    controller:  authController.emailController,
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
                  Obx(()=>
                   CustomButtonCommon(
                      loading: authController.forgotLogin.value,
                      title: AppString.sendOTP, onpress: (){
                      if(forgotKey.currentState!.validate()){
                        authController.forgotHandle( authController.emailController.text, "forgot");
                      }
                     // Get.off(()=> EmailVerifyScreen(isUpdatePassScreen: true, isSignUpScreen: false,),preventDuplicates:  false);
                    // Get.toNamed(AppRoutes.emailVerifyScreen, );
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
