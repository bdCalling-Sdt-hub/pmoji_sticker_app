
import 'package:get/get.dart';

import '../../controller/controller.dart';

class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => PmojiCartController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
  }
}