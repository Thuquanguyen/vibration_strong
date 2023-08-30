import 'package:flutter/material.dart';

import '../core/common/imagehelper.dart';
import '../core/theme/textstyles.dart';
import 'package:get/get.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({this.title, this.subTitle, this.imgCover});

  final String? title;
  final String? subTitle;
  final String? imgCover;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageHelper.loadFromAsset(imgCover ?? '"assets/images/banner_1.jpeg"',
            height: 800, fit: BoxFit.cover),
        Positioned(
          bottom: 0,
          child: Container(
            width: Get.width,
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: <Color>[
                  Colors.black,
                  Colors.black54,
                  Colors.black12
                ])),
          ),
        ),
        Positioned(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  style:
                      TextStyles.title1.setColor(Colors.white).setHeight(1.2),
                ),
                Text(
                  subTitle ?? '',
                  style: TextStyles.body1.setColor(Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          bottom: 20,
        )
      ],
    );
  }
}
