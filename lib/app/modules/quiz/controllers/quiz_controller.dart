import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';

class QuizController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedAnswer = 0.obs;
  var answers = <String>[].obs;
  var startTime = DateTime.now().obs;
  var controller = Get.find<LoginController>();

  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animationController.forward();
    controller.socket.emit(
        'question', controller.quizResponse.first.data!.first.title.toString());
  }
}
