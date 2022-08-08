import 'package:flutter/material.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/utils/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_caro.png', height: 170),
            const SizedBox(height: 40),
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
                titleButton: "Đăng nhập",
                onPressed: () async => await controller.submit()))
          ],
        ),
      ),
    );
  }
}
