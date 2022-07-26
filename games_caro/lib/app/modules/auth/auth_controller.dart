import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController {
  // setup in app
  final user = UserModel().obs;
  final _log = Logger();

  // save images to fire store
  late FirebaseStorage storage;

  // get device
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

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

  Future<void> checkDevice() async {
    final _device = await Utils.getDevice();
    final form = {"device_mobi": _device};
    final res = await api.get('/check-device', queryParameters: form);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      final totalDevice = res.data['payload']['total_device_login'];
      final dataUser = res.data['payload']['data_user'];
      if (![0, 1].contains(totalDevice)) {
        Get.offNamed(Routes.LIST_ACCOUNT);
      } else {
        if (dataUser != null) {
          user.value = UserModel.fromJson(dataUser);
          Get.offNamed(Routes.HOME);
        } else {
          Get.offNamed(Routes.LOGIN);
        }
      }
    } else {
      Utils.messError(res.data['message']);
    }
  }
}
