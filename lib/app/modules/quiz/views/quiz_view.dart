import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/app_widgets.dart';
import 'package:quiz/app/modules/login/controllers/login_controller.dart';
import 'package:quiz/app/routes/app_pages.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 122, 70, 212),
              Color.fromARGB(255, 71, 38, 128),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 75,
                    width: 75,
                    child: CountDownProgressIndicator(
                      valueColor: Colors.red,
                      backgroundColor: Colors.white,
                      initialPosition: 0,
                      strokeWidth: 2,
                      labelTextStyle: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      timeTextStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      duration: int.parse(loginController
                          .quizResponse.first.duration
                          .toString()),
                      text: 'SEC',
                      onComplete: () => {Get.toNamed(Routes.HOME)},
                    ),
                  ),
                ],
              ),
              AppWidgets().gapH24(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    loginController.quizResponse.first.data!.first.title
                        .toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Column(
                  children: List.generate(
                      loginController.quizResponse.first.data!.first
                          .questionOption!.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeInOut,
                      child: Card(
                        color: Colors.white.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RadioListTile<int>(
                          title: Text(
                            loginController.quizResponse.first.data!.first
                                .questionOption![index].quesOption
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: index,
                          activeColor: Theme.of(context).primaryColor,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context).primaryColor;
                              }
                              return Colors.white;
                            },
                          ),
                          groupValue: controller.selectedAnswer.value,
                          onChanged: (value) {
                            controller.selectedAnswer.value = value!;
                          },
                        ),
                      ),
                    );
                  }),
                );
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: Get.width / 1.25,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    if (loginController
                            .quizResponse.first.data!.first.rightAnswer
                            .toString() ==
                        controller.selectedAnswer.value.toString()) {
                      AppWidgets().getSnackBar(
                          message: 'Correct Answer',
                          backgroundColor: Colors.green);

                      loginController.socket.emit('submit_answer', {
                        'name': 'dddd',
                        'mobile': loginController.phoneController.value.text,
                        'score': 10,
                        'isCorrect': true,
                        'exam_duration':
                            loginController.quizResponse.first.duration,
                        'exam_start_time':
                            controller.startTime.value.toString(),
                        "submit_date_time": DateTime.now().toString(),
                      });
                    } else {
                      loginController.socket.emit('submit_answer', {
                        'name': 'dddd',
                        'mobile': loginController.phoneController.value.text,
                        'score': 10,
                        'isCorrect': false,
                        'exam_duration':
                            loginController.quizResponse.first.duration,
                        'exam_start_time':
                            controller.startTime.value.toString(),
                        "submit_date_time": DateTime.now().toString(),
                      });
                      AppWidgets().getSnackBar(
                          message: 'Wrong Answer', backgroundColor: Colors.red);
                    }

                    print(
                        'Selected answer: ${controller.selectedAnswer.value}');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  child: const Text(
                    'Finish Quiz',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
