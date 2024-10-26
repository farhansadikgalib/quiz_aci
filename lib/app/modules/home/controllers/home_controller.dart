import 'dart:convert';

import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/print_log.dart';
import 'package:quiz/app/modules/login/controllers/login_controller.dart';

class HomeController extends GetxController {

 var controller= Get.find<LoginController>();
 final status = false.obs;
  @override
  void onInit() {
    super.onInit();

    controller.socket.on('quiz_begin', (data) {
      printLog('Quiz started');
      printLog(data);
      Map<String, dynamic> parsedJson = json.decode(data);
       status.value = parsedJson['status'];

      printLog(status);

    });

    printLog('aaa');


  }


}
