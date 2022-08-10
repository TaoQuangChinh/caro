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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset('assets/images/logo_caro.png', height: 170),
              const SizedBox(height: 10),
              Text("Register Account",
                  style: PrimaryStyle.bold(color: kPrimaryColor, 35)),
              const SizedBox(height: 40),
              Obx(() => CustomInput(
                    controller: controller.inputNameGame,
                    title: 'Tên người chơi',
                    err: controller.listError[0],
                  )),
              const SizedBox(height: 15),
              Obx(() => CustomInput(
                    controller: controller.inputEmail,
                    title: 'Tài khoản email',
                    err: controller.listError[1],
                  )),
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
      ),
    );
  }
}
