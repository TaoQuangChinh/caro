import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';

import 'package:get/get.dart';

import '../controllers/list_account_controller.dart';

class ListAccountView extends GetView<ListAccountController> {
  const ListAccountView({Key? key}) : super(key: key);

  BorderSide getBorder(List<int> index) {
    if (index[0] != index[1]) {
      return const BorderSide(width: 0.5, color: kBodyText);
    }
    return BorderSide.none;
  }

  double getPadding(List<int> index) {
    if (index[0] != index[1]) {
      return 10;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: GetBuilder<ListAccountController>(builder: (_) {
        if (_.isLoading.value) {
          return const Center(
              child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: Colors.white)));
        }
        return Center(
          child: SingleChildScrollView(
              child: Align(
            alignment: Alignment.center,
            child: Card(
              elevation: 10,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 450),
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _.listAccount.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: getBorder(
                                      [index + 1, _.listAccount.length]))),
                          padding: EdgeInsets.only(
                              left: 10,
                              bottom:
                                  getPadding([index + 1, _.listAccount.length]),
                              top: getPadding([index, 0])),
                          child: Row(
                            children: [
                              if (_.listAccount[index].images == null) ...[
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    backgroundColor: kBlackColor900,
                                    radius: 80,
                                    child: Text(
                                        _.listAccount[index].nameGame![0]
                                            .toUpperCase(),
                                        style: PrimaryStyle.bold(20,
                                            color: Colors.white)),
                                  ),
                                )
                              ],
                              if (_.listAccount[index].images != null) ...[
                                CachedNetworkImage(
                                  imageUrl: _.listAccount[index].images!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CupertinoActivityIndicator(
                                          color: kIndigoBlueColor900,
                                          radius: 16),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              ],
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _.listAccount[index].nameGame!,
                                    style: PrimaryStyle.bold(20),
                                  ),
                                  Text(_.listAccount[index].email!,
                                      style: PrimaryStyle.regular(14))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )),
        );
      }),
    );
  }
}
