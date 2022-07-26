import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/widget/button/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  IconData showIcon(bool value) {
    if (value) {
      return Icons.visibility_off_outlined;
    }
    return Icons.visibility_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/logo.png', height: 170),
              const SizedBox(height: 10),
              Text("Spending Management",
                  style: PrimaryStyle.bold(color: kPrimaryColor, 27)),
              const SizedBox(height: 40),
              Obx(() => CustomInput(
                    controller: controller.inputEmail,
                    title: 'Tài khoản email',
                    err: controller.listErrLogin[0],
                  )),
              const SizedBox(height: 15),
              Obx(() => CustomInput(
                    controller: controller.inputPass,
                    title: 'Mật khẩu',
                    obscureText: controller.isHidePass.value,
                    icons: IconButton(
                        icon: Icon(showIcon(controller.isHidePass.value),
                            color: kPrimaryColor),
                        onPressed: () => controller
                            .isHidePass(!controller.isHidePass.value)),
                    err: controller.listErrLogin[1],
                  )),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Obx(() => Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        activeColor: kPrimaryColor,
                        value: controller.isSaveAccount.value,
                        onChanged: (value) =>
                            controller.handleSavePass(value))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: Text.rich(TextSpan(
                        text: '\tLưu tài khoản\n',
                        style: PrimaryStyle.medium(14),
                        children: [
                          TextSpan(
                              text: '(đăng nhập bằng một lần nhấn)',
                              style: PrimaryStyle.regular(12))
                        ])),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Obx(() => ButtonLoading(
                  height: 40,
                  width: 150,
                  isLoading: controller.isLoadingLogin.value,
                  titleButton: "Đăng nhập",
                  onPressed: () async => await controller.submit())),
              const SizedBox(height: 22),
              if (['listAccount', 'register']
                  .contains(Get.parameters['screen'])) ...[
                button('Đổi tài khoản', () => Get.back(),
                    iconLeft: Icons.arrow_back_ios)
              ] else ...[
                button('Đăng ký tài khoản', () => Get.toNamed(Routes.REGISTER),
                    iconRight: Icons.arrow_forward_ios)
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget button(String content, Function()? onPressed,
      {IconData? iconLeft, IconData? iconRight}) {
    return Align(
      alignment:
          iconLeft != null ? Alignment.centerLeft : Alignment.centerRight,
      child: FittedBox(
        fit: BoxFit.fill,
        child: TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                if (iconLeft != null) ...[
                  Icon(iconLeft, color: kPrimaryColor, size: 15)
                ],
                Text(content,
                    style: PrimaryStyle.normal(15, color: kPrimaryColor)),
                if (iconRight != null) ...[
                  Icon(iconRight, color: kPrimaryColor, size: 15)
                ]
              ],
            )),
      ),
    );
  }
}
