import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/model/user_model.dart';
import 'package:games_caro/app/routes/app_pages.dart';
import 'package:games_caro/app/widget/item/item_bottom_sheet.dart';
import 'package:get/get.dart';

class BodyBottomSheet extends StatelessWidget {
  const BodyBottomSheet(
      {Key? key, required this.removeAccount, required this.user})
      : super(key: key);

  final UserModel user;
  final Function()? removeAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 7),
        ItemBottomSheet(
            content: 'Đăng nhập',
            icon: Icons.privacy_tip,
            paddingVertical: 10,
            onTap: () {
              Get.back();
              Get.toNamed(Routes.LOGIN, parameters: {
                "email": user.email!,
                'screen': 'listAccount',
                'isHide': 'true'
              });
            }),
        ItemBottomSheet(
            content: 'Quên mật khẩu',
            icon: Icons.pin_rounded,
            onTap: () {},
            paddingVertical: 10),
        ItemBottomSheet(
            content: 'Xoá tài khoản(trên thiết bị này)',
            icon: Icons.remove_circle,
            textColor: kRedColor400,
            iconColor: kRedColor400,
            paddingVertical: 10,
            onTap: () {})
      ],
    );
  }
}
