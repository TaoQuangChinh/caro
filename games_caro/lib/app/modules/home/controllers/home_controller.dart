import 'package:flutter/material.dart';
import 'package:games_caro/app/model/player.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class HomeController extends GetxController {
  final listData = <List<String>>[].obs;
  final listColor = [].obs;
  final count = 16.obs;
  final changeValue = ''.obs;
  final isSuccess = ''.obs;
  final listCount = <int>[0,0,0,0];

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initData() {
    handleClearData();
    update();
  }

  void showData(int position, int index) {
    if (listData[position][index].isEmpty) {
      final result = changeValue.value == Player.X ? Player.O : Player.X;
      changeValue.value = result;
      listData[position][index] = result;
      getBoxColor(position, index);

      if (handleWinner(position, index)) {
        showMessagePopup(getColorsBackGround, "Player ${changeValue.value} won!");
      } else if (handleEnd()) {
        showMessagePopup(Color(0xffffff9800), "The game is tied!!");
      }
      update();
    }
  }

  void showMessagePopup(Color color, String content){
    Utils.showMessage(
        text: content,
        color: color,
        alignment: Alignment.centerLeft,
        onPressed: (){
          //handleClearData();
          Get.back();
        }
    );
  }

  void getBoxColor(int position, int index) {
    if (changeValue.value == Player.O) {
      listColor[position][index] = Colors.blue;
    } else if (changeValue.value == Player.X) {
      listColor[position][index] = Colors.redAccent;
    }
    update();
  }

  bool handleWinner(int position, int index) {
    var result = 0, count = position;
    final player = listData[position][index];

    while(listData[count][index] == player){
      result ++;
      count++;
    }

    if (position != 0) {
      count = position - 1;
      while (listData[count][index] == player) {
        result++;
        count--;
      }
    }

    // for (int i = 0; i < count.value; i++) {
    //   final j = i == 0 ? 0 : i-1;
    //
    //   //Row cùng giá trị
    //   if (listData[position][i] == player && listData[position][i] == listData[position][j]) count1++;
    //
    //   //Column cùng giá trị
    //   if (listData[i][index] == player && listData[i][index] == listData[j][index]) count2++;
    //
    //   //Chéo từ trái sang phải cùng giá trị
    //     for(int a = 0; a < count.value; a++){
    //       final h = a == (count.value - 1) ? count.value - 1 : a+1;
    //       final k = i == 0 ? a : h;
    //       //Note: Hàng đầu tiên và cột cuối cùng đáp ứng điều kiện mà count3 = 1 --> count3 + 1
    //       if (listData[i][k] == player && listData[i][k] == listData[j][h-1]){
    //         count3++;
    //         //Note: Do hàng đầu tiên và cột cuối cùng đáp ứng điều kiện --> count3 - 1
    //         if(i == 0 || a == count.value - 1) count3 = count3 - 1;
    //       }
    //     }
    //
    //   //Chéo từ phải sang trái cùng giá trị
    //   for(int b = 15; b < count.value && b >= 0; b--){
    //     final h = b == 0 ? 0 : b - 1;
    //     if (listData[i][h] == player && listData[i][h] == listData[j][h+1]){
    //       count4++;
    //       if(i == 0 || b == 0) count4 = count4 - 1;
    //     }
    //   }
    // }
    return [result].contains(5);
  }

  // bool handleWinner(int position, int index) {
  //   int result = 0, k = position, h;
  //   final player = listData[position][index];
  //
  //   // kiểm tra hàng
  //   print("kOld: $k");
  //   while (listData[k][index] == player) {
  //     result++;
  //     k++;
  //   }
  //   print("d1: $result");
  //   k = position - 1;
  //   while (listData[k][index] == player) {
  //     result++;
  //     k--;
  //   }
  //   print("d2: $result");
  //   print("kNew: $k");
  //   print("*----------*");
  //   return [result].contains(5);
  // }

  bool handleEnd() =>
      listData.every((values) => values.every((value) => value != ''));

  void handleClearData() {
    isSuccess.value = '';
    changeValue.value = '';
    listData.value = List.generate(
        count.value, (_) => List.generate(count.value, (_) => ""));
    listColor.value = List.generate(
        count.value, (_) => List.generate(count.value, (_) => Colors.white));
    update();
  }

  Color get getColorsBackGround {
    if (changeValue.value == Player.O) {
      return Color(0xffff03a9f4);
    }
    return Color(0xffffef5350);
  }
}
