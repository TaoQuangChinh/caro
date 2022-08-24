import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:games_caro/app/common/config.dart';
import 'package:games_caro/app/common/primary_style.dart';
import 'package:games_caro/app/modules/login/controllers/list_account_controller.dart';
import 'package:games_caro/app/widget/image/custom_image_default.dart';
import 'package:games_caro/app/widget/image/custom_image_loading.dart';
import 'package:get/get.dart';

class BodyListAccount extends StatelessWidget {
  const BodyListAccount({Key? key}) : super(key: key);

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
    return GetX<ListAccountController>(builder: (_) {
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
                      onTap: () => _.showBottomSheet(_.listAccount[index]),
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
                              CustomImageDefault(
                                  content: _.listAccount[index].userName![0])
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
                                    CustomImageLoading(animation: _.animation),
                                errorWidget: (context, url, error) =>
                                    const CustomImageDefault(
                                        content: "null",
                                        backgroundColor: kRedColor400),
                              )
                            ],
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _.listAccount[index].userName!,
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
    });
  }
}
