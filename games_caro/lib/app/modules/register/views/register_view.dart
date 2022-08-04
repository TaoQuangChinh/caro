import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: GetX<RegisterController>(builder: (_) {
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
            TextField(
              controller: controller.inputNameGame,
            ),
            ElevatedButton(
                onPressed: () async => await _.submit(), child: Text("SUBMIT"))
          ],
        );
      }),
    );
  }
}
