import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:quiz/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            
            ElevatedButton(onPressed: (){

              Get.toNamed(Routes.QUIZ);
            }, child: Text('Exam Start'))
          ],
        ),
      ),
    );
  }
}
