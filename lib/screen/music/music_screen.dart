import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../in_app_manage.dart';
import '../../utils/app_scaffold.dart';
import '../../widget/item_music.dart';
import 'music_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MusicScreen extends GetView<MusicController> {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        paddingTop: 0,
        hideBackButton: true,
        appBarHeight: 0,
        hideAppBar: true,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
                SizedBox(
                  height: Dimens.topSafeAreaPadding,
                ),
              if (!IAPConnection().isAvailable)
                Obx(() => Visibility(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: controller.bannerAd.value.size.width.toDouble(),
                      height:
                      controller.bannerAd.value.size.height.toDouble(),
                      child: AdWidget(ad: controller.bannerAd.value),
                    ),
                  ),
                  visible: controller.isLoadAds.value,
                )),
              if (!IAPConnection().isAvailable)
                SizedBox(
                  height: 5.h,
                ),
              Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Soundscapes",
                      style: TextStyles.title1
                          .setHeight(0.1)
                          .setColor(Colors.black),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("The environment expressed through sound.",
                        style: TextStyles.defaultStyle
                            .setTextSize(11)
                            .setColor(Colors.grey)),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Out in nature",
                      style: TextStyles.body3
                          .setHeight(0.7)
                          .setColor(Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Obx(() => MasonryGridView.count(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        itemBuilder: (ctx, index) => ItemMusic(
                          musicModel: controller.listMusics[index],
                          controller: controller,
                          index: index,
                        ),
                        itemCount: controller.listMusics.length,
                        crossAxisCount: 2,
                      ))),
            ],
          ),
        ));
  }
}
