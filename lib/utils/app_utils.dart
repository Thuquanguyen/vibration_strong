import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;
import 'package:flutter/services.dart';

import '../core/common/data_holder.dart';
import '../screen/main/main_controller.dart';

enum MealType { BREAKFAST, LUNCH, DINNER, SNACK }

extension MealTypeExt on MealType {
  String getMealSearchTitle() {
    switch (this) {
      case MealType.BREAKFAST:
        return '朝食を記録する';
      case MealType.LUNCH:
        return '昼食を記録する';
      case MealType.SNACK:
        return '間食を記録する';
      case MealType.DINNER:
        return '夕食を記録する';
      default:
        return '';
    }
  }

  String getMealChooseTitle() {
    switch (this) {
      case MealType.BREAKFAST:
        return '朝食';
      case MealType.LUNCH:
        return '昼食';
      case MealType.SNACK:
        return '間食';
      case MealType.DINNER:
        return '夕食';
      default:
        return '';
    }
  }

  String getHistoryTitle() {
    switch (this) {
      case MealType.BREAKFAST:
        return '朝食の履歴';
      case MealType.LUNCH:
        return '昼食の履歴';
      case MealType.SNACK:
        return '間食の履歴';
      case MealType.DINNER:
        return '夕食の履歴';
      default:
        return '';
    }
  }

  String getConfirmTitle() {
    switch (this) {
      case MealType.BREAKFAST:
        return '朝食';
      case MealType.LUNCH:
        return '昼食';
      case MealType.SNACK:
        return '間食';
      case MealType.DINNER:
        return '夕食';
      default:
        return '';
    }
  }
}

String getMealType(int index) {
  switch (index) {
    case 0:
      return MealType.BREAKFAST.name;
    case 1:
      return MealType.LUNCH.name;
    case 2:
      return MealType.DINNER.name;
    case 3:
      return MealType.SNACK.name;
    default:
      return MealType.BREAKFAST.name;
  }
}

MealType getMealTypeFromIndex(int index) {
  switch (index) {
    case 0:
      return MealType.BREAKFAST;
    case 1:
      return MealType.LUNCH;
    case 2:
      return MealType.SNACK;
    case 3:
      return MealType.DINNER;
    default:
      return MealType.BREAKFAST;
  }
}

Future<ui.Image> getUiImage(String imageAssetPath, int height, int width) async {
  final ByteData assetImageByteData = await rootBundle.load(imageAssetPath);
  final codec = await ui.instantiateImageCodec(
    assetImageByteData.buffer.asUint8List(),
    targetHeight: height,
    targetWidth: width,
  );
  final image = (await codec.getNextFrame()).image;

  return image;
}

bool checkFormat(String regex, String checkedString) {
  return RegExp(regex).hasMatch(checkedString);
}

String convertTimeStringFromDatetime(DateTime date,
    {String format = 'dd/MM/yyyy'}) {
  return DateFormat(format).format(date);
}

String formatDateToBE(DateTime dateTime){
  return DateFormat('yyyy-MM-dd\'T\'HH:mm:ss\'.000Z\'').format(dateTime.subtract(const Duration(hours: 9)));
}
String getWeekDay(int weekDay) {
  switch (weekDay) {
    case 7:
      return '日';
    case 1:
      return '月';
    case 2:
      return '火';
    case 3:
      return '水';
    case 4:
      return '木';
    case 5:
      return '金';
    case 6:
      return '土';
    default:
      return '日';
  }
}

Future<dynamic> goToScreen(Widget screen,
    {dynamic arguments, bool preventDuplicates = true}) async {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  if (arguments != null) {
    DataHolder().args = arguments;
  }
  return Get.to(() => screen,
      id: id, arguments: arguments, preventDuplicates: preventDuplicates);
}

Future<dynamic> replaceScreen(Widget screen,
    {dynamic arguments, bool preventDuplicates = true}) async {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  if (arguments != null) {
    DataHolder().args = arguments;
  }
  return Get.off(() => screen,
      id: id ?? 1, arguments: arguments, preventDuplicates: preventDuplicates);
}

void popScreen({dynamic result}) {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  Get.back(id: id ?? 1, result: result);
}

void popUntilScreen(String routeName) {
  int? id = Get.find<MainController>().currentScreenModel.navKey;
  Get.offNamedUntil(routeName, (Route<dynamic> route) => false, id: id ?? 1);
}

DateTime getStartDayOfWeek(DateTime date) {
  DateTime tmp = date.subtract(
    Duration(days: date.weekday - 1),
  );
  return DateTime(tmp.year, tmp.month, tmp.day);
}

DateTime getEndDayOfWeek(DateTime date) {
  DateTime tmp = date.add(
    Duration(days: DateTime.daysPerWeek - date.weekday),
  );
  return DateTime(tmp.year, tmp.month, tmp.day);
}


const avatarDefault = """"<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink">
<desc>Fluttermoji on pub.dev</desc>
<defs>
<circle id="path-1" cx="120" cy="120" r="120"></circle>
<path d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z" id="path-3"></path>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>
</defs>
<g id="Fluttermoji" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
<g transform="translate(-825.000000, -1100.000000)" id="Fluttermoji/Circle">
<g transform="translate(825.000000, 1100.000000)"><g id="Mask"></g>
<g id="Fluttermoji" stroke-width="1" fill-rule="evenodd">
<g id="Body" transform="translate(32.000000, 36.000000)">

<mask id="mask-6" fill="white">
<use xlink:href="#path-5"></use>
</mask>
<use fill="#D0C6AC" xlink:href="#path-5"></use>  <g id="Skin/White" mask="url(#mask-6)" fill="#FFDBB4">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>  <path d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z" id="Neck-Shadow" opacity="0.100000001" fill="#000000" mask="url(#mask-6)"></path></g><g id="Clothing/Shirt-Crew-Neck" transform="translate(0.000000, 170.000000)">
						<defs>
							<path d="M165.960472,29.2949161 C202.936473,32.3249982 232,63.2942856 232,101.051724 L232,110 L32,110 L32,101.051724 C32,62.9525631 61.591985,31.7649812 99.0454063,29.2195264 C99.0152598,29.5931145 99,29.9692272 99,30.3476251 C99,42.2107177 113.998461,51.8276544 132.5,51.8276544 C151.001539,51.8276544 166,42.2107177 166,30.3476251 C166,29.9946691 165.986723,29.6437014 165.960472,29.2949161 Z" id="react-path-36269"></path>
						</defs>
						<mask id="react-mask-36270" fill="white">
							<use xlink:href="#react-path-36269"></use>
						</mask>
						<use id="Clothes" fill="#E6E6E6" fill-rule="evenodd" xlink:href="#react-path-36269"></use>
						<g id="Color/Palette/Gray-01" mask="url(#react-mask-36270)" fill-rule="evenodd" fill="#25557C">
							<rect id="🖍Color" x="0" y="0" width="264" height="110"></rect>
						</g>
						<g id="Shadowy" opacity="0.599999964" stroke-width="1" fill-rule="evenodd" mask="url(#react-mask-36270)" fill-opacity="0.16" fill="#000000">
							<g transform="translate(92.000000, 4.000000)" id="Hola">
								<ellipse cx="40.5" cy="27.8476251" rx="39.6351047" ry="26.9138272"></ellipse>
							</g>
						</g>
					</g>
        <g id="Face" transform="translate(76.000000, 82.000000)" fill="#000000"><g id="Mouth/Smile" transform="translate(2.000000, 52.000000)">
							<defs>
								<path d="M35.117844,15.1280772 C36.1757121,24.6198025 44.2259873,32 54,32 C63.8042055,32 71.8740075,24.574136 72.8917593,15.0400546 C72.9736685,14.272746 72.1167429,13 71.042767,13 C56.1487536,13 44.7379213,13 37.0868244,13 C36.0066168,13 35.0120058,14.1784435 35.117844,15.1280772 Z" id="react-path-17111"></path>
							</defs>
							<mask id="react-mask-17112" fill="white">
								<use xlink:href="#react-path-17111"></use>
							</mask>
							<use id="Mouth" fill-opacity="0.699999988" fill="#000000" fill-rule="evenodd" xlink:href="#react-path-17111"></use>
							<rect id="Teeth" fill="#FFFFFF" fill-rule="evenodd" mask="url(#react-mask-17112)" x="39" y="2" width="31" height="16" rx="5"></rect>
							<g id="Tongue" stroke-width="1" fill-rule="evenodd" mask="url(#react-mask-17112)" fill="#FF4F6D">
								<g transform="translate(38.000000, 24.000000)">
									<circle cx="11" cy="11" r="11"></circle>
									<circle cx="21" cy="11" r="11"></circle>
								</g>
							</g>
						</g>
                  <g id="Nose/Default" transform="translate(28.000000, 40.000000)" opacity="0.16">
							<path d="M16,8 C16,12.418278 21.372583,16 28,16 L28,16 C34.627417,16 40,12.418278 40,8" id="Nose"></path>
						</g>
    <g
        id='Eyes/Default-😀'
        transform='translate(0.000000, 8.000000)'
        fillOpacity='0.599999964'>
        <circle id='Eye' cx='30' cy='22' r='6' />
        <circle id='Eye' cx='82' cy='22' r='6' />
      </g>
    <g id='Eyebrow/Outline/Default' fillOpacity='0.599999964'>
        <g id='I-Browse' transform='translate(12.000000, 6.000000)'>
          <path
            d='M3.63024536,11.1585767 C7.54515501,5.64986673 18.2779197,2.56083721 27.5230268,4.83118046 C28.5957248,5.0946055 29.6788665,4.43856013 29.9422916,3.36586212 C30.2057166,2.2931641 29.5496712,1.21002236 28.4769732,0.94659732 C17.7403633,-1.69001789 5.31209962,1.88699832 0.369754639,8.84142326 C-0.270109626,9.74178291 -0.0589363917,10.9903811 0.84142326,11.6302454 C1.74178291,12.2701096 2.9903811,12.0589364 3.63024536,11.1585767 Z'
            id='Eyebrow'
            fillRule='nonzero'
          />
          <path
            d='M61.6302454,11.1585767 C65.545155,5.64986673 76.2779197,2.56083721 85.5230268,4.83118046 C86.5957248,5.0946055 87.6788665,4.43856013 87.9422916,3.36586212 C88.2057166,2.2931641 87.5496712,1.21002236 86.4769732,0.94659732 C75.7403633,-1.69001789 63.3120996,1.88699832 58.3697546,8.84142326 C57.7298904,9.74178291 57.9410636,10.9903811 58.8414233,11.6302454 C59.7417829,12.2701096 60.9903811,12.0589364 61.6302454,11.1585767 Z'
            id='Eyebrow'
            fillRule='nonzero'
            transform='translate(73.000154, 6.039198) scale(-1, 1) translate(-73.000154, -6.039198) '
          />
        </g>
      </g>
          <g></g>
        </g><g id="Top" stroke-width="1" fill-rule="evenodd">
						<defs>
							<rect id="react-path-86260" x="0" y="0" width="264" height="280"></rect>
							<filter x="-0.8%" y="-2.0%" width="101.5%" height="108.0%" filterUnits="objectBoundingBox" id="react-filter-86258">
								<feOffset dx="0" dy="2" in="SourceAlpha" result="shadowOffsetOuter1"></feOffset>
								<feColorMatrix values="0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.16 0" type="matrix" in="shadowOffsetOuter1" result="shadowMatrixOuter1"></feColorMatrix>
								<feMerge>
									<feMergeNode in="shadowMatrixOuter1"></feMergeNode>
									<feMergeNode in="SourceGraphic"></feMergeNode>
								</feMerge>
							</filter>
						</defs>
						<mask id="react-mask-86259" fill="white">
							<use xlink:href="#react-path-86260"></use>
						</mask>
						<g id="Mask"></g>
						<g id="Top/No-Hair" mask="url(#react-mask-86259)">
							<g transform="translate(-1.000000, 0.000000)"></g>
						</g>
					</g>
</g></g></g></g></svg>, medicalExpense: null}}""";