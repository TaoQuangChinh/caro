import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/routes/app_pages.dart';

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
      body: GetX<LoginController>(builder: (_) {
        if (_.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            TextField(
              controller: controller.inputName,
            ),
            TextField(
              controller: controller.inputPass,
            ),
            ElevatedButton(
                onPressed: () async => await _.submit(), child: Text("SUBMIT"))
          ],
        );
      }),
    );
  }
}