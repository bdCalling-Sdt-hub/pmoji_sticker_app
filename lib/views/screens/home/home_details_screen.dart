
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../controller/payment_controller.dart';
import '../../../payment_controller.dart';
import '../../../service/service.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class HomeDetailsScreen extends StatelessWidget {
   HomeDetailsScreen({super.key});
   final AllStickerController allStickerController = Get.put(AllStickerController());
   final LoadingWidget loadingWidget = Get.put(LoadingWidget());
  final PmojiCartController wishlistController = Get.put(PmojiCartController());

   PaymentController paymentController = PaymentController() ;
  @override
  Widget build(BuildContext context) {

  allStickerController.getSingleSticker(id: Get.parameters['id']!);
    return Scaffold(
      appBar: AppBar(title: Obx(()=> CustomText(text: allStickerController.singleSticker.value.name ?? "N/A",fontsize: 18.sp,)),),
      body: Container(
        width: double.infinity,
        child: Obx(()=>
        allStickerController.isSingleStickerLoading.value == true? Center(child: loadingWidget.loading(context: context, containerHeight: 25.h, containerWidth: 25.w, loadedColor: AppColors.primaryColor)):  Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  allStickerController.isSingleStickerLoading.value == true ? loadingWidget.loading(context: context, containerHeight: 25.h, containerWidth: 25.w, loadedColor: AppColors.primaryColor):
                  CustomImageContainer(height: 353.h,imageBoxFit: BoxFit.contain,imagePath: allStickerController.singleSticker.value.image!.publicFileUrl?? "N/A", imageWidth: 453.w,isNetworkImage: true, boxShape: BoxShape.rectangle,),
                  SizedBox(height: 20.h,),
                  Center(child: CustomText(text: allStickerController.singleSticker.value.name ?? "N/A",fontsize: 20.sp,color: AppColors.primaryColor,)),
                  SizedBox(height: 20.h,),
                  CustomText(text: AppString.descriptionTitle,fontsize: 16.sp,),
                  SizedBox(height: 20.h,),
                  CustomText(text: allStickerController.singleSticker.value.description ?? "N/A",fontsize: 14.sp, textAlign: TextAlign.start,color: AppColors.textColor4E4E4E,),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      CustomText(text: "Price: ",fontsize: 20.sp,),
                     Get.arguments == ""? CustomText(text: ' \$${allStickerController.singleSticker.value.price ?? "N/A"}',fontsize: 20.sp,color: AppColors.primaryColor,):CustomText(text: 'Free',fontsize: 20.sp,color: AppColors.primaryColor,),
                    ],
                  ),
                  SizedBox(height: 50.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx((){
                        var sticker = allStickerController.singleSticker.value;
                        bool isCart = wishlistController.isInWishlist(sticker);
                        return InkWell(
                            onTap: (){
                              wishlistController.saveStickerWithId(sticker.id.toString());

                            },
                            child: SvgPicture.asset(isCart == true ? AppIcons.soppingCart1: AppIcons.soppingCart, height: 48.h, width: 48.w,));

                      }),
                     Get.arguments == "" ?
                     ///payment
                          CustomButtonCommon(
                           loading: allStickerController.isSingleStickerLoading.value,
                           title: AppString.purchaseButton, width: 270.w, onpress: (){
                             List<String> stickersList = ["${allStickerController.singleSticker.value.id}"];
                             paymentController.makePayment(totalAmount: allStickerController.singleSticker.value.price.toString(), stickers: stickersList);
                             //wishlistController.downloadStickerWithId(allStickerController.singleSticker.value.id.toString());
                            //  StripeService.instance.makePayment();
                            // Get.toNamed(AppRoutes.paymentMethod);
                          },

                        ):Obx(()=>
                        CustomButtonCommon(
                          loading: allStickerController.isSingleStickerLoading.value,
                          title: "Free Download", width: 270.w, onpress: (){
                         wishlistController.downloadImage(imageUrl: "${ApiConstants.imageBaseUrl}${allStickerController.singleSticker.value.image?.publicFileUrl}");
                         wishlistController.downloadStickerWithId(allStickerController.singleSticker.value.id.toString());
                                             // allStickerController.downloadGallery()
                                             },),
                      ),
                    ],
                  ),
                  ],
              ),

          ),
        ),
      ),
    );
  }
}
