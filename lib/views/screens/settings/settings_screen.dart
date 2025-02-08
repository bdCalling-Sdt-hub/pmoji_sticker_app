
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stripe_payments/controller/controller.dart';

import '../../../helpers/helpers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({super.key});
   ProfileController profileController = ProfileController();

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
                SizedBox(height: 120.h,),
                ///================Log out ================>
                CustomIconTextListTile(

                  prefixIcon: Icon(Icons.delete,color: Colors.red,),
                  // prefixIcon: SvgPicture.asset(AppIcons.logOutIcons,
                  //     color: AppColors.primaryColor),
                  //  sufixIcon: SvgPicture.asset(AppIcons.arrowRight),
                  title: "Delete Account",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 26.h),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text:"Are You Sure Delete Your Account",
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    maxline: 2,
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 120.w,
                                          height: 40.h,
                                          child: CustomButton(
                                            title: 'No',
                                            fontSize: 16.h,
                                            onpress: () {
                                              Get.back();
                                            },
                                            color: Colors.white,
                                            titlecolor: AppColors
                                                .primaryColor,
                                          )),
                                      SizedBox(
                                          width: 120.w,
                                          height: 40.h,
                                          child: CustomButton(
                                              color: Colors.red,
                                              title: 'Yes',
                                              fontSize: 16.h,
                                              onpress: () async {
                                                 profileController.deleteAccount();
                                                await PrefsHelper.remove(
                                                    AppConstants.promoCode);
                                                await PrefsHelper.remove(AppConstants.userName);
                                                await PrefsHelper.remove(AppConstants.phone);
                                                await PrefsHelper.remove(AppConstants.image);
                                                await PrefsHelper.remove(AppConstants.email);
                                                await PrefsHelper.remove(AppConstants.isLogged);
                                                await PrefsHelper.remove(AppConstants.bearerToken);

                                              })),
                                    ],
                                  )
                                ],
                              ),
                              elevation: 12.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  side: BorderSide(
                                      width: 1.w,
                                      color: AppColors.primaryColor)));
                        });
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
