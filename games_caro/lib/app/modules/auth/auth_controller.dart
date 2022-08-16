import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // setup in app
  final user = UserModel().obs;

  // save images to fire store
  late FirebaseStorage storage;

  // get device
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
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
    super.onClose();
  }

  void initData() async {
    storage = FirebaseStorage.instance;
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
    final res = await api.get('$kUrl/check-device', queryParameters: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      final deviceResult = "${res.data['payload']['deviceMobi']}";
      if (deviceResult != "null") {
        Get.offNamed(Routes.LIST_ACCOUNT);
      } else {
        Get.offNamed(Routes.REGISTER);
      }
    }
  }
}
