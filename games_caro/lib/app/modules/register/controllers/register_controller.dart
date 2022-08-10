import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/service.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputNameGame = TextEditingController();

  final isLoading = false.obs;
  final uuid = Uuid();

  final listError = ["", ""].obs;
  var _modelInfo = '';
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
    inputEmail.dispose();
    inputNameGame.dispose();
    super.onClose();
  }

  void initData() {
    getModel();
  }

  bool validator() {
    var result = true;
    listError.value = ["", ""];
    if (inputNameGame.text.trim().isEmpty) {
      listError[0] = "vui lòng không để trống thông tin";
      result = false;
    }
    if (inputEmail.text.trim().isEmpty) {
      listError[1] = "vui lòng không để trống thông tin";
      result = false;
    } else if (!inputEmail.text.trim().isEmail) {
      listError[1] = "địa chỉ email không hợp lệ";
      result = false;
    }
    return result;
  }

  void getModel() async {
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
    if (!validator()) return;
    final form = {
      "id": uuid.v4(),
      "email": inputEmail.text,
      "name_game": inputNameGame.text,
      "device_mobi": _modelInfo
    };
    isLoading.value = true;
    final res = await Service().post('$kApi/register', form);
    final body = jsonDecode(res.bodyString!);
    isLoading.value = false;
    print(body['code']);
    // if (res.status.hasError) {
    //   Get.toNamed(Routes.LOGIN);
    // } else {
    //   isLoading.value = false;
    // }
  }
}
