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
      // backgroundColor: Color(0xff1d38ad),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: CountDownProgressIndicator(
                    // controller: _controller,
                    valueColor: Colors.red,
                    backgroundColor: Colors.indigo,
                    initialPosition: 0,
                    strokeWidth: 2,
                    labelTextStyle: const TextStyle(
                        fontSize: 10, color: Colors.indigo, fontWeight:
                    FontWeight.bold),
                    timeTextStyle: const TextStyle(
                      fontSize: 12, color: Colors.indigo,),

                    duration: int.parse(
                        loginController.quizResponse.first.duration.toString()),
                    text: 'SEC',
                    onComplete: () => {Get.toNamed(Routes.HOME)},
                  ),
                ),

              ],
            ),

            AppWidgets().gapH24(),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  loginController.quizResponse.first.data!.first.title.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.indigo),
                ),
          //      const Text
                //      ('--------------------------------------------------------------',overflow: TextOverflow.clip,)
              ],
            ),

            const SizedBox(height: 20),
            Obx(() {
              return Column(
                children: List.generate(
                    loginController.quizResponse.first.data!.first
                        .questionOption!.length, (index) {
                  return RadioListTile<int>(
                    title: Text(loginController.quizResponse.first.data!.first
                        .questionOption![index].quesOption
                        .toString()),
                    value: index,
                    activeColor: Colors.indigo,
                    groupValue: controller.selectedAnswer.value,
                    onChanged: (value) {
                      controller.selectedAnswer.value = value!;
                    },
                  );
                }),
              );
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width/2,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  if (loginController.quizResponse.first.data!.first.rightAnswer
                          .toString() ==
                      controller.selectedAnswer.value.toString()) {
                    AppWidgets().getSnackBar(
                      message: 'Correct Answer',
                      backgroundColor: Colors.green
                    );

                    loginController.socket.emit('submit_answer', {
                      'name':'dddd',
                      'mobile': loginController.phoneController.value.text,
                      'score': 10,
                      'isCorrect': true,
                      'exam_duration': loginController.quizResponse.first.duration,
                      'exam_start_time': controller.startTime.value.toString(),
                      "submit_date_time": DateTime.now().toString(),
                    });
                  } else {
                    loginController.socket.emit('submit_answer', {
                      'name':'dddd',
                      'mobile': loginController.phoneController.value.text,
                      'score': 10,
                      'isCorrect': false,
                      'exam_duration': loginController.quizResponse.first.duration,
                      'exam_start_time': controller.startTime.value.toString(),
                      "submit_date_time": DateTime.now().toString(),
                    });
                    AppWidgets().getSnackBar(
                      message: 'Wrong Answer',
                      backgroundColor: Colors.red
                    );
                  }


                  print('Selected answer: ${controller.selectedAnswer.value}');
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
