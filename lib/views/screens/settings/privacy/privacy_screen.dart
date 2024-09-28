
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';


import '../../../../controller/controller.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class PrivacyScreen extends StatelessWidget {
   PrivacyScreen({super.key});
   ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    profileController.getPrivacyData();
    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.privacyPolicy,fontsize: 18.sp,),),
      body: Obx((){
        var privacyList = profileController.getPrivacyModel.value;
        return Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h,),
                  ListView.builder(
                    padding: EdgeInsets.only( bottom: 8.h),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: privacyList.length,
                    itemBuilder: (context, index) {
                        var privacyList = profileController.getPrivacyModel[index];
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: HtmlWidget(
                                  "${privacyList.description}",
                                    textStyle: TextStyle(
                                      fontFamily: "ComicNeue-Light",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 18.sp,

                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
