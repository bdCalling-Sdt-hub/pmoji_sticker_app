import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import 'custom_text.dart';

class CustomContainerText extends StatelessWidget {
  CustomContainerText({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.borderColor,
    this.textAlign = TextAlign.center,
    this.left = 0,
  });
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? borderColor;
  final TextAlign textAlign;
  final double left;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        width: width ?? 355.w,
        height: height ?? 48.h,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color ?? AppColors.cardColorE8F1EE,
            border: Border.all(color: borderColor ?? AppColors.primaryColor)
        ),
        child: CustomText(
          textAlign: textAlign,
          text: title,
          fontsize: fontSize ?? 20.sp,
          color: titlecolor ?? AppColors.textColor4E4E4E,
          fontWeight: FontWeight.w400,
          left: left,
        ),
      ),
    );
  }
}
