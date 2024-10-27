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
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

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
            statusBarIconBrightness: Brightness.light));

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
              primaryColor: Colors.white,
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
