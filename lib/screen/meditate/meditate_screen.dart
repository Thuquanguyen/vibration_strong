import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../ad_manager.dart';
import '../../applovin_manager.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../in_app_manage.dart';
import '../../language/i18n.g.dart';
import '../../utils/app_scaffold.dart';
import '../../widget/item_music.dart';
import 'meditate_controller.dart';
import 'package:applovin_max/applovin_max.dart';

class MeditateScreen extends GetView<MeditateController> {
  const MeditateScreen({Key? key}) : super(key: key);

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
                      I18n().meditationMusicAsmrStr.tr,
                      style: TextStyles.title1
                          .setHeight(0.1)
                          .setColor(Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        I18n().subMeditationMusicAsmrStr.tr,
                        style: TextStyles.defaultStyle
                            .setTextSize(11)
                            .setColor(Colors.grey)),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      I18n().subSubMeditationMusicAsmrStr.tr,
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
              if(!IAPConnection().isAvailable)
              Container(
                  height: 1,
                  width: Get.width,
                  color: Colors.grey.withOpacity(0.5),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
              if(!IAPConnection().isAvailable)
              MaxAdView(
                  adUnitId: AdManager.bannerAdUnitId,
                  adFormat: AdFormat.banner,
                  isAutoRefreshEnabled: false,
                  listener: AdViewAdListener(onAdLoadedCallback: (ad) {
                    ApplovinManager().logStatus(
                        'Banner widget ad loaded from ${ad.networkName}');
                  }, onAdLoadFailedCallback: (adUnitId, error) {
                    ApplovinManager().logStatus(
                        'Banner widget ad failed to load with error code ${error.code} and message: ${error.message}');
                  }, onAdClickedCallback: (ad) {
                    ApplovinManager().logStatus('Banner widget ad clicked');
                  }, onAdExpandedCallback: (ad) {
                    ApplovinManager().logStatus('Banner widget ad expanded');
                  }, onAdCollapsedCallback: (ad) {
                    ApplovinManager().logStatus('Banner widget ad collapsed');
                  }, onAdRevenuePaidCallback: (ad) {
                    ApplovinManager().logStatus(
                        'Banner widget ad revenue paid: ${ad.revenue}');
                  })),
              if(!IAPConnection().isAvailable)
              SizedBox(height: 10,)
            ],
          ),
        ));
  }
}
