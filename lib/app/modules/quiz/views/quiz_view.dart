import 'package:animated_list_item/animated_list_item.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/app_widgets.dart';
import 'package:quiz/app/core/utils/helper/print_log.dart';
import 'package:quiz/app/modules/home/controllers/home_controller.dart';
import 'package:quiz/app/modules/login/controllers/login_controller.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
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
                        duration: 40,
                        text: 'SEC',
                        onComplete: () {
                          AppWidgets().getSnackBar(
                              message: 'Time Over',
                              backgroundColor: Colors.red);
                          Get.back();
                          controller.box.write('submittedAns', true);
                          Get.find<HomeController>().startQuiz.value = false;
                        },
                      ),
                    ),
                  ],
                ),
                AppWidgets().gapH24(),
                Wrap(
                  children: [
                    Text(
                      loginController.quizResponse.first.data!.first.details
                          .toString(),
                      style: const TextStyle(
                          fontSize: 18,
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
                      return AnimatedListItem(
                        index: index,
                        animationType: AnimationType.flipX,
                        length: loginController.quizResponse.first.data!.first
                            .questionOption!.length,
                        aniController: controller.animationController,
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
                              controller.answer.value = loginController
                                  .quizResponse
                                  .first
                                  .data!
                                  .first
                                  .questionOption![value]
                                  .quesValue
                                  .toString();

                              printLog(controller.answer.value);
                            },
                          ),
                        ),
                      );
                    }),
                  );
                }),
                AppWidgets().gapH(40),
                SizedBox(
                  width: Get.width,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      printLog(loginController
                          .quizResponse.first.data!.first.rightAnswer
                          .toString());
                      printLog(controller.answer.value.toString());
                      Get.back();
                      controller.box.write('submittedAns', true);
                      Get.find<HomeController>().startQuiz.value = false;
                      if (loginController
                              .quizResponse.first.data!.first.rightAnswer
                              .toString() ==
                          controller.answer.value.toString()) {
                        AppWidgets().getSnackBar(
                            message: 'Correct Answer',
                            backgroundColor: Colors.green);

                        loginController.socket.emit('submit_answer', {
                          'name': loginController.nameController.value.text,
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
                          'name': loginController.nameController.value.text,
                          'mobile': loginController.phoneController.value.text,
                          'score': 0,
                          'isCorrect': false,
                          'exam_duration':
                              loginController.quizResponse.first.duration,
                          'exam_start_time':
                              controller.startTime.value.toString(),
                          "submit_date_time": DateTime.now().toString(),
                        });
                        AppWidgets().getSnackBar(
                            message: 'Wrong Answer',
                            backgroundColor: Colors.red);
                      }

                      print(
                          'Selected answer: ${controller.selectedAnswer.value}');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      side: const BorderSide(color: Colors.white, width: 1.5),
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
      ),
    );
  }
}
