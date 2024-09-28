
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../controller/controller.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
   AboutScreen({super.key});
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    profileController.getAboutData();
    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.aboutUs,fontsize: 18.sp,),),
      body: Obx((){
        var privacyList = profileController.getAboutModelList.value;
        return Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 14.h,),
                  ListView.builder(
                    padding: EdgeInsets.only( bottom: 8.h),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: privacyList.length,
                    itemBuilder: (context, index) {
                      var privacyList = profileController.getAboutModelList[index];
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