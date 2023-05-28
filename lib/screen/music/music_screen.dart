import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        // hideAppBar: true,
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: Obx(() => ListView.builder(
                    itemCount: !IAPConnection().isAvailable ? controller.listMusics.length + 1 : controller.listMusics.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      if ((index == 3) && !IAPConnection().isAvailable) {
                        return Visibility(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: controller.bannerAd.value.size.width
                                  .toDouble(),
                              height: controller.bannerAd.value.size.height
                                  .toDouble(),
                              child:
                              AdWidget(ad: controller.bannerAd.value),
                            ),
                          ),
                          visible: controller.isLoadAds.value,
                        );
                      }

                      int i = (index > 3 && !IAPConnection().isAvailable) ? (index - 1) : index;
                      return ItemMusic(
                        musicModel: controller.listMusics[i],
                        controller: controller,
                        index: index,
                      );
                    },
                  ))),
              if (!IAPConnection().isAvailable)
                Obx(() => Visibility(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: controller.bannerAdBottom.value.size.width
                          .toDouble(),
                      height: controller.bannerAdBottom.value.size.height
                          .toDouble(),
                      child: AdWidget(ad: controller.bannerAdBottom.value),
                    ),
                  ),
                  visible: controller.isLoadAdsBottom.value,
                ))
            ],
          ),
        ));
  }
}
