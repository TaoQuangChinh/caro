import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/modules/change_pass/controllers/change_pass_controller.dart';
import 'package:games_caro/app/widget/button/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';
import 'package:get/get.dart';

class VerifiCodeScreen extends StatelessWidget {
  const VerifiCodeScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePassController>(builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomInput(
              title: 'mã xác thực',
              controller: _.inputVerifiCode,
              maxLength: 6,
              err: ''),
          const SizedBox(height: 5),
          Align(
              alignment: Alignment.centerLeft,
              child: Obx(() {
                if (_.loadingSendCode.value) {
                  return Row(
                    children: [
                      Text('vui lòng chờ giây lát...',
                          style: PrimaryStyle.medium(12)),
                      const SizedBox(width: 5),
                      const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                            color: kBlueColor500, strokeWidth: 2),
                      )
                    ],
                  );
                }
                return InkWell(
                  onTap: () async => await _.handleSendVerifiCode(email),
                  child: Text(
                    'nhận mã xác thực',
                    style: PrimaryStyle.medium(13, color: kBlueColor500),
                  ),
                );
              })),
          const SizedBox(height: 35),
          if (_.stringError.value.isNotEmpty) ...[
            Text(_.stringError.value,
                style: PrimaryStyle.normal(13, color: kRedColor400))
          ],
          const SizedBox(height: 5),
          Obx(() => ButtonLoading(
              height: 35,
              width: 150,
              sizeContent: 13,
              colors: kIndigoBlueColor900,
              isLoading: _.loadingSubmit.value,
              titleButton: 'XÁC NHẬN',
              onPressed: () => _.submitVerifiCode(email)))
        ],
      );
    });
  }
}
