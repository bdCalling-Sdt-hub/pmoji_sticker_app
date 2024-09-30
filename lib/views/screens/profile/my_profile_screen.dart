
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../helpers/helpers.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class MyProfileScreen extends StatelessWidget {
   MyProfileScreen({super.key});

   ProfileController profileController = Get.find<ProfileController>();

   LoadingWidget loadingWidget = Get.put(LoadingWidget());

   String pfkdhf = "";

  @override
  Widget build(BuildContext context) {
    profileController.getUserData();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(text: AppString.myProfile,fontsize: 18.sp,),),
      body: Obx(() {
        var userData = profileController.getUserDataModel.value;
        return  loadingWidget.isLoaded.value ? loadingWidget.loading(context: context, containerHeight: 24,containerWidth: 24, loadedColor: Colors.red)
            : Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.radiusExtraLarge.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),

                  ///------------------------Profile Container----------------------------?>
                  Container(
                    height: 166.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),

                    ),
                    child: Column(
                      children: [

                        SizedBox(height: 16.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            ///------------------------Profile Image----------------------------?>
                         userData.information?.image?.publicFileUrl == null && userData.information?.image?.publicFileUrl == ""?
                        CustomImageContainer(
                          height: 70.h,
                          imageWidth: 70.w,
                          isNetworkImage: false,
                          imagePath: AppImages.profileImage,
                          boxShape: BoxShape.circle,
                          imageBoxFit: BoxFit.cover,
                        ): CustomImageContainer(
                              height: 70.h,
                              imageWidth: 50.w,
                              isNetworkImage: true,
                              imagePath: userData.information?.image?.publicFileUrl,
                              boxShape: BoxShape.circle,
                              imageBoxFit: BoxFit.cover,
                            ),

                            ///------------------------Profile Name----------------------------?>
                            CustomText(text: userData.information?.name ?? "N/A",
                              fontsize: 20.sp,
                              color: AppColors.whiteColor,),

                            ///------------------------Profile Setting----------------------------?>
                            InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.settingsScreen,arguments: userData);
                                },
                                child: SvgPicture.asset(
                                    AppIcons.profileSetting, height: 18.h,
                                    width: 18.w)),

                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(height: 8.h,),

                        ///------------------------Profile Edit----------------------------?>
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.myEditProfileScreen,arguments: userData);
                          },
                          child: Container(
                            height: 28.h,
                            width: 106.w,
                            decoration: BoxDecoration(
                                color: Color(0xffE8F1EE),
                                borderRadius: BorderRadius.circular(4.r)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.edit, weight: 13.w,
                                  size: 14.sp,
                                  color: AppColors.primaryColor,),
                                CustomText(text: AppString.editProfile,
                                  fontsize: 14.sp,
                                  color: AppColors.primaryColor,),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h,),

                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),

                  CustomIconTextListTile(
                    title:  userData.information?.name ?? "N/A",
                    onTap: () {},
                    prefixIcon: SvgPicture.asset(
                        AppIcons.profile, color: AppColors.primaryColor,
                        height: 24.h,
                        width: 24.w),
                  ),
                  SizedBox(height: 20.h,),
                  CustomIconTextListTile(
                    title:  userData.information?.email ?? "N/A",
                    onTap: () {},
                    prefixIcon: SvgPicture.asset(
                        AppIcons.email, color: AppColors.primaryColor,
                        height: 24.h,
                        width: 24.w),
                  ),
                  SizedBox(height: 20.h,),
                  CustomIconTextListTile(
                    title: userData.information?.phone ?? "N/A",
                    onTap: () {},
                    prefixIcon: SvgPicture.asset(
                        AppIcons.callIcon, color: AppColors.primaryColor,
                        height: 24.h,
                        width: 24.w),
                  ),
                  SizedBox(height: 20.h,),
                  CustomIconTextListTile(
                    title:  userData.information?.address ?? "N/A",
                    onTap: () {},
                    prefixIcon: SvgPicture.asset(
                        AppIcons.locationIcon, color: AppColors.primaryColor,
                        height: 24.h,
                        width: 24.w),
                  ),
                  SizedBox(height: 24.h,),

                  ///================Log out ================>
                  CustomIconTextListTile(
                    prefixIcon: SvgPicture.asset(AppIcons.logOutIcons,
                        color: AppColors.primaryColor),
                    //  sufixIcon: SvgPicture.asset(AppIcons.arrowRight),
                    title: AppString.loOut,
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
                                      text: AppString.areYouSure,
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
                                                color: AppColors.primaryColor,
                                                title: 'Yes',
                                                fontSize: 16.h,
                                                onpress: () async {
                                                  profileController.promoCode.value = "";
                                                  await PrefsHelper.remove(
                                                      AppConstants.promoCode);
                                                  await PrefsHelper.remove(AppConstants.userName);
                                                  await PrefsHelper.remove(AppConstants.phone);
                                                  await PrefsHelper.remove(AppConstants.image);
                                                  await PrefsHelper.remove(AppConstants.email);
                                                  await PrefsHelper.remove(AppConstants.isLogged);
                                                  Get.offNamed(
                                                      AppRoutes.loginScreen);
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
        );

      }
      ),
    );
  }
}
