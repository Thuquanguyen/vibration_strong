import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_app_vibrator_strong/core/common/app_func.dart';
import 'package:flutter_app_vibrator_strong/core/common/imagehelper.dart';
import 'package:flutter_app_vibrator_strong/core/theme/textstyles.dart';
import 'package:flutter_app_vibrator_strong/routes/app_pages.dart';
import 'package:flutter_app_vibrator_strong/utils/app_loading.dart';
import 'package:flutter_app_vibrator_strong/utils/app_scaffold.dart';
import 'package:flutter_app_vibrator_strong/utils/touchable.dart';
import 'package:flutter_app_vibrator_strong/widget/item_page.dart';
import 'package:get/get.dart';
import 'package:pageview_widget_indicator/pageview_widget_indicator.dart';
import '../../ad_manager.dart';
import '../../admod_handle.dart';
import '../../constants.dart';
import '../../core/assets/app_assets.dart';
import '../../core/local_storage/localStorageHelper.dart';
import '../../language/i18n.g.dart';
import 'welcome_controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarHeight: 0,
      hideAppBar: true,
      color: Colors.black54,
      body: Column(
        children: [
          Expanded(
              flex: 6,
              child: PageView.builder(
                controller: controller.controller.value,
                itemCount: 3,
                onPageChanged: (pageIndex) {
                  controller.pageIndex.value = pageIndex;
                },
                itemBuilder: (context, index) => ItemPage(
                  title: controller.listTitle[index],
                  subTitle: controller.listSubTitle[index],
                  imgCover: "assets/images/banner_${index + 1}.jpeg",
                ),
              )),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Touchable(
                  onTap: () async {
                    SharePreferencesHelper.setBool(KEY_WELCOME, true);
                    SharePreferencesHelper.setBool(KEY_LANGUAGE, true);
                    AppFunc.setTimeout(() {
                      Get.offAllNamed(Routes.MAIN);
                    }, 500);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        I18n().skipStr.tr,
                        style: TextStyles.label1
                            .setColor(Colors.white)
                            .setHeight(1),
                      ),
                    ),
                  )),
              Spacer(),
              SizedBox(
                width: 60,
                height: 20,
                child: PageViewIndicator(
                  height: 10,
                  builder: (context, index, isSelected) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(isSelected ? 1.0 : 0.2),
                      borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  pageController: controller.controller.value,
                  itemWidth: 20,
                  itemCount: 3,
                ),
              ),
              Spacer(),
              Obx(() => Touchable(
                  onTap: () async {
                    if (controller.pageIndex.value != 2) {
                      controller.controller.value.nextPage(
                          duration: Duration(milliseconds: 100),
                          curve: Curves.bounceIn);
                    } else {
                      SharePreferencesHelper.setBool(KEY_WELCOME, true);
                      SharePreferencesHelper.setBool(KEY_LANGUAGE, true);
                      AppFunc.setTimeout(() {
                        Get.offAllNamed(Routes.MAIN);
                      }, 500);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        controller.pageIndex.value != 2
                            ? I18n().nextStr.tr
                            : I18n().doneStr.tr,
                        style: TextStyles.label1
                            .setColor(Colors.white)
                            .setHeight(1),
                      ),
                    ),
                  ))),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
