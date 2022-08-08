import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.controller,
      this.title = '',
      this.colorTitle = kBodyText})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final Color colorTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PrimaryStyle.medium(18, color: colorTitle)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: PrimaryStyle.medium(color: kBodyText, 16),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.5))),
        )
      ],
    );
  }
}
