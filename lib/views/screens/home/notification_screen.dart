
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/controller.dart';
import '../../../helpers/helpers.dart';
import '../../../utils/utils.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/widgets.dart';
import 'package:timeago/timeago.dart' as TimeAgo;
class NotificationScreen extends StatefulWidget {
   NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
   NotificationController notificationController = Get.put(NotificationController());
   ScrollController scrollController = ScrollController();
   void initState() {
     super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) async {
       await notificationController.getNotificationData();
       scrollController.addListener(() {
         if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
           notificationController.loadMore();
           print("load more true");
         }
       });
     });
   }

   @override
   void dispose() {
     super.dispose();
    scrollController.dispose();
     notificationController.page.value = 1;
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: CustomText(text: AppString.notification,fontsize: 18.sp,),),
      body: Obx(()=>
      notificationController.isNotiLoading.value? CustomLoader(): notificationController.notificationList.isEmpty? Center(child: Text("No Data Available")) : Container(
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: notificationController.notificationList.length +1,
            itemBuilder: (context, index) {
              if(index < notificationController.notificationList.length){
                var notificationList =
                notificationController.notificationList[index];
                return Padding(
                  padding:  EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: Container(
                    height: 124.h,
                    color: Color(0xffd6f1e7),
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppIcons.noticeIcon, height: 32.h, width: 32.w),
                          SizedBox(width: 16.w,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: notificationList.msg.toString().substring(0,15),fontsize: 18.sp,color: AppColors.hitTextColor000000, maxline: 3,),
                              CustomText(text:TimeAgo.format(notificationList.createdAt ?? DateTime.now()),fontsize: 18.sp,color: Color(0xff8C8C8C)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              }else if (index >=
                  notificationController.totalResult) {
                return null;
              } else {
                return const CustomLoader();
              }

            },
          ),
        ),
      ),
    );
  }

   String formatTime(String? dateTimeString) {
     DateTime dateTime = DateTime.parse(dateTimeString!);
     // Format the time as desired
     String formattedTime = DateFormat('hh:mm a').format(dateTime); // e.g., "10:01 AM"
     return formattedTime;
   }
}
