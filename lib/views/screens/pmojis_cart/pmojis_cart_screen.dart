

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/cart_response_model.dart';
import '../../../models/single_sticker_model.dart';
import '../../../payment_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../service/service.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../bottom_bar.dart';

class PmojisCartScreen extends StatelessWidget {
   PmojisCartScreen({super.key});
 final  PmojiCartController pmojiCartController = Get.find<PmojiCartController>();
 final  ProfileController profileController = Get.find<ProfileController>();
   PaymentController paymentController = PaymentController() ;

  @override
  Widget build(BuildContext context) {
    profileController.getUserData();
    pmojiCartController.getAllMyPmoji();
    List <String> stickersList = [];
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomText(text: AppString.pmojisCart,fontsize: 18.sp,),),
        body: Obx(
          (){

            return
              Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        ///------------------------Pmoji Gridview----------------------------?>

                        StreamBuilder<List<PmojicartResponseModel>>(
                          stream: pmojiCartController.myCartList.stream, // Provide the stream here
                          builder: (context, snapshot) {
                            if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting ) {
                              return SizedBox(
                                  height: 60.h,
                                  width: double.infinity,
                                  child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))); // Show a loader while waiting for data
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}')); // Handle error state
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No stickers in the cart',style: TextStyle(fontSize: 20,fontFamily: "ComicNeue-Light",fontWeight: FontWeight.w400),)); // Show message if no data is present
                            } else{
                              var stickers = snapshot.data!;

                              for(var x in stickers){
                                stickersList.add(x.id.toString());
                              }
                              return  GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // 2 columns
                                  crossAxisSpacing: 14.0, // Space between columns
                                  mainAxisSpacing: 24, // Space between rows
                                ),
                                itemCount: stickers.length,
                                itemBuilder: (context, index) {
                                  var sticker = stickers[index];
                                  print("===============================stickers list ${stickersList}");

                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                                              spreadRadius: 3, // How much the shadow spreads
                                              blurRadius: 9, // How soft the shadow looks
                                              offset: Offset(0, 3), // Position of the shadow (x, y)
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(10), // Optional: to give the container rounded corners
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10.h),
                                            CustomImageContainer(
                                              imagePath: "${sticker.image?.publicFileUrl}",
                                              isNetworkImage: true,
                                              imageBoxFit: BoxFit.cover,
                                              imageWidth: 112.w,
                                              height: 110.h,
                                              boxShape: BoxShape.rectangle,
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 9,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child:
                                                  CustomText(text:  sticker.name ?? "N/A",fontsize: 14.sp,textAlign:TextAlign.center,),
                                                ),
                                                Container(
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 9,
                                                        offset: Offset(0, 3),
                                                      ),
                                                    ],
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child:  CustomText(text: profileController.promoCode.value != "" ? "Free":"\$ ${sticker.price.toString()}",fontsize: 14.sp,textAlign:TextAlign.center,color: AppColors.whiteColor,),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 8.w,
                                        top: 8.h,
                                        child: InkWell(
                                          onTap: ()  {
                                            pmojiCartController.myCartList.removeWhere((item) => item.id == sticker.id);
                                            pmojiCartController.myCartList.refresh();
                                            pmojiCartController.deleteStickerWithId(stickerId: sticker.id.toString());

                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 3,
                                                  blurRadius: 9,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Icon(Icons.close, color: Colors.red, size: 30.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                          },
                        ),
                        pmojiCartController.myCartList.length <= 4   ?
                        SizedBox(height: pmojiCartController.myCartList.isEmpty || pmojiCartController.myCartList.length <= 2 ? 280.h: 30.h,):
                        SizedBox(height: 16.h,),
                        Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r)
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  CustomText(text: "Total Pmoji:",color: Colors.white,fontWeight: FontWeight.w500,),
                                  CustomText(text: " ${pmojiCartController.getTotalQuantity().toString()}",color: Colors.white,),
                                ],
                              ),
                              Row(
                                children: [
                                  CustomText(text: "Total Price:",color: Colors.white,fontWeight: FontWeight.w500,),
                                  CustomText(text: profileController.promoCode.value != "" ? " Free":" \$ ${pmojiCartController.getTotalPrice().toStringAsFixed(2)}",color: Colors.white,),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        profileController.promoCode.value != "" ? CustomButtonCommon(title: "Free Download", onpress: (){
                          List<String> stickersList = pmojiCartController.myCartList
                              .map((sticker) => "${ApiConstants.imageBaseUrl}${sticker.image?.publicFileUrl}")
                              .where((url) => url != null)
                              .cast<String>()
                              .toList();
                         pmojiCartController.downloadImages(stickersList);
                        },)
                            :CustomButtonCommon(title: AppString.purchaseButton, onpress: (){
                          paymentController.makePayment(
                                  totalAmount: pmojiCartController.getTotalPriceInt().toString(),
                                  stickers: stickersList);

                        //  Get.toNamed(AppRoutes.paymentMethod);
                        },),

                      ],
                    ),
                  ),
                ),
              );
          }

        ),
      ),
    );
  }
}
