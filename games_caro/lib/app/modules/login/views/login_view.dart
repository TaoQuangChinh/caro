import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: controller.inputName,
          ),
          ElevatedButton(
              onPressed: () {
                //ApiProvider.gets();
              },
              child: Text("SUBMIT"))
        ],
      ),
    );
  }
}
