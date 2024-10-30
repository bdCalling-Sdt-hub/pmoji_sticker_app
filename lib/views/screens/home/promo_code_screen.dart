
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/controller.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/utils.dart';

import '../../widgets/widgets.dart';

class PromoCodeScreen extends StatelessWidget {
   PromoCodeScreen({super.key});
 final TextEditingController promoCodeText = TextEditingController();
 final GlobalKey<FormState> promoKey = GlobalKey<FormState>();
 final PromoCodeController promoCodeController = PromoCodeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: CustomText(text: AppString.promoCode,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Form(
              key: promoKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h,),
                  CustomText(text: AppString.enterCode,fontsize: 18.sp,),
                  SizedBox(height: 18.h,),
                  ///----------------------- code Text field----------------------------?>
                  CustomTextField(
                    controller: promoCodeText,
                    hintText: "code",
                    hintextColor: AppColors.textColor4E4E4E,
                    hintextSize: 16.sp,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Please enter your Promo Code';

                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 500.h,),
                  ///----------------------- Payment Purchase Button----------------------------?>
                  Obx(()=>
                   CustomButtonCommon(
                      loading: promoCodeController.isPromoCodeLoading.value == true,
                      title: AppString.confirmPurchase,onpress: (){
                      if(promoKey.currentState!.validate()){
                        promoCodeController.sendPromoCode(proCode: promoCodeText.text);

                      }
                     // Get.toNamed(AppRoutes.congratulationsScreen, arguments: false,preventDuplicates: false);
                      //Get.off(()=>CongratulationsScreen(isPassChange: false,),preventDuplicates: false);
                    },),
                  ),
                  SizedBox(height: 5.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
