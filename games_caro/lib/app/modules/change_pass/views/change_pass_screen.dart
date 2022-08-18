import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:games_caro/app/widget/button/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';
import 'package:get/get.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePassController>(builder: (_) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomInput(
                title: 'Mật khẩu mới',
                controller: _.inputPassNew,
                err: _.listErrChange[0]),
            const SizedBox(height: 17),
            CustomInput(
                title: 'Xác nhận mật khẩu',
                controller: _.inputConfirmPass,
                err: _.listErrChange[1]),
            const SizedBox(height: 25),
            Obx(() => ButtonLoading(
                height: 35,
                width: 150,
                colors: kIndigoBlueColor900,
                sizeContent: 13,
                isLoading: _.loadingChange.value,
                titleButton: 'Gửi yêu cầu',
                onPressed: () async => await _.handleChangePass())),
            const SizedBox(height: 10)
          ],
        ),
      );
    });
  }
}
