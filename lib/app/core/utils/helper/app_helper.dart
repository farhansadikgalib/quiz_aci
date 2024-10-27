import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class AppHelper {
  showLoader() {
    EasyLoading.instance
      ..indicatorWidget = Container(
        height: 175,
        width: 175,
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Lottie.asset('assets/loader.json',
            height: 125, width: 125, fit: BoxFit.fill),
      )
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..indicatorColor = Colors.transparent
      ..maskColor = Colors.transparent
      ..backgroundColor = Colors.transparent
      ..boxShadow = []
      ..contentPadding = EdgeInsets.zero
      ..radius = 0
      ..indicatorSize = 60.0
      ..userInteractions = false
      ..dismissOnTap = true;

    return EasyLoading.show();
  }

  hideLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
    // Navigator.of(context, rootNavigator: true).pop();
  }

  logout() {
    // Get.offAndToNamed(Routes.authentication);
  }

  refreshLogin() async {
    // if (kDebugMode) {
    //   print(expiredTime.$.toString());
    //   print(timeDifference(expiredTime: expiredTime.$).toString());
    // }
    //
    // if (timeDifference(expiredTime: expiredTime.$) <= 0) {
    //   // var data = await AuthRepository().getRefreshToken();
    //   // await AuthHelper().clearUserData();
    //   // await AuthHelper().setUserData(data.data, true);
    // }
  }

  timeDifference({expiredTime}) {
    final expiredTimeData = DateTime.parse(expiredTime);
    final todayTime = DateTime.now();
    final difference = expiredTimeData.difference(todayTime).inMinutes;
    return difference;
  }

  getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  hideKeyboard() {
    // FocusManager.instance.primaryFocus?.unfocus();
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild?.unfocus();
    }
  }



  bool isKeyBoardVisible(context) {
    return MediaQuery.of(context).viewInsets.bottom != 0 ? false : true;
  }

  scrollFlightListToTop(scrollController) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  // pickImageFromDevice({isCamera = false}) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = isCamera
  //       ? await picker.pickImage(source: ImageSource.camera)
  //       : await picker.pickImage(source: ImageSource.gallery);
  //   return image?.path ?? null;
  // }
}
