import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/utils/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/images/logo_caro.png', height: 170),
            const SizedBox(height: 10),
            Text("Register Account",
                style: PrimaryStyle.bold(color: kPrimaryColor, 35)),
            const SizedBox(height: 40),
            CustomInput(
              controller: controller.inputNameGame,
              title: 'Tên người chơi',
            ),
            const SizedBox(height: 15),
            CustomInput(
              controller: controller.inputName,
              title: 'Tài khoản email',
            ),
            const SizedBox(height: 15),
            CustomInput(
              controller: controller.inputPass,
              title: 'Mật khẩu',
            ),
            const SizedBox(height: 40),
            Obx(() => ButtonLoading(
                height: 40,
                width: 150,
                style: PrimaryStyle.medium(16),
                isLoading: controller.isLoading.value,
                titleButton: "Đăng ký",
                onPressed: () async => await controller.submit()))
          ],
        ),
      ),
    );
  }
}
