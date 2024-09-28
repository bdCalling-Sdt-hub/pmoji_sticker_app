
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key, required this.isPassChange});
final bool isPassChange;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.congratulationIcon, height: 170.h, width: 170.w),
            SizedBox(height: 16.h,),
            CustomText(text: "Congratulations!",color: AppColors.primaryColor, fontsize: 30.sp,),
            SizedBox(height: 16.h,),
            CustomText(text: AppString.congratulationText,fontsize: 18.sp,),
            SizedBox(height: 16.h,),
            CustomButtonCommon(title: isPassChange != true ? AppString.backHome: AppString.backSettings, width: 190.w,
              onpress: (){
              Get.back();
              Get.back();
             // isPassChange != true ?   Get.toNamed(AppRoutes.bottomBarScreen):Get.toNamed(AppRoutes.bottomBarScreen);
            },),
          ],
        ),
      ),
    );
  }
}
