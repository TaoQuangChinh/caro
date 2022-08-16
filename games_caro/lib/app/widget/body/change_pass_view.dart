import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/widget/custom_input.dart';
import 'package:get/get.dart';

class ChangePassView extends StatelessWidget {
  const ChangePassView(
      {Key? key,
      required this.controller,
      required this.textError,
      required this.submit,
      required this.isLoading})
      : super(key: key);

  final List<TextEditingController> controller;
  final List<String> textError;
  final Function() submit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 220,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(color: kPrimaryColor),
          const SizedBox(height: 17),
          Text('đang cập nhập thông tin....', style: PrimaryStyle.medium(18))
        ]),
      );
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
              title: 'Mật khẩu mới',
              controller: controller[0],
              err: textError[0]),
          const SizedBox(height: 17),
          CustomInput(
              title: 'Xác nhận mật khẩu',
              controller: controller[1],
              err: textError[1]),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Huỷ',
                      style:
                          PrimaryStyle.medium(18, color: kIndigoBlueColor900))),
              TextButton(
                  onPressed: submit,
                  child: Text('Thay đổi',
                      style:
                          PrimaryStyle.medium(18, color: kIndigoBlueColor900)))
            ],
          )
        ],
      ),
    );
  }
}
