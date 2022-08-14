import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/utils/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 100),
                handleShowImage(_),
                const SizedBox(height: 10),
                Text("Register Account",
                    style: PrimaryStyle.bold(color: kPrimaryColor, 35)),
                const SizedBox(height: 40),
                CustomInput(
                  controller: _.inputNameGame,
                  title: 'Tên người chơi',
                  err: _.listError[0],
                ),
                const SizedBox(height: 15),
                CustomInput(
                  controller: _.inputEmail,
                  title: 'Tài khoản email',
                  err: _.listError[1],
                ),
                const SizedBox(height: 40),
                ButtonLoading(
                    height: 40,
                    width: 150,
                    style: PrimaryStyle.medium(16),
                    isLoading: _.isLoading.value,
                    titleButton: "Đăng ký",
                    onPressed: () async => await _.submit()),
                const SizedBox(height: 20)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget handleShowImage(RegisterController controller) {
    return FutureBuilder<void>(
        future: controller.retrieveLostData(),
        builder: (context, snapshort) {
          switch (snapshort.connectionState) {
            case ConnectionState.none:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.waiting:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.done:
              final fileImage = controller.fileImage.value.path;
              return InkWell(
                onTap: () => controller.showModalSheet(),
                child: CircleAvatar(
                  foregroundImage: fileImage != ''
                      ? Image.file(controller.fileImage.value, height: 170)
                          .image
                      : null,
                  radius: 80,
                  backgroundColor: kGreyColor400,
                  child: fileImage == ''
                      ? const Icon(Icons.add_a_photo,
                          color: Colors.black, size: 50)
                      : const SizedBox.shrink(),
                ),
              );
            default:
              if (snapshort.hasError) {
                return Text("Pick image/image error: ${snapshort.error}",
                    style: PrimaryStyle.bold(color: kRedColor400, 16));
              } else {
                return const CircularProgressIndicator(color: kPrimaryColor);
              }
          }
        });
  }
}
