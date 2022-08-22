import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/auth/auth_controller.dart';
import 'package:games_caro/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:games_caro/app/modules/change_pass/views/verifi_code_screen.dart';
import 'package:games_caro/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ListAccountController extends GetxController
    with GetTickerProviderStateMixin {
  final isLoading = false.obs;
  final listAccount = <UserModel>[].obs;

  final _log = Logger();
  final AuthController authController = Get.find();
  final ChangePassController changePassController = Get.find();
  late final AnimationController _aniController =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat(reverse: false);
  late final Animation<double> animation =
      CurvedAnimation(parent: _aniController, curve: Curves.slowMiddle);

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
    _aniController.dispose();
    super.onClose();
  }

  void initData() async {
    await getListAccount();
  }

  Future<void> getListAccount() async {
    final _device = await Utils.getDevice();
    final form = {'device': _device};

    isLoading.value = true;
    final res = await api.get('/list-account', queryParameters: form);
    isLoading.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      final convertList = res.data['payload'] as List;
      listAccount.value =
          convertList.map((data) => UserModel.fromJson(data)).toList();
    } else {
      Utils.messError(res.data['message']);
    }
  }

  void showBottomSheet(UserModel user) {
    if (user.saveAccount == '1') {
      authController.user.value = user;
      Get.offNamed(Routes.HOME);
      return;
    }
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 140),
        builder: (context) {
          return BodyBottomSheet(
            removeAccount: () async {
              Get.back();
              await handleRemoveAccount(user.id!);
            },
            user: user,
            changePass: () {
              Get.back();
              changePassController.clearDataVerifiCode();
              handleVerifiCode(user.email!);
            },
          );
        });
  }

  void handleVerifiCode(String email) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: VerifiCodeScreen(email: email),
          );
        });
  }

  Future<void> handleRemoveAccount(String id) async {
    final form = {'id': id};

    isLoading(true);
    final res = await api.delete('/remove-account', data: form);
    isLoading(false);
    if (res.statusCode == 200 && res.data['code'] == 0) {
      getListAccount();
      Utils.messSuccess(res.data['message']);
    } else {
      Utils.messError(res.data['message']);
    }
  }
}
