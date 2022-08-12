import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

import 'package:get/get.dart';

import '../controllers/list_account_controller.dart';

class ListAccountView extends GetView<ListAccountController> {
  const ListAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
          child: Align(
        alignment: Alignment.center,
        child: Card(
          child: Container(
            constraints: BoxConstraints(maxHeight: 450),
            width: 300,
            child: Column(
              children: [
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return item(index);
                    }),
                ElevatedButton(onPressed: () {}, child: Text("Đăng kí"))
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget item(int index) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      child: Row(
        children: [
          Image.asset('assets/images/logo_caro.png', height: 50, width: 50),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tao Quang Chinh",
                style: PrimaryStyle.bold(20),
              ),
              Text("chinhtao1908@gmail.com", style: PrimaryStyle.regular(14))
            ],
          )
        ],
      ),
    );
  }
}
