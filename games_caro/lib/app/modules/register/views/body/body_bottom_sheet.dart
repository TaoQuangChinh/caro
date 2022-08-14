import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:get/get.dart';

class BodyBottomSheet extends StatelessWidget {
  const BodyBottomSheet(
      {Key? key, required this.pickerImage, required this.imageCamera})
      : super(key: key);

  final Function()? pickerImage;
  final Function()? imageCamera;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: pickerImage,
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.insert_photo, color: kIndigoBlueColor900),
                const SizedBox(width: 10),
                Text('Chọn ảnh',
                    style: PrimaryStyle.normal(16, color: kIndigoBlueColor900))
              ],
            ),
          ),
        ),
        const Divider(thickness: 1, color: kIndigoBlueColor900, height: 0),
        InkWell(
          onTap: imageCamera,
          child: Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.enhance_photo_translate,
                    color: kIndigoBlueColor900),
                const SizedBox(width: 10),
                Text('Chụp ảnh',
                    style: PrimaryStyle.normal(16, color: kIndigoBlueColor900))
              ],
            ),
          ),
        )
      ],
    );
  }
}
