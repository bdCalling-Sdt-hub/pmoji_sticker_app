
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/controller.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileEditScreen extends StatefulWidget {
   ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController nameCtrl = TextEditingController();

  TextEditingController emailCtrl = TextEditingController();

  TextEditingController phoneNumberCtrl = TextEditingController();

  TextEditingController locationCtrl = TextEditingController();

   final ProfileController profileController = Get.put(ProfileController());
  ProfileResponseModel userData = Get.arguments as ProfileResponseModel;
  Uint8List? _image;
  File? selectedIMage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nameCtrl.text = userData.information!.name ?? "";
      emailCtrl.text = userData.information!.email ?? "";
      phoneNumberCtrl.text = userData.information!.phone ?? "";
      locationCtrl.text = userData.information!.address ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: AppString.editProfile,fontsize: 18.sp,),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.radiusExtraLarge.w),
            child: Column(
              children: [
                ///----------Profile image upload-------------///
                SizedBox(
                  height: 105.h,
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                          radius: 60.r,
                          backgroundImage: MemoryImage(_image!))
                          : userData.information?.image?.publicFileUrl != null
                          ? CustomImageContainer(
                        height: 134.h,
                        imageWidth: 134.w,
                        isNetworkImage: true,
                        imagePath: userData.information?.image?.publicFileUrl,
                        boxShape: BoxShape.circle,
                        imageBoxFit: BoxFit.cover,
                      )
                          : Image.asset(
                        AppImages.profileImage,
                        height: 134.h,
                        width: 134.w,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 68.h,
                        right: 0,
                        left: 64.w,
                        child: GestureDetector(
                            onTap: (){
                              showImagePickerOption(context);
                            },
                            child: SvgPicture.asset(AppIcons.editIcons,width: 32.w, height:  32.h)),
                      )
                    ],
                ),),
                SizedBox(height: 30.h,),
                CustomTextField(
                    controller: nameCtrl,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: SvgPicture.asset(AppIcons.profile, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                  ),
                  hintText: "Jane Cooper",
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  controller: emailCtrl,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: SvgPicture.asset(AppIcons.email, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                  ),
                  hintText: "jane.07@gmail.com",
                  keyboardType: TextInputType.none,
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  controller: phoneNumberCtrl,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: SvgPicture.asset(AppIcons.callIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                  ),
                  hintText: "(406) 555-0120",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  controller: locationCtrl,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 12.w),
                    child: SvgPicture.asset(AppIcons.locationIcon, color: AppColors.primaryColor, height: 24.h, width: 24.w),
                  ),
                  hintText: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                ),
                SizedBox(height: 250.h,),
                CustomButtonCommon(title: AppString.updateProfile, onpress: (){
                  //Get.toNamed(AppRoutes.paymentMethod);
                  profileController.updateProfile(
                    image: selectedIMage,
                    name: nameCtrl.text,
                    phone: phoneNumberCtrl.text,
                    address: locationCtrl.text,
                  );
                },),

              ],
            ),
          ),
        ),
      ),
    );
  }

   //==================================> ShowImagePickerOption Function <===============================
   void showImagePickerOption(BuildContext context) {
     showModalBottomSheet(
         backgroundColor: Colors.white,
         context: context,
         builder: (builder) {
           return Padding(
             padding: const EdgeInsets.all(18.0),
             child: SizedBox(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height / 6.2,
               child: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Expanded(
                     child: InkWell(
                       onTap: () {
                         _pickImageFromGallery();

                         // _pickImageFromGallery();
                       },
                       child: SizedBox(
                         child: Column(
                           children: [
                             Icon(
                               Icons.image,
                               size: 50.w,
                             ),
                             CustomText(text: 'Gallery')
                           ],
                         ),
                       ),
                     ),
                   ),
                   Expanded(
                     child: InkWell(
                       onTap: () {
                         _pickImageFromCamera();

                        // _pickImageFromCamera();
                       },
                       child: SizedBox(
                         child: Column(
                           children: [
                             Icon(
                               Icons.camera_alt,
                               size: 50.w,
                             ),
                             CustomText(text: 'Camera')
                           ],
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
         });
   }

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
     Get.back();
  }


}
