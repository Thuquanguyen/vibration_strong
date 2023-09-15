import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../core/theme/dimens.dart';
import '../../core/theme/textstyles.dart';
import '../../in_app_manage.dart';
import '../../vibrator_manage.dart';
import '../../language/i18n.g.dart';
import '../../utils/app_scaffold.dart';
import '../../widget/item_music_list.dart';
import 'music_controller.dart';

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
          color: Colors.black,
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
                      I18n().soundscapesStr.tr,
                      style: TextStyles.title1
                          .setHeight(0.1)
                          .setColor(Colors.white),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(I18n().subSoundscapesStr.tr,
                        style: TextStyles.defaultStyle
                            .setTextSize(11)
                            .setColor(Colors.white70)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      I18n().subSubSoundscapesStr.tr,
                      style: TextStyles.body3
                          .setHeight(0.7)
                          .setColor(Colors.white70),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Obx(() => ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (ctx, index) => ItemMusicList(
                      musicModel: controller.listMusics[index],
                      controller: controller,
                      index: index,
                    ),
                    itemCount: controller.listMusics.length,
                  ))),
              if (AdmodHandle().ads.isLimit == false && !IAPConnection().isAvailable)
                Container(
                    height: 1,
                    width: Get.width,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
              if (AdmodHandle().ads.isLimit == false && !IAPConnection().isAvailable)
                Obx(() => Visibility(
                      visible: AdmodHandle().isLoadedBanner.value,
                      child: SizedBox(
                        width: AdmodHandle().bannerAd!.size.width.toDouble(),
                        height: AdmodHandle().bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: AdmodHandle().bannerAd!),
                      ),
                    )),
              if (AdmodHandle().ads.isLimit == false && !IAPConnection().isAvailable)
                const SizedBox(
                  height: 10,
                )
            ],
          ),
        ));
  }
}
