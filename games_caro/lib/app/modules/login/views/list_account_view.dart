import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/modules/login/views/body/body_list_account.dart';
import 'package:games_caro/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/list_account_controller.dart';

class ListAccountView extends GetView<ListAccountController> {
  const ListAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: const BodyListAccount(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kIndigoBlueColor900,
        onPressed: () =>
            Get.toNamed(Routes.REGISTER, parameters: {'isHide': 'true'}),
        child: const Icon(Icons.edit, color: kWhiteColor, size: 27),
      ),
    );
  }
}
