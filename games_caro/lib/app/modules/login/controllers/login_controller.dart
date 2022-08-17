import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPass = TextEditingController();

  final isLoadingLogin = false.obs;
  final listErrLogin = ["", ""].obs;
  final isSaveAccount = false.obs;
  var _modelInfo = '';

  final AuthController authController = Get.find();
  final DeviceInfoPlugin _device = DeviceInfoPlugin();

  @override
  void onInit() {
    initData();
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

  void initData() async {
    if (Get.parameters['screen'] == 'listAccount') {
      inputEmail.text = '${Get.parameters['email']}';
    }
    await getModel();
  }

  bool get validatorLogin {
    var result = true;
    listErrLogin.value = ["", ""];
    if (inputEmail.text.isEmpty) {
      listErrLogin[0] = 'thông tin không được để trống';
      result = false;
    } else if (!inputEmail.text.isEmail) {
      listErrLogin[0] = 'email không đúng định dạng';
      result = false;
    }
    if (inputPass.text.isEmpty) {
      listErrLogin[1] = 'mật khẩu không được để trống';
      result = false;
    } else if (inputPass.text.length > 50) {
      listErrLogin[1] = 'mật khẩu không lớn quá 8 kí tự';
      result = false;
    }
    return result;
  }

  Future<void> getModel() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await _device.androidInfo;
      //print(android.model);
      _modelInfo = "${android.model}";
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await _device.iosInfo;
      //print(ios.utsname.machine);
      _modelInfo = "${ios.model}";
    }
  }

  Future<void> submit() async {
    if (!validatorLogin) return;
    final form = {
      "email": inputEmail.text,
      "pass": inputPass.text,
      "save_acc": isSaveAccount.value,
      "device_mobi": _modelInfo
    };
    isLoadingLogin.value = true;
    final res = await api.post('$kUrl/login', data: form);
    isLoadingLogin.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      authController.user.value = UserModel.fromJson(res.data['payload']);
      Get.offAllNamed(Routes.HOME);
    } else {
      print(res.data['message']);
    }
  }

  void clearDataLogin() {
    inputEmail.clear();
    inputPass.clear();
  }

  void handleSavePass(value) {
    isSaveAccount(value);
  }
}
