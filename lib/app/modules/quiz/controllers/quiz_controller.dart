import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';
import 'package:get_storage/get_storage.dart';

class QuizController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedAnswer = 0.obs;
  var answer = Get.find<LoginController>()
      .quizResponse
      .first
      .data!
      .first
      .questionOption!.first
      .quesValue.obs;
  var answers = <String>[].obs;
  var startTime = DateTime.now().obs;
  var controller = Get.find<LoginController>();

  late AnimationController animationController;
   final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animationController.forward();
    controller.socket.emit(
        'question', controller.quizResponse.first.data!.first.details.toString());
  }
}
