
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/controller.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class MyPmojisScreen extends StatelessWidget {
   MyPmojisScreen({super.key});
   AllStickerController myPmojiController = Get.put(AllStickerController());
  @override
  Widget build(BuildContext context) {
    myPmojiController.getAllMyPmoji();

    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomText(text: AppString.myPmojis,fontsize: 18.sp,),),
        body: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),

    StreamBuilder<List<MyPmojiResponseModel>>(
    stream: myPmojiController.myPmojiList.stream, // Provide the stream here
    builder: (context, snapshot) {
    if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting ) {
    return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,)); // Show a loader while waiting for data
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}')); // Handle error state
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return Center(child: Text('No stickers in the cart',style: TextStyle(fontSize: 20,fontFamily: "ComicNeue-Light",fontWeight: FontWeight.w400),)); // Show message if no data is present
    } else{
      return   GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 10.0, // Space between columns
          mainAxisSpacing: 20.0, // Space between rows
        ),
        itemCount: myPmojiController.myPmojiList.length,
        itemBuilder: (context, index) {
          var myPmoji = myPmojiController.myPmojiList[index];
          print(myPmoji.name);
          return Column(
            children: [
              CustomImageContainer(imagePath: "${myPmoji.image?.publicFileURL}", isNetworkImage: true,imageBoxFit: BoxFit.cover,imageWidth: 134.w,height: 134.h,boxShape: BoxShape.rectangle,),
              SizedBox(height: 12.h),
              CustomText(text: myPmoji.name ?? "N/A", fontsize: 16.sp,textAlign: TextAlign.center,),

            ],
          );
        },
      );
    }
    }
    )


                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}
