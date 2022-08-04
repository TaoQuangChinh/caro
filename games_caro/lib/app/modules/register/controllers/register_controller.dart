import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPass = TextEditingController();
  TextEditingController inputNameGame = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> submit() async {
    final form = {
      "name": inputName.text,
      "pass": inputPass.text,
      "name_game": inputNameGame.text
    };
    isLoading.value = true;
    final res = await ApiProvider().posts('/register', form);
    isLoading.value = false;
    if (res.status.hasError) {
      Get.toNamed(Routes.LOGIN);
    }
  }
}
