import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/language/i18n.g.dart';
import 'package:get/get.dart';
import '../../utils/app_scaffold.dart';
import 'information_controller.dart';

class InformationScreen extends GetView<InformationController> {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: I18n().informationStr.tr,
      paddingTop: 0,
      safeArea: true,
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Image.asset("assets/images/ic_app.png"),
              title: Text(
                "Phone Vibration Strong",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Email: support.vibration@gmail.com"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "     ${I18n().applicationInformationStr.tr}",
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(I18n().contentApplicationInformationStr.tr),
            )),

          ],
        ),
      ),
    );
  }
}
