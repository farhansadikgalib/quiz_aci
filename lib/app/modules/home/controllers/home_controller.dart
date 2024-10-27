import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/print_log.dart';
import 'package:quiz/app/modules/login/controllers/login_controller.dart';

import '../../../core/utils/helper/app_widgets.dart';
import '../../../data/repository/login/login_repository.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var controller = Get.find<LoginController>();
  final startQuiz = false.obs;
   bool firstTime = Get.arguments;

  final box = GetStorage();

final submittedAns = false.obs;
  @override
  void onInit() {
    super.onInit();

   //  printLog(box.read('submittedAns'));
   // submittedAns.value = box.read('submittedAns');



    controller.socket.on('quiz_begin', (data) {
      printLog('Quiz begin');
      printLog(jsonEncode(data));
      Map<String, dynamic> parsedJson = json.decode(jsonEncode(data));

      startQuiz.value = parsedJson['status'];
      printLog(startQuiz.value);

 /*     Future.delayed(const Duration(milliseconds: 200), () {
        if(submittedAns.value){
          AppWidgets().getSnackBar(
              message: 'You have already submitted the quiz',
              backgroundColor: Colors.grey);
        }
      });*/

      startQuiz.refresh();
      if (startQuiz.value) {
        if(!firstTime){
          nextQuiz();
        }
      }
    });
  }

  nextQuiz() async {
    var response =
        await LoginRepository().getLogin(controller.phoneController.value);
    printLog(response);
    if (response.success == 1) {
      controller.quizResponse.clear();
      controller.quizResponse.add(response);
    } else {
      AppWidgets()
          .getSnackBar(message: response.message ?? 'Something went wrong');
    }
  }
}
