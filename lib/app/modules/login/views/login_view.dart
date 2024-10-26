import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/app_widgets.dart';
import 'package:quiz/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            AnyImageView(
              imagePath: 'assets/logo.png',
              width: 200,
              height: 200,
            ),

            AppWidgets().gapH24(),



            TextField(
              controller: controller.joinNumber.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              decoration: const InputDecoration(
                labelText: 'Quiz Id',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.nameController.value,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                labelText: 'Enter Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.phoneController.value,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              decoration: const InputDecoration(
                labelText: 'Enter your mobile number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String input = controller.phoneController.value.text;
                if(controller.nameController.value.text.isEmpty || controller.phoneController.value.text.isEmpty){
                  AppWidgets().getSnackBar(message: 'Please enter your name and mobile number');
                  return;
                }
                if (input.length == 11) {
                  controller.login();
                } else {
                  // Show an error message
                  AppWidgets().getSnackBar(message: 'Please enter a valid '
                      'mobile number');
                  print('Please enter your mobile number');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}