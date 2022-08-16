import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:get/get.dart';

class Utils {
  static void showMessage(
      {Color color = Colors.white,
      int duration = 0,
      String text = "",
      AlignmentGeometry alignment = Alignment.center,
      TextAlign textAlign = TextAlign.center,
      Function()? onPressed}) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Column(children: [
              Align(
                alignment: alignment,
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: textAlign),
              ),
              if (duration == 0) ...[
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 15),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(100, 45),
                          side:
                              const BorderSide(color: Colors.white, width: 2)),
                      onPressed: onPressed,
                      child: const Text("OK",
                          style: TextStyle(fontSize: 14, color: Colors.white))),
                )
              ]
            ]),
            titlePadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            content: SizedBox(width: Get.width),
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            backgroundColor: color,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
          );
        });

    //sau 1s dialog tự động tắt
    if (duration != 0) {
      Future.delayed(Duration(milliseconds: duration), () {
        Get.back();
      });
    }
  }

  static void showDialogDefault({required Widget body, Function()? onPressed}) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: body,
            contentPadding:
                const EdgeInsets.only(bottom: 5, top: 23, left: 20, right: 20),
            actionsPadding: EdgeInsets.zero,
          );
        });
  }
}
