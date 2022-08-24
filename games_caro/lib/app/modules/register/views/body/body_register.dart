import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/modules/register/controllers/register_controller.dart';
import 'package:games_caro/app/widget/button/button_loading.dart';
import 'package:games_caro/app/widget/custom_input.dart';
import 'package:get/get.dart';

class BodyRegister extends StatelessWidget {
  const BodyRegister({Key? key, required this.controller}) : super(key: key);

  final RegisterController controller;

  Widget showImage() {
    return Obx(() {
      if (controller.isLoadImage.value) {
        return const CircularProgressIndicator(color: kPrimaryColor);
      }
      return handleImagePicker(controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            showImage(),
            const SizedBox(height: 30),
            Obx(() => CustomInput(
                  controller: controller.inputCode,
                  title: 'Căn cước/chứng minh thư',
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  err: controller.listError[0],
                )),
            const SizedBox(height: 10),
            CustomInput(
              readOnly: true,
              controller: controller.inputEmail,
              hintText: 'tên người dùng',
              title: '',
              err: '',
            ),
            const SizedBox(height: 15),
            Obx(() => CustomInput(
                  controller: controller.inputEmail,
                  title: 'Tài khoản email',
                  err: controller.listError[1],
                )),
            const SizedBox(height: 15),
            Text(
                "Lưu ý: trường 'Tên người chơi' chỉ được nhập chữ thường, chữ hoa và số.",
                style: PrimaryStyle.medium(12, color: kIndigoBlueColor900)),
            const SizedBox(height: 40),
            Obx(() => ButtonLoading(
                height: 40,
                width: 150,
                isLoading: controller.isLoading.value,
                titleButton: "Đăng ký",
                onPressed: () async => await controller.submit())),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.fill,
                child: TextButton(
                    onPressed: () => Get.back(),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios,
                            color: kPrimaryColor, size: 15),
                        Text('Đăng nhập',
                            style:
                                PrimaryStyle.normal(15, color: kPrimaryColor))
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget handleImagePicker(RegisterController controller) {
    return FutureBuilder<void>(
        future: controller.retrieveLostData(),
        builder: (context, snapshort) {
          switch (snapshort.connectionState) {
            case ConnectionState.none:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.waiting:
              return const CircularProgressIndicator(color: kPrimaryColor);
            case ConnectionState.done:
              return showImagePicker();
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

  Widget showImagePicker() {
    return GestureDetector(
      onTap: () => controller.showModalSheet(),
      child: Obx(() => CircleAvatar(
            foregroundImage: controller.fileImage.value.path != ''
                ? Image.file(controller.fileImage.value, height: 170).image
                : null,
            radius: 80,
            backgroundColor: kGreyColor400,
            child: controller.fileImage.value.path == ''
                ? const Icon(Icons.add_a_photo, color: Colors.black, size: 50)
                : const SizedBox.shrink(),
          )),
    );
  }
}
