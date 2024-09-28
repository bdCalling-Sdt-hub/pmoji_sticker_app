
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/utils.dart';

class CustomBottomBar extends StatelessWidget {
  final BuildContext context;
  final bool isHome;
  final bool isMyPomij;
  final bool isPomijCart;
  final bool isProfile;
  // final GlobalKey<ScaffoldState> key;
  const CustomBottomBar({super.key, required this.context, required this.isHome, required this.isMyPomij, required this.isPomijCart, required this.isProfile, });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Color(0xffEfF1EE),
            // borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(24.r),
            // topRight: Radius.circular(24.r)
            // ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          InkWell(
            onTap: (){
              Get.toNamed(AppRoutes.homeScreen);
            },
            child: Container(
            height: 90.h,
            width: 90.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage( isHome == true ? AppImages.homeIconSelected : AppImages.homeIconUnSelected),
                fit: BoxFit.contain,
              ),
            )
            ),
          ),
            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.myPmojisScreen);
              },
              child: Container(
                  height: 85.h,
                  width: 85.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(isMyPomij == true ? AppImages.pomijIconBottomSelect: AppImages.pomijIconBottomUnSelect),
                      fit: BoxFit.contain,
                    ),
                  )
              ),
            ),
            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.pmojisCartScreen);
              },
              child: Container(
                  height: 85.h,
                  width: 85.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(isPomijCart == true ? AppImages.pomijCartBottomSelect: AppImages.pomijCartBottomUnSelect),
                      fit: BoxFit.contain,
                    ),
                  )
              ),
            ),
            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.myProfileScreen);
                },
              child: Container(
                  height: 90.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage(isProfile == true ? AppImages.profileIconBottomSelect: AppImages.profileIconBottomUnSelect),
                      fit: BoxFit.contain,
                    ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


