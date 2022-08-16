import 'package:flutter/material.dart';
import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/modules/login/views/body/body_bottom_sheet.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ListAccountController extends GetxController
    with GetTickerProviderStateMixin {
  final isLoading = false.obs;
  final listAccount = <UserModel>[].obs;

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
    isLoading.value = true;
    final res = await api.get('$kUrl/list-account');
    isLoading.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      final convertList = res.data['payload'] as List;
      listAccount.value =
          convertList.map((data) => UserModel.fromJson(data)).toList();
      update();
    }
  }

  void showBottomSheet(UserModel user) {
    if (user.saveAccount == '1') {
      Get.offNamed(Routes.HOME);
      return;
    }
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: Get.context!,
        constraints: const BoxConstraints(maxHeight: 148),
        builder: (context) {
          return BodyBottomSheet(removeAccount: () {}, user: user);
        });
  }
}
