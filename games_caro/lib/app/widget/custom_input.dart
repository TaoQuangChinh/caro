import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
      required this.controller,
      required this.err,
      this.title = '',
      this.colorTitle = kBodyText,
      this.maxLength,
      this.inputFormatters,
      this.keyboardType,
      this.obscureText = false,
      this.onPressed,
      this.icons})
      : super(key: key);

  final TextEditingController controller;
  final String title, err;
  final Color colorTitle;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icons;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PrimaryStyle.medium(14, color: colorTitle)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          style: PrimaryStyle.normal(color: kBodyText, 16),
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.visiblePassword,
          obscureText: obscureText,
          decoration: InputDecoration(
              prefixIcon: IconButton(icon: Icon(icons), onPressed: onPressed),
              counter: const SizedBox.shrink(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: kPrimaryColor, width: 1.5))),
        ),
        if (err.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child:
                Text(err, style: PrimaryStyle.normal(13, color: kRedColor400)),
          )
        ]
      ],
    );
  }
}
