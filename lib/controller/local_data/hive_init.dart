
import 'package:path_provider/path_provider.dart' as path;

class HiveInitializedController {
  static Future<void> hiveInitialized() async {
    final localpath = await path.getDownloadsDirectory();
    // Hive.init("${localpath!.path}");
    // await Hive.openBox<String>("getStarted");
    // await Hive.openBox<String>("loginResponse");
  }
}