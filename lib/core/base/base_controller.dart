import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final RxBool isLoading = false.obs;
  bool isConflict = false;
  RxBool isEdit = false.obs;

  @override
  void onInit() {
    ever(isLoading, (callback) {
      if (isLoading.value) {
        EasyLoading.show(
            indicator: Platform.isAndroid
                ? const CircularProgressIndicator(
                    color: Colors.red,
                  )
                : const CupertinoActivityIndicator(color: Colors.red));
      } else {
        EasyLoading.dismiss();
      }
    });
    super.onInit();
  }

}
