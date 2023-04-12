import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/utils/app_scaffold.dart';
import 'package:get/get.dart';

import '../../widget/item_music.dart';
import 'music_controller.dart';

class MusicScreen extends GetView<MusicController> {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        paddingTop: 0,
        hideBackButton: true,
        body: Container(
          color: Colors.white,
          child: Obx(() => ListView.builder(
                itemCount: controller.listMusics.length,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return ItemMusic(
                    musicModel: controller.listMusics[index],
                    controller: controller,
                    index: index,
                  );
                },
              )),
        ));
  }
}
