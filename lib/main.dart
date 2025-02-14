import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'constant.dart';
import 'controller/local_data/hive_init.dart';
import 'helpers/di/dependancy_injaction.dart';
import 'routes/app_routes.dart';
import 'themes/light_theme.dart';
import 'views/payment_constants.dart';
import 'views/screens/screens.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey = Constants.publishAbleKey;
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Stripe',
//       home: HomeScreen(),
//     );
//   }
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Constants.publishAbleKey;
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  //    const MyApp()
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Emoji Sticker',
          home: SplashScreen(),
          getPages: AppRoutes.routes,
          theme: light(),
          themeMode: ThemeMode.light,
        );
      },
      designSize: const Size(393, 852),
    );
  }
}



