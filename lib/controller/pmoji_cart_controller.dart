

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../helpers/helpers.dart';
import '../models/models.dart';
import '../models/single_sticker_model.dart';
import '../service/service.dart';
import '../utils/utils.dart';

class PmojiCartController extends GetxController {

@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
@override
  void onInit() {
    // TODO: implement onInit
  getAllMyPmoji();
  downloadGallery();

    super.onInit();
  }


  var wishlist = <SingleStickerModel>[].obs; // Reactive model
RxBool isCart = false.obs;
RxBool isCartBool = false.obs;
  // Method to save sticker with ID in a POST request
  Future<void> saveStickerWithId(String id) async {
    try {
      isCart(true);
      String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken'
      };
      var body = {
        "stickerId": id
      };
      var response = await ApiClient.postData(
          ApiConstants.passCartIdiEndPoint,
          jsonEncode(body),
        headers: headers
      );// Passing the ID as an array
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastMessageHelper.successMessageShowToster(response.body['message']);
        isCart(false);
      } else {
        ToastMessageHelper.errorMessageShowToster(response.body['message']);
        isCart(false);
      }
    } catch (e) {
      ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
      isCart(false);
    }
  }




RxList<PmojicartResponseModel> myCartList = <PmojicartResponseModel>[].obs;
RxBool isMyCartLoading = false.obs;


  Future<void> getAllMyPmoji() async {
      try{
        isMyCartLoading(true);
      var response = await ApiClient.getData(ApiConstants.getCartEndPoint);
      print("===========myPmoji${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.body;
        myCartList.value = List<PmojicartResponseModel>.from(
          responseData['data'].map(
                (element) => PmojicartResponseModel.fromJson(element),
          ),
        );
        isMyCartLoading(false);
      }else{
        ToastMessageHelper.errorMessageShowToster(response.body['message']);
        isMyCartLoading(false);
      }
      }
      catch(e){
      //  ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
        isMyCartLoading(false);
      }
    }



bool isInWishlist(SingleStickerModel item) {
  return wishlist.any((element) =>
  element.id == item.id);
}



RxList<PmojicartResponseModel> myCartTotalList = <PmojicartResponseModel>[].obs; // Your cart list

/// Method to calculate total quantity
int getTotalQuantity() {
  return myCartList.length; // Assuming each item is counted once
}

/// Method to calculate total price
int getTotalPrice() {
  double totalPrice = 0.0;
  for (var sticker in myCartList) {
    totalPrice += sticker.price ?? 0.0; // Summing up the prices, handling null price
  }
  return totalPrice.toInt();
}


int getTotalPriceInt() {
  double totalPrice = 0.0;
  for (var sticker in myCartList) {
    totalPrice += sticker.price ?? 0.0; // Summing up the prices, handling null price
  }
  return totalPrice.toInt();
}


  ///===================== Single Sticker delete ================<>
  RxList<PmojicartResponseModel> myCartDeleteList = <PmojicartResponseModel>[].obs;
  RxBool isSingleStickerDelLoading = false.obs;
 Future<void> deleteStickerWithId({String stickerId=''}) async{
    isSingleStickerDelLoading(true);
    var response = await ApiClient.deleteData(ApiConstants.singleStickerDeleteEndPoint(stickerId));
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      var responseData = response.body;
      isSingleStickerDelLoading(false);
      ToastMessageHelper.errorMessageShowToster(responseData['message']);

    }else{
      isSingleStickerDelLoading(false);
    }
  }




RxBool isDownLoading = false.obs;
// Method to save sticker with ID in a POST request
Future<void> downloadStickerWithId(String id) async {
  try {
    isDownLoading(true);
    String bearerToken = await  PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "stickerId": id
    };
    var response = await ApiClient.postData(
        "/download",
        jsonEncode(body),
        headers: headers
    );// Passing the ID as an array
    if (response.statusCode == 200 || response.statusCode == 201) {
      isDownLoading(false);
    } else {
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      isDownLoading(false);
    }
  } catch (e) {
    ToastMessageHelper.errorMessageShowToster('An error occurred: $e');
    isDownLoading(false);
  }
}

  ///============download galary=================
  Future<void> downloadImage({required String imageUrl}) async {
   try{
     String  devicePathToSaveImage= "";
     var time = DateTime.now().microsecondsSinceEpoch;
     if(Platform.isAndroid){
       devicePathToSaveImage = "/storage/emulated/0/Pictures/PmojiGallery$time.svg";
     }else{
       var downloadDirectoryPath = await getApplicationCacheDirectory();
       devicePathToSaveImage = "${downloadDirectoryPath}/PmojiGallery$time.svg";
     }

     File file  = File(devicePathToSaveImage);
     print(file);
     print("***************${imageUrl}");

     var res = await http.get(Uri.parse("$imageUrl"));
     print(res.body);
     if(res.statusCode == 200){
       await file.writeAsBytes(res.bodyBytes);
       await ImageGallerySaverPlus.saveFile(devicePathToSaveImage);
       ToastMessageHelper.successMessageShowToster("Download Done");
     }
   }catch(e, s){
     print("${e}");
     print("${s}");
   }
  }


///=================image list download===============
  Future<void> downloadImages(List<String> imageList) async {

    List<String> imageList =  myCartList.map((sticker) => "${ApiConstants.imageBaseUrl}${sticker.image?.publicFileUrl}")
        .where((url) => url != null)
        .cast<String>()
        .toList();

    for (var imageUrl in imageList) {
      await downloadImage(imageUrl: imageUrl); // Use imageUrl in the downloadImage function
    }
    for (var sticker in myCartList) {
      try {
        await downloadStickerWithId(sticker.id.toString());
      } catch (e) {
        print("Error downloading sticker with ID: ${sticker.id}, Error: $e");
      }
    }


    ToastMessageHelper.successMessageShowToster("All Downloads Completed");
  }



Future<void> downloadGallery() async {
  // Iterate over the list of stickers to download each
  for (var sticker in myCartList) {
    final id = sticker.id;
    final filename = sticker.name;

    if (id != null && filename != null) {
      final uri = Uri.parse(
          "${ApiConstants.baseUrl}/sticker/sticker-detail?id=$id");
      final http.Response response = await http.get(uri);

      // Check if the request was successful
      if (response.statusCode == 200) {
        try {
          // Get the external storage directory
          final directory = await getExternalStorageDirectory();
          if (directory == null) {
            throw Exception('Downloads directory not found');
          }

          // Define the gallery folder inside the external storage directory
          final galleryDir = Directory('${directory.path}/PmojiGallery');
          if (!await galleryDir.exists()) {
            await galleryDir.create(
                recursive: true); // Create directory if not exists
          }

          // Define the path where each file will be saved
          final filePath = '${galleryDir.path}/$filename.svg';
          final file = File(filePath);

          // Write the response bytes to the file
          await file.writeAsBytes(response.bodyBytes);

          // Optionally, open each file after downloading
          print('Downloaded $filename');
        } catch (e) {
          print('Failed to save file $filename: $e');
        }
      } else {
        print('Failed to download file $filename: ${response.statusCode}');
      }
    } else {
      print('Invalid sticker data: $sticker');
    }
  }
}
}




