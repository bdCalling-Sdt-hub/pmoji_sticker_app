import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../service/service.dart';

class CustomImageContainer extends StatelessWidget {
  final double? height;
  final double? imageWidth;
  final bool? isNetworkImage;
  final String? imagePath;
  final BoxFit? imageBoxFit;
  final BoxShape? boxShape;
  final bool isLoading;
  const CustomImageContainer({
    super.key,
     this.height =0,
     this.imageWidth=0,
     this.isNetworkImage,
     this.imagePath,
     this.imageBoxFit,
    this.boxShape,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return
      isLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: imageWidth,
          decoration: BoxDecoration(
            color: Colors.grey[300],  // Placeholder shimmer color
            shape: boxShape!,
          ),
        ),
      )
          :
      Container(
      height: height,
      width: imageWidth,
      decoration: isNetworkImage == false
          ? BoxDecoration(
              shape: boxShape!,
              image: DecorationImage(
                image: AssetImage(imagePath!),
                fit: imageBoxFit,
              ),
            )
          : BoxDecoration(
              shape: boxShape!,
              image: DecorationImage(
                image: NetworkImage('${ApiConstants.imageBaseUrl}$imagePath',),
                fit: imageBoxFit,
              )),
    );
  }
}
