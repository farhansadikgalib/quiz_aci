import 'dart:convert';

import 'package:get/get.dart';

import '../../login/controllers/login_controller.dart';

class QuizController extends GetxController {
  var selectedAnswer = -1.obs;
  var questionTitle = ''.obs;
  var answers = <String>[].obs;
  var startTime = DateTime.now().obs;
  var controller = Get.find<LoginController>();

  @override
  void onInit() {
    super.onInit();
    controller.socket.emit(
        'question', controller.quizResponse.first.data!.first.title.toString());
  }

  void loadQuizData(String jsonString) {
    Map<String, dynamic> parsedJson = json.decode(jsonString);
    var quizData = parsedJson['data'][0];
    questionTitle.value = quizData['Title'];
    answers.value = List<String>.from(
        quizData['question_option'].map((x) => x['QuesOption']));
  }
}
