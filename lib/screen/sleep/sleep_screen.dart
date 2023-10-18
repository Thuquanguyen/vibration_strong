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
import 'sleep_controller.dart';

class SleepScreen extends GetView<SleepController> {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        paddingTop: 0,
        hideBackButton: true,
        appBarHeight: 0,
        hideAppBar: true,
        color: Colors.black,
        body: Column(
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
                    I18n().sleepMusicStr.tr,
                    style: TextStyles.title1
                        .setHeight(0.1)
                        .setColor(Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      I18n().subSleepMusicStr.tr,
                      style: TextStyles.defaultStyle
                          .setTextSize(11)
                          .setColor(Colors.white70)),
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
          ],
        ));
  }
}
