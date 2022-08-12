import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/service.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();

  final isLoading = false.obs;

  final listErr = ["", ""].obs;

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

  bool get validator {
    var result = true;
    listErr.value = ["", ""];
    if (inputEmail.text.isEmpty) {
      listErr[0] = 'thông tin không được để trống';
      result = false;
    } else if (!inputEmail.text.isEmail) {
      listErr[0] = 'email không đúng định dạng';
      result = false;
    }
    if (inputPass.text.isEmpty) {
      listErr[1] = 'mật khẩu không được để trống';
      result = false;
    } else if (inputPass.text.length > 8) {
      listErr[1] = 'mật khẩu không lớn quá 8 kí tự';
      result = false;
    }
    return result;
  }

  Future<void> submit() async {
    if (!validator) return;
    final form = {"email": inputEmail.text, "pass": inputPass.text};
    isLoading.value = true;
    final res = await Service().post('$kUrl/login', form);
    isLoading.value = false;
    final body = jsonDecode(res.bodyString!);

    if (res.statusCode == 200 && body['code'] == 0) {
      print("data: ${body['payload']}");
      clearData();
      Get.toNamed(Routes.HOME);
    } else {
      print(body['message']);
    }
  }

  void clearData() {
    inputEmail.clear();
    inputPass.clear();
  }
}
