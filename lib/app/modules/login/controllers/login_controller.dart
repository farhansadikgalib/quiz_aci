import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/app/core/utils/helper/app_widgets.dart';
import 'package:quiz/app/core/utils/helper/print_log.dart';
import 'package:quiz/app/data/model/login/login_response.dart';
import 'package:quiz/app/data/repository/login/login_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final phoneController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final joinNumber = TextEditingController().obs;
  final quizResponse = <LoginResponse>[].obs;

  late IO.Socket socket;
  var status = 'disconnected'.obs;
  final socketId = ''.obs;
  final response = ''.obs;

  @override
  void onInit() {
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io('http://khep.mis.digital', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.onConnect((_) {
      debugPrint('connected');

      status.value = 'connected';
      socketId.value = socket.id ?? 'No ID';
      debugPrint('Socket ID: ${socketId.value}');
      socket.on('quiz_start', (data) {
        debugPrint('Quiz started');
        debugPrint(jsonEncode(data));

        Map<String, dynamic> parsedJson = json.decode(jsonEncode(data));
        int quizNumber = int.parse(parsedJson['data']['quiz_number']);
        print('Quiz Number: $quizNumber');
        joinNumber.value.text = quizNumber.toString();
      });
    });

    socket.onDisconnect((_) {
      debugPrint('disconnected');
    });
  }

  void login() async {
    var response = await LoginRepository().getLogin(phoneController.value.text);
    printLog(response);
    if (response.success == 1) {
      quizResponse.add(response);
      Get.toNamed(Routes.HOME,arguments: true);
    } else {
      AppWidgets()
          .getSnackBar(message: response.message ?? 'Something went wrong');
    }
  }
}
