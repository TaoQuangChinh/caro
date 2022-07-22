import 'package:flutter/material.dart';
import 'package:games_caro/app/model/player.dart';
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
                    style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
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
                        side: const BorderSide(color: Colors.white, width: 2)
                      ),
                      child: const Text("OK",style: TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      )),
                      onPressed: onPressed),
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
}
