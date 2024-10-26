import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // controller.onInit();
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
                      Get.toNamed(Routes.QUIZ);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                    child: const Text('Start Quiz')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
