import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:get/get.dart';

class ItemBottomSheet extends StatelessWidget {
  const ItemBottomSheet(
      {Key? key,
      required this.content,
      required this.icon,
      required this.onTap,
      this.paddingVertical = 15,
      this.iconColor = kIndigoBlueColor900,
      this.textColor = kIndigoBlueColor900})
      : super(key: key);

  final Function()? onTap;
  final double paddingVertical;
  final IconData icon;
  final String content;
  final Color? iconColor, textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding:
            EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 10),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 10),
            Text(content, style: PrimaryStyle.normal(16, color: textColor))
          ],
        ),
      ),
    );
  }
}
