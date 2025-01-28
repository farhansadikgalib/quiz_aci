import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/core/base/base_view.dart';
import 'package:quiz/app/core/utils/helper/app_widgets.dart';
import 'package:quiz/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    controller.onInit();
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnyImageView(
                  imagePath: 'assets/home.json',
                ),
                const SizedBox(height: 80),
                const Text(
                  'Level Up Your Knowledge!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  width: Get.width / 1.25,
                  height: 50,
                  child: OutlinedButton(
                      onPressed: () {
                        if (controller.startQuiz.value) {
                          Get.toNamed(Routes.QUIZ);
                        } else {
                          AppWidgets().getSnackBar(
                            message: 'Wait for next quiz '
                                'to '
                                'start',
                            backgroundColor: Colors.grey,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        side: const BorderSide(color: Colors.white, width: 1.5),
                      ),
                      child: Text(
                        controller.startQuiz.value
                            ? 'Start '
                                'Quiz'
                            : 'Waiting for next Quiz',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
