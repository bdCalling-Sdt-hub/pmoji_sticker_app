//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../helpers/helpers.dart';
// import '../../models/models.dart';
// import '../../models/single_sticker_model.dart';
// import '../../service/service.dart';
//
// class AllStickerController extends GetxController {
//
//   //RxList<AllStickerResponseModel> filteredList = <AllStickerResponseModel>[].obs;
//   ScrollController scrollController = ScrollController();
//   // int currentPage = 1;
//   final int itemsPerPage = 10;
//   bool hasMoreData = true;
//
//
//
//
//   RxInt page = 1.obs;
//   var totalPage = (-1);
//   var currectPage = (-1);
//   var totalResult = (-1);
//
//   void loadMore() {
//     print("==========================================total page ${totalPage} and ${page.value}");
//     if (totalPage > page.value) {
//       page.value += 1;
//       getAllSticker();
//       print("**********************print here");
//     }
//     print("**********************print here**************");
//   }
//
//
//   @override
//   onInit() {
//     super.onInit();
//      // getAllSticker();
//     loadMore();
//      getAllMyPmoji();
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     myPmojiList.clear();
//   }
//
//   // ///============== Sticker List =================<>
//   // RxList<AllStickerResponseModel> stickerList = <AllStickerResponseModel>[].obs;
//   RxList<AllStickerResponseModel> stickerList = <AllStickerResponseModel>[].obs;
// //  RxBool isStickerLoading = false.obs;
//   RxBool isStickerLoading = false.obs;
//   var filteredList = <AllStickerResponseModel>[].obs;
//   getAllSticker() async {
//     if(page.value == 1){
//       stickerList.clear();
//       isStickerLoading(true);
//
//
//     }
//
//     var response = await ApiClient.getData(ApiConstants.allStickerEndPoint("${page.value}"));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       totalPage = jsonDecode(response.body['data']['totalPages'].toString()) ?? 0;
//       currectPage = jsonDecode(response.body['data']['currentPage'].toString()) ?? 0;
//       totalResult = jsonDecode(response.body['data']['totalStickers'].toString()) ?? 0;
//       var data  = List<AllStickerResponseModel>.from(response.body["data"]["stickers"].map((x)=> AllStickerResponseModel.fromJson(x)));
//       print("totalResult::::::${data.length}");
//       stickerList.addAll(data);
//       // var responseData = response.body;
//       // stickerList.value = List<AllStickerResponseModel>.from(
//       //   responseData['data']['stickers'].map(
//       //     (element) => AllStickerResponseModel.fromJson(element),
//       //   ),
//       // );
//       filteredList.value = stickerList;
//       isStickerLoading(false);
//     }else{
//       isStickerLoading(false);
//       ToastMessageHelper.errorMessageShowToster(response.body['message']);
//
//     }
//   }
//
//   // Future<void> getAllStickers() async {
//   //   if (isStickerLoading.value || !hasMoreData) return;
//   //
//   //   isStickerLoading(true);
//   //   var response = await ApiClient.getData(
//   //       "${ApiConstants.allStickerEndPoint}?page=$currentPage&limit=$itemsPerPage"
//   //   );
//   //
//   //   if (response.statusCode == 200 || response.statusCode == 201) {
//   //     var responseData = response.body;
//   //     List<AllStickerResponseModel> newData = List<AllStickerResponseModel>.from(
//   //       responseData['data']['stickers'].map(
//   //             (element) => AllStickerResponseModel.fromJson(element),
//   //       ),
//   //     );
//   //
//   //     // Add the new data to the list
//   //     if (newData.isNotEmpty) {
//   //       stickerList.addAll(newData);
//   //       filteredList.value = stickerList;
//   //       currentPage++;
//   //     } else {
//   //       hasMoreData = false; // No more data to load
//   //     }
//   //   } else {
//   //     ToastMessageHelper.errorMessageShowToster(response.body['message']);
//   //   }
//   //   isStickerLoading(false);
//   // }
//   //
//
//   /// Method to search/filter data
//   searchStickerData(String query) {
//     if (query.isEmpty) {
//       filteredList.value = stickerList;
//     } else {
//       filteredList.value = stickerList
//           .where((item) => item.name.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//   }
//
//
//
//   ///===================== Single Sticker ================<>
//
// RxBool isSingleStickerLoading = false.obs;
//   Rx<SingleStickerModel> singleSticker = SingleStickerModel().obs;
//    getSingleSticker({String id=''}) async{
//      isSingleStickerLoading(true);
//     var response = await ApiClient.getData(ApiConstants.singleStickerEndPoint(id));
//     print(response.body);
//     if(response.statusCode == 200 || response.statusCode == 201){
//       singleSticker.value = SingleStickerModel.fromJson(response.body['data']);
//       isSingleStickerLoading(false);
//     }else{
//       isSingleStickerLoading(false);
//     }
//    }
//
//
//    ///-------------my Pmoji -----------------
//
//   RxList<MyPmojiResponseModel> myPmojiList = <MyPmojiResponseModel>[].obs;
//   RxBool isMyPmojiLoading = false.obs;
//  Future<void> getAllMyPmoji() async {
//     isMyPmojiLoading(true);
//     var response = await ApiClient.getData(ApiConstants.allMyPmojiEndPoint);
//     print("===========myPmoji${response.body}");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var responseData = response.body;
//       myPmojiList.value = List<MyPmojiResponseModel>.from(
//         responseData['data'].map(
//               (element) => MyPmojiResponseModel.fromJson(element),
//         ),
//       );
//       isMyPmojiLoading(false);
//     }else{
//       isMyPmojiLoading(false);
//     }
//   }
//
//
//   ///============download galary=================
//   Future<void> downloadImage({required String imageUrl}) async {
//     try{
//       String  devicePathToSaveImage= "";
//       var time = DateTime.now().microsecondsSinceEpoch;
//       if(Platform.isAndroid){
//         devicePathToSaveImage = "/storage/emulated/0/Pictures/PmojiGallery$time.svg";
//       }else{
//         var downloadDirectoryPath = await getApplicationCacheDirectory();
//         devicePathToSaveImage = "${downloadDirectoryPath}/PmojiGallery$time.svg";
//       }
//
//       File file  = File(devicePathToSaveImage);
//       print(file);
//       print("***************${imageUrl}");
//
//       var res = await http.get(Uri.parse("$imageUrl"));
//       print(res.body);
//       if(res.statusCode == 200){
//         await file.writeAsBytes(res.bodyBytes);
//         await ImageGallerySaverPlus.saveFile(devicePathToSaveImage);
//         ToastMessageHelper.successMessageShowToster("Download Done");
//       }
//     }catch(e, s){
//       print("${e}");
//       print("${s}");
//     }
//   }
//
//
//
//
//
//
//
//
//   ///==================download=============
//   Future<void> viewFile({required String id, required String filename}) async {
//     final uri = Uri.parse("${ApiConstants.baseUrl}/sticker/sticker-detail?id=$id");
//     final http.Response response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       final directory = await getDownloadsDirectory();
//       final filePath = '${directory?.path}/${filename}.png';
//       final file = File(filePath);
//
//       await file.writeAsBytes(response.bodyBytes);
//       await OpenFile.open(filePath);
//     } else {
//       print('Failed to load file: ${response.statusCode}');
//     }
//   }
//
//
//   Future<void> downloadFile({required String id, required String filename}) async {
//     final uri = Uri.parse("${ApiConstants.baseUrl}/sticker/sticker-detail?id=$id");
//     final http.Response response = await http.get(uri);
//
//     if (response.statusCode == 200) {
//       try {
//         // Save the file to the Pictures directory for easy access in the gallery
//         final directory = Directory('/storage/emulated/0/Pictures/PmojiGallery');
//         if (!await directory.exists()) {
//           await directory.create(recursive: true); // Create the directory if it doesn't exist
//         }
//
//         // Define the file path in the gallery folder
//         final filePath = '${directory.path}/$filename.svg';
//         final file = File(filePath);
//
//         // Write the file to the device
//         await file.writeAsBytes(response.bodyBytes);
//         print('Downloaded $filename to $filePath');
//
//         // Optionally, open the file after downloading
//         await OpenFile.open(filePath);
//       } catch (e) {
//         print('Failed to save file: $e');
//       }
//     } else {
//       print('Failed to load file: ${response.statusCode}');
//     }
//   }
//
//
//
//
//
//   Future<void> downloadGallery(List<Map<String, String>> stickerList) async {
//     // Iterate over the list of stickers to download each
//     for (var sticker in stickerList) {
//       final id = sticker['id'];
//       final filename = sticker['filename'];
//
//       if (id != null && filename != null) {
//         final uri = Uri.parse("${ApiConstants.baseUrl}/cart/my-cart");
//         final http.Response response = await http.get(uri);
//
//         // Check if the request was successful
//         if (response.statusCode == 200) {
//             try {
//               // Get the Pictures directory to save the files
//               final directory = Directory('/storage/emulated/0/Pictures/PmojiGallery');
//               if (!await directory.exists()) {
//                 await directory.create(recursive: true); // Create directory if it doesn't exist
//               }
//
//               // Define the path where each file will be saved
//               final filePath = '${directory.path}/$filename.svg';
//               final file = File(filePath);
//
//               // Write the response bytes to the file
//               await file.writeAsBytes(response.bodyBytes);
//
//               // Print success message
//               print('Downloaded $filename');
//
//               // Auto-open the file after download
//               final result = await OpenFile.open(filePath);
//               if (result.type != ResultType.done) {
//                 print('Failed to open file: $result.message');
//               }
//           } catch (e) {
//             print('Failed to save file $filename: $e');
//           }
//         } else {
//           print('Failed to download file $filename: ${response.statusCode}');
//         }
//       } else {
//         print('Invalid sticker data: $sticker');
//       }
//     }
//
//     // Optionally open the gallery folder after downloads complete
//     await OpenFile.open((await getExternalStorageDirectory())?.path ?? '');
//   }
//
// }


import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../models/single_sticker_model.dart';
import '../../service/service.dart';

class AllStickerController extends GetxController {
  // RxList<AllStickerResponseModel> stickerList = <AllStickerResponseModel>[].obs;
  //RxList<AllStickerResponseModel> filteredList = <AllStickerResponseModel>[].obs;

  int currentPage = 1;
  final int itemsPerPage = 10;
  bool hasMoreData = true;





  @override
  onInit() {
    super.onInit();
    getAllSticker();
    getAllMyPmoji();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myPmojiList.clear();
  }
  //
  // ///============== Sticker List =================<>
  RxList<AllStickerResponseModel> stickerList = <AllStickerResponseModel>[].obs;
 RxBool isStickerLoading = false.obs;
  var filteredList = <AllStickerResponseModel>[].obs;
  getAllSticker() async {
    isStickerLoading(true);
    var response = await ApiClient.getData(ApiConstants.allStickerEndPoint());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.body;
      stickerList.value = List<AllStickerResponseModel>.from(
        responseData['data']['stickers'].map(
              (element) => AllStickerResponseModel.fromJson(element),
        ),
      );
      filteredList.value = stickerList;
      isStickerLoading(false);
    }else{
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
      isStickerLoading(false);
    }
  }

  Future<void> getAllStickers() async {
    if (isStickerLoading.value || !hasMoreData) return;

    isStickerLoading(true);
    var response = await ApiClient.getData(
        "${ApiConstants.allStickerEndPoint}?page=$currentPage&limit=$itemsPerPage"
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.body;
      List<AllStickerResponseModel> newData = List<AllStickerResponseModel>.from(
        responseData['data']['stickers'].map(
              (element) => AllStickerResponseModel.fromJson(element),
        ),
      );

      // Add the new data to the list
      if (newData.isNotEmpty) {
        stickerList.addAll(newData);
        filteredList.value = stickerList;
        currentPage++;
      } else {
        hasMoreData = false; // No more data to load
      }
    } else {
      ToastMessageHelper.errorMessageShowToster(response.body['message']);
    }
    isStickerLoading(false);
  }


  /// Method to search/filter data
  searchStickerData(String query) {
    if (query.isEmpty) {
      stickerList.value = filteredList;
    } else {
      stickerList.value = filteredList
          .where((item) => item.name.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }



  ///===================== Single Sticker ================<>

  RxBool isSingleStickerLoading = false.obs;
  Rx<SingleStickerModel> singleSticker = SingleStickerModel().obs;
  getSingleSticker({String id=''}) async{
    isSingleStickerLoading(true);
    var response = await ApiClient.getData(ApiConstants.singleStickerEndPoint(id));
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201){
      singleSticker.value = SingleStickerModel.fromJson(response.body['data']);
      isSingleStickerLoading(false);
    }else{
      isSingleStickerLoading(false);
    }
  }


  ///-------------my Pmoji -----------------

  RxList<MyPmojiResponseModel> myPmojiList = <MyPmojiResponseModel>[].obs;
  RxBool isMyPmojiLoading = false.obs;
  Future<void> getAllMyPmoji() async {
    myPmojiList.clear();
    isMyPmojiLoading(true);
    var response = await ApiClient.getData(ApiConstants.allMyPmojiEndPoint);
    print("===========myPmoji${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.body;

      myPmojiList.value = List<MyPmojiResponseModel>.from(
        responseData['data'].map(
              (element) => MyPmojiResponseModel.fromJson(element),
        ),
      );
      isMyPmojiLoading(false);
    }else{
      isMyPmojiLoading(false);
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








  ///==================download=============
  Future<void> viewFile({required String id, required String filename}) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}/sticker/sticker-detail?id=$id");
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final directory = await getDownloadsDirectory();
      final filePath = '${directory?.path}/${filename}.png';
      final file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);
      await OpenFile.open(filePath);
    } else {
      print('Failed to load file: ${response.statusCode}');
    }
  }


  Future<void> downloadFile({required String id, required String filename}) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}/sticker/sticker-detail?id=$id");
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      try {
        // Save the file to the Pictures directory for easy access in the gallery
        final directory = Directory('/storage/emulated/0/Pictures/PmojiGallery');
        if (!await directory.exists()) {
          await directory.create(recursive: true); // Create the directory if it doesn't exist
        }

        // Define the file path in the gallery folder
        final filePath = '${directory.path}/$filename.svg';
        final file = File(filePath);

        // Write the file to the device
        await file.writeAsBytes(response.bodyBytes);
        print('Downloaded $filename to $filePath');

        // Optionally, open the file after downloading
        await OpenFile.open(filePath);
      } catch (e) {
        print('Failed to save file: $e');
      }
    } else {
      print('Failed to load file: ${response.statusCode}');
    }
  }





  Future<void> downloadGallery(List<Map<String, String>> stickerList) async {
    // Iterate over the list of stickers to download each
    for (var sticker in stickerList) {
      final id = sticker['id'];
      final filename = sticker['filename'];

      if (id != null && filename != null) {
        final uri = Uri.parse("${ApiConstants.baseUrl}/cart/my-cart");
        final http.Response response = await http.get(uri);

        // Check if the request was successful
        if (response.statusCode == 200) {
          try {
            // Get the Pictures directory to save the files
            final directory = Directory('/storage/emulated/0/Pictures/PmojiGallery');
            if (!await directory.exists()) {
              await directory.create(recursive: true); // Create directory if it doesn't exist
            }

            // Define the path where each file will be saved
            final filePath = '${directory.path}/$filename.svg';
            final file = File(filePath);

            // Write the response bytes to the file
            await file.writeAsBytes(response.bodyBytes);

            // Print success message
            print('Downloaded $filename');

            // Auto-open the file after download
            final result = await OpenFile.open(filePath);
            if (result.type != ResultType.done) {
              print('Failed to open file: $result.message');
            }
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

    // Optionally open the gallery folder after downloads complete
    await OpenFile.open((await getExternalStorageDirectory())?.path ?? '');
  }

}