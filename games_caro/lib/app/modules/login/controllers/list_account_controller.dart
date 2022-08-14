import 'dart:convert';

import 'package:games_caro/app/common/api.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:get/get.dart';

class ListAccountController extends GetxController {
  final isLoading = false.obs;
  final listAccount = <UserModel>[].obs;

  @override
  void onInit() async {
    await getListAccount();
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

  Future<void> getListAccount() async {
    isLoading.value = true;
    final res = await api.get('$kUrl/list-account');
    isLoading.value = false;

    if (res.statusCode == 200 && res.data['code'] == 0) {
      final convertList = res.data['payload'] as List;
      listAccount.value =
          convertList.map((data) => UserModel.fromJson(data)).toList();
    }
    update();
  }
}
