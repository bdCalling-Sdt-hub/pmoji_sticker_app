
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.paymentMethod,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Column(
              children: [
                SizedBox(height: 20.h,),
                CustomText(text: AppString.paymentText,fontsize: 16.sp,),
                SizedBox(height: 20.h,),
                ///------------------------Master Cart----------------------------?>
                Container(
                  height: 64.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffE8F1EE),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24.w),
                        child: SvgPicture.asset(AppIcons.masterCart, height: 32.h, width: 41.w),
                      ),
                      SizedBox(width: 16.w,),
                      CustomText(text: "Cards",fontsize: 18.sp,),
                      SizedBox(width: 180.w,),
                   isSelected == true ? SvgPicture.asset(AppIcons.paymentSelectedIcon, height: 20.h, width: 20.w):SvgPicture.asset(AppIcons.unselectedIcon, height: 20.h, width: 20.w),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                ///-----------------------Promo Code----------------------------?>
                // InkWell(
                //   onTap: (){
                //     Get.toNamed(AppRoutes.promoCodeScreen);
                //   },
                //   child: Container(
                //     height: 64.h,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       color: Color(0xffE8F1EE),
                //       borderRadius: BorderRadius.circular(8.r),
                //     ),
                //     child: Row(
                //       children: [
                //         Padding(
                //           padding: EdgeInsets.only(left: 24.w),
                //           child: SvgPicture.asset(AppIcons.coponIcon, height: 32.h, width: 41.w),
                //         ),
                //         SizedBox(width: 16.w,),
                //         CustomText(text: "Promo Code",fontsize: 18.sp,),
                //         SizedBox(width: 136.w,),
                //         isSelected == false ? SvgPicture.asset(AppIcons.paymentSelectedIcon, height: 20.h, width: 20.w):SvgPicture.asset(AppIcons.unselectedIcon, height: 20.h, width: 20.w),
                //       ],
                //     ),
                //   ),
                // ),
                 SizedBox(height: 434.h,),
                ///-----------------------Make Payment Button----------------------------?>
                CustomButtonCommon(title: AppString.paymentButton,onpress: (){
                 // Get.toNamed(AppRoutes.paymentMethod);
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
