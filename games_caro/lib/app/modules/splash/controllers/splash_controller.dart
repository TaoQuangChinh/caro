import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/service.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint);

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final AuthController authController = Get.find();

  var _device = "";

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
    _controller.dispose();
    super.onClose();
  }

  void initData() async {
    await getDevice();
    await checkDevice();
  }

  Future<void> getDevice() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await _deviceInfo.androidInfo;
      _device = "${android.model}";
    } else if (Platform.isIOS) {
      IosDeviceInfo ios = await _deviceInfo.iosInfo;
      _device = "${ios.model}";
    }
  }

  Future<void> checkDevice() async {
    final form = {"device_mobi": _device};
    final res = await Service().get('$kUrl/check-device', query: form);
    final body = jsonDecode(res.bodyString!);
    print(body['payload']['mobi_device']);
    if (res.statusCode == 200 && body['code'] == 0) {
      authController.authDevice.value = "${body['payload']['mobi_device']}";
      if (authController.authDevice.value != "null") {
        authController.user.value = UserModel.fromJson(body['payload']);
        Get.offNamed(Routes.LIST_ACCOUNT);
      } else {
        Get.offNamed(Routes.REGISTER);
      }
    }
  }
}
