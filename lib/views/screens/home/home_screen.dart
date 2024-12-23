// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/controller.dart';
// import '../../../helpers/helpers.dart';
// import '../../../models/models.dart';
// import '../../../routes/app_routes.dart';
// import '../../../utils/utils.dart';
// import '../../widgets/custom_loader.dart';
// import '../../widgets/widgets.dart';
//
// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});
//
//   final AllStickerController allStickerController = Get.put(AllStickerController());
//
//   final UserController userController = Get.put(UserController());
//
//   final LoadingWidget loadingWidget = Get.put(LoadingWidget());
//
//   final ProfileController profileController = Get.put(ProfileController());
//
//   final PromoCodeController promoCodeController = PromoCodeController();
//
//   @override
//   Widget build(BuildContext context) {
//     profileController.getUserData();
//     userController.getUserData();
//     allStickerController.getAllSticker();
//     // StickerGrid();
//     final TextEditingController _searchController = TextEditingController();
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: false,
//           leading: Obx(
//             () => Padding(
//                 padding: EdgeInsets.only(left: 24.w),
//                 child: InkWell(
//                     onTap: () {
//                       Get.toNamed(AppRoutes.myProfileScreen);
//                     },
//                     child:
//                         userController.userModel.value.image?.publicFileUrl !=
//                                     null &&
//                                 userController
//                                         .userModel.value.image?.publicFileUrl !=
//                                     ""
//                             ? CustomImageContainer(
//                                 height: 44.h,
//                                 imageBoxFit: BoxFit.cover,
//                                 imagePath: userController
//                                     .userModel.value.image?.publicFileUrl,
//                                 imageWidth: 44.w,
//                                 isNetworkImage: true,
//                                 boxShape: BoxShape.circle,
//                               )
//                             : CustomImageContainer(
//                                 height: 44.h,
//                                 imageBoxFit: BoxFit.cover,
//                                 imagePath: AppImages.profileImage,
//                                 imageWidth: 44.w,
//                                 isNetworkImage: false,
//                                 boxShape: BoxShape.circle,
//                               ))),
//           ),
//           title: Obx(() => CustomText(
//                 text: userController.userModel.value.name ?? "N/A",
//                 fontsize: 20.sp,
//                 textAlign: TextAlign.start,
//               )),
//           actions: [
//             InkWell(
//               onTap: () {
//                 Get.toNamed(AppRoutes.notification);
//               },
//               child: Padding(
//                 padding: EdgeInsets.only(right: 24.w),
//                 child: SvgPicture.asset(AppIcons.homeNoticeIcon,
//                     color: AppColors.primaryColor, height: 24.h, width: 24.w),
//               ),
//             ),
//           ],
//         ),
//         body: Container(
//           child:
//               // allStickerController.isStickerLoading.value == true ?Center(child: loadingWidget.loading(context: context, containerHeight: 25.h, containerWidth: 25.w, loadedColor: AppColors.primaryColor)):
//               SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: Dimensions.radiusExtraLarge.w),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//
//                   ///==============promo code =================
//                   Obx(() {
//                     return profileController.isProfile.value == true
//                         ? Center(
//                             child: loadingWidget.loading(
//                                 context: context,
//                                 containerHeight: 25.h,
//                                 containerWidth: 25.w,
//                                 loadedColor: AppColors.primaryColor))
//                         : profileController.promoCode.value == ""
//                             ? CustomButtonCommon(
//                                 title: "Add Promo Code",
//                                 onpress: () {
//                                   Get.toNamed(AppRoutes.promoCodeScreen);
//                                 },
//                               )
//                             : profileController.isProfile.value == true
//                                 ? Center(
//                                     child: loadingWidget.loading(
//                                         context: context,
//                                         containerHeight: 25.h,
//                                         containerWidth: 25.w,
//                                         loadedColor: AppColors.primaryColor))
//                                 : Container(
//                                     width: 355.w,
//                                     height: 48.h,
//                                     padding: EdgeInsets.all(10.r),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8.r),
//                                       color: AppColors.primaryColor,
//                                     ),
//                                     child: CustomText(
//                                       text: "Download Free Pmoji",
//                                       fontsize: 20.sp,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   );
//                   }),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//
//                   ///------------------------Search Field----------------------------?>
//                   TextField(
//                     controller: _searchController,
//                     onChanged: (value) async {
//                       await allStickerController.searchStickerData(value);
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           horizontal: 20.w, vertical: 10.h),
//                       fillColor: const Color(0xffE8F1EE),
//                       filled: true,
//                       errorStyle: TextStyle(
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.red,
//                           fontFamily: "ComicNeue-Light"),
//                       hintText: AppString.homeSearch,
//                       suffixIcon: Padding(
//                         padding: EdgeInsets.only(left: 16.w, right: 12.w),
//                         child: SvgPicture.asset(AppIcons.homeSearch,
//                             color: AppColors.primaryColor,
//                             height: 24.h,
//                             width: 24.w),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16.r),
//                         borderSide: BorderSide(color: AppColors.primaryColor),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16.r),
//                         borderSide: BorderSide(color: AppColors.primaryColor),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//
//                   ///------------------------Pmoji Gridview----------------------------?>
//                   Obx(
//                     () => allStickerController.isStickerLoading.value == true
//                         ? Center(
//                             child: loadingWidget.loading(
//                                 context: context,
//                                 containerHeight: 25.h,
//                                 containerWidth: 25.w,
//                                 loadedColor: AppColors.primaryColor))
//                         : GridView.builder(
//                             controller: allStickerController.scrollController,
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2, // 2 columns
//                               crossAxisSpacing: 10.0, // Space between columns
//                               mainAxisSpacing: 20.0, // Space between rows
//                             ),
//                             itemCount:
//                                 allStickerController.stickerList.length + 1,
//                             // (allStickerController.isStickerLoading.value && allStickerController.hasMoreData ? 1 : 0),
//                             // itemBuilder: (context, index) {
//                             //   var sticker = allStickerController
//                             //       .stickerList[index];
//                             //   print("length :===========${allStickerController
//                             //       .filteredList.length}");
//                             //   if(index == allStickerController.filteredList.length){
//                             //     return CircularProgressIndicator();
//                             //   }
//                             //   return InkWell(
//                             //     onTap: () {
//                             //       Get.toNamed(AppRoutes.homeDetailsScreen,
//                             //           arguments: profileController.promoCode.value,
//                             //           parameters: {"id": sticker.id.toString()});
//                             //       print("StickerId=====>> ${sticker.id}");
//                             //     },
//                             //     child: SizedBox(
//                             //       height: 194.h,
//                             //       width: double.infinity,
//                             //       child: Column(
//                             //         children: [
//                             //           CustomImageContainer(
//                             //             imagePath: "${sticker.image?.publicFileUrl}",
//                             //             isNetworkImage: true,
//                             //             imageBoxFit: BoxFit.cover,
//                             //             imageWidth: 134.w,
//                             //             height: 134.h,
//                             //             boxShape: BoxShape.rectangle,),
//                             //           SizedBox(height: 12.h),
//                             //           CustomText(text: sticker.name ?? "N/A", fontsize: 16.sp,textAlign: TextAlign.center,),
//                             //         ],
//                             //       ),
//                             //     ),
//                             //   );
//                             // },
//
//                             itemBuilder: (context, index) {
//                               if (index <
//                                   allStickerController.stickerList.length) {
//                                 var sticker =
//                                     allStickerController.stickerList[index];
//                                 print(" :::: ${sticker.id}");
//                                 print(
//                                     "length -------====>${allStickerController.stickerList.length}");
//                                 return InkWell(
//                                   onTap: () {
//                                     Get.toNamed(AppRoutes.homeDetailsScreen,
//                                         arguments:
//                                             profileController.promoCode.value,
//                                         parameters: {
//                                           "id": sticker.id.toString()
//                                         });
//                                     print("StickerId=====>> ${sticker.id}");
//                                   },
//                                   child: SizedBox(
//                                     height: 194.h,
//                                     width: double.infinity,
//                                     child: Column(
//                                       children: [
//                                         CustomImageContainer(
//                                           imagePath:
//                                               "${sticker.image?.publicFileUrl}",
//                                           isNetworkImage: true,
//                                           imageBoxFit: BoxFit.cover,
//                                           imageWidth: 134.w,
//                                           height: 134.h,
//                                           boxShape: BoxShape.rectangle,
//                                         ),
//                                         SizedBox(height: 12.h),
//                                         CustomText(
//                                           text: sticker.name ?? "N/A",
//                                           fontsize: 16.sp,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               } else if (index >=
//                                   allStickerController.totalResult) {
//                                 return null;
//                               } else {
//                                 return const CustomLoader();
//                               }
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AllStickerController allStickerController = Get.put(AllStickerController());
  final UserController userController =Get.put(UserController());
  final LoadingWidget loadingWidget = Get.put(LoadingWidget());
  final ProfileController profileController = Get.put(ProfileController());
  final ScrollController scrollController = ScrollController();
  final PromoCodeController promoCodeController = PromoCodeController();
  StickerGrid() {
    // Add a listener to the ScrollController to trigger data fetching
    scrollController.addListener(() {
      // Check if the user has scrolled to the bottom and there's more data to load
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
          !allStickerController.isStickerLoading.value &&
          allStickerController.hasMoreData) {
        allStickerController.getAllStickers(); // Fetch more data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    profileController.getUserData();
    allStickerController.getAllSticker();
    userController.getUserData();
    StickerGrid();



    final TextEditingController _searchController = TextEditingController();
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: Obx(()=>
              Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.myProfileScreen);
                      },
                      child: userController.userModel.value.image?.publicFileUrl != null && userController.userModel.value.image?.publicFileUrl != ""
                          ? CustomImageContainer(height: 44.h,imageBoxFit: BoxFit.cover,imagePath: userController.userModel.value.image?.publicFileUrl,imageWidth: 44.w,isNetworkImage: true, boxShape: BoxShape.circle,)
                          :CustomImageContainer(height: 44.h,imageBoxFit: BoxFit.cover,imagePath: AppImages.profileImage,imageWidth: 44.w,isNetworkImage: false, boxShape: BoxShape.circle,))),
          ),
          title:  Obx(()=> CustomText(text: userController.userModel.value.name ?? "N/A",fontsize: 20.sp,textAlign:TextAlign.start,)),
          actions: [

            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.notificationScreen);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 24.w),
                child: SvgPicture.asset(AppIcons.homeNoticeIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
              ),
            ),
          ],
        ),
        body: Container(
          child:
          // allStickerController.isStickerLoading.value == true ?Center(child: loadingWidget.loading(context: context, containerHeight: 25.h, containerWidth: 25.w, loadedColor: AppColors.primaryColor)):
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.radiusExtraLarge.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h,),
                  ///==============promo code =================
                  Obx((){
                    return    profileController.isProfile.value == true ? Center(
                        child: loadingWidget.loading(context: context,
                            containerHeight: 25.h,
                            containerWidth: 25.w,
                            loadedColor: AppColors.primaryColor)) : profileController.promoCode.value == "" ? CustomButtonCommon(
                      title: "Add Promo Code",
                      onpress: () {
                        Get.toNamed(AppRoutes.promoCodeScreen);
                      },
                    ):profileController.isProfile.value == true ? Center(
                        child: loadingWidget.loading(context: context,
                            containerHeight: 25.h,
                            containerWidth: 25.w,
                            loadedColor: AppColors.primaryColor)): Container(
                      width: 355.w,
                      height: 48.h,
                      padding:  EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color:AppColors.primaryColor,
                      ),
                      child: CustomText(
                        text: "Download Free Pmoji",
                        fontsize:  20.sp,
                        color:  Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                  SizedBox(height: 20.h,),
                  ///------------------------Search Field----------------------------?>
                  TextField(
                    controller: _searchController,
                    onChanged: (value) async {
                      await allStickerController.searchStickerData(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h),
                      fillColor: const Color(0xffE8F1EE),
                      filled: true,
                      errorStyle: TextStyle(fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                          fontFamily: "ComicNeue-Light"),
                      hintText: AppString.homeSearch,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 12.w),
                        child: SvgPicture.asset(AppIcons.homeSearch,
                            color: AppColors.primaryColor,
                            height: 24.h,
                            width: 24.w),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),

                  ///------------------------Pmoji Gridview----------------------------?>
                  Obx(() =>
                  allStickerController.isStickerLoading.value == true
                      ? Center(
                      child: loadingWidget.loading(context: context,
                          containerHeight: 25.h,
                          containerWidth: 25.w,
                          loadedColor: AppColors.primaryColor))
                      : allStickerController.stickerList.isEmpty ? Center(child: CustomText(text: "No Data Available",),):
                  GridView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 10.0, // Space between columns
                      mainAxisSpacing: 20.0, // Space between rows
                    ),
                    itemCount: allStickerController.stickerList.length ,
                    itemBuilder: (context, index) {
                      var sticker = allStickerController
                          .stickerList[index];
                      print("length :===========${allStickerController
                          .stickerList.length}");
                      if(index == allStickerController.stickerList.length){
                        return CircularProgressIndicator();
                      }
                      return InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.homeDetailsScreen,
                              arguments: profileController.promoCode.value,
                              parameters: {"id": sticker.id.toString()});
                          print("StickerId=====>> ${sticker.id}");
                        },
                        child: SizedBox(
                          height: 194.h,
                          width: double.infinity,
                          child: Column(
                            children: [
                              CustomImageContainer(
                                imagePath: "${sticker.image?.publicFileUrl}",
                                isNetworkImage: true,
                                imageBoxFit: BoxFit.cover,
                                imageWidth: 134.w,
                                height: 134.h,
                                boxShape: BoxShape.rectangle,),
                              SizedBox(height: 12.h),
                              CustomText(text: sticker.name ?? "N/A", fontsize: 16.sp,textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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