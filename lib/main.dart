// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_value/shared_value.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/constants/app_constants.dart';
import 'app/core/style/app_colors.dart';
import 'app/routes/app_pages.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*  await Firebase.initializeApp();
  Future.delayed(const Duration(milliseconds: 100), () async {
    FirebaseInitialize();
    await FirebaseMessaging.instance.subscribeToTopic('AGPAY');
  });

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  RemoteConfigService().initializeConfig();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // if (!kDebugMode) {
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // }
*/
  await ScreenUtil.ensureScreenSize();
  runApp(ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
            overlays: [SystemUiOverlay.bottom]);

        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark));

        return SharedValue.wrapApp(
          GetMaterialApp(
            title: "Quiz",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            builder: EasyLoading.init(),
            theme: ThemeData(
              useMaterial3: false,
              canvasColor: AppColors.white,
              primaryColor: AppColors.primaryColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),

            defaultTransition: transition,
            getPages: AppPages.routes,
            enableLog: kDebugMode,
          ),
        );
      }));
}
