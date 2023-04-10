import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_app_vibrator_strong/core/extensions/text_ext.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as image;
import 'package:image_picker/image_picker.dart';

import '../assets/app_assets.dart';
import '../theme/app_colors.dart';
import '../theme/dimens.dart';
import 'app_func.dart';
//
// class ImageProperty {
//   const ImageProperty({
//     Key? key,
//     required this.image,
//     required this.x,
//     required this.y,
//   });
//
//   final ui.Image image;
//   final int x;
//   final int y;
// }

// ignore: avoid_classes_with_only_static_members
class ImageHelper {
  static final picker = ImagePicker();

  static const double widthIcon = 18;
  static const double heightIcon = 18;

  static Widget loadFromUrl(
    String imageURL, {
    double? width,
    double? height,
    double? radius,
    BoxFit fit = BoxFit.contain,
    bool cached = true,
    Color? tintColor,
    Alignment? alignment,
  }) {
    String _imageURL = imageURL;
    if (!_imageURL.startsWith('http')) {
      _imageURL = 'https://$_imageURL';
    }
    if (!cached) {
      return Container(
        width: width,
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        child: Image.asset(
          _imageURL,
          width: width,
          height: height,
          fit: fit,
          color: tintColor,
          alignment: alignment ?? Alignment.center,
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageURL,
        width: width,
        height: height,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.shimmerImageColor,
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ).withShimmer(visible: true),
        imageBuilder: (context, imageProvider) => Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        errorWidget: (BuildContext context, String url, dynamic error) =>
            const Center(
          child: Icon(Icons.error),
        ),
      );
    }
  }

  static Widget loadFromAsset(
    String imageFilePath, {
    String? defaultImage,
    double? width,
    double? height,
    double? radius,
    BoxFit? fit,
    Color? tintColor,
    Alignment? alignment,
  }) {
    if (AppAssets.hasAsset[imageFilePath] != true) {
      if ((defaultImage ?? '').isNotEmpty &&
          defaultImage != imageFilePath &&
          AppAssets.hasAsset[defaultImage] == true) {
        return loadFromAsset(defaultImage!,
            width: width,
            height: height,
            radius: radius,
            fit: fit,
            tintColor: tintColor,
            alignment: alignment);
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: SizedBox(
          width: width,
          height: height,
        ),
      );
    }
    if (imageFilePath.toLowerCase().endsWith('svg')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: SvgPicture.asset(
          imageFilePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: tintColor,
          alignment: alignment ?? Alignment.center,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.asset(
          imageFilePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: tintColor,
          alignment: alignment ?? Alignment.center,
        ),
      );
    }
  }

  static Widget loadIconFromAsset(
    String imageFilePath, {
    double? width = 18,
    double? height = 18,
    double? radius,
    BoxFit? fit,
    Color? tintColor,
    Alignment? alignment,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Image.asset(
        imageFilePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: tintColor,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }

  static Future<Widget> loadFromCamera({
    double? width,
    double? height,
    double? radius,
    BoxFit? fit,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return const SizedBox();
    } else {
      final File _image = File(pickedFile.path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.file(
          _image,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
        ),
      );
    }
  }

  static Future<Widget> loadFromPhotos({
    double? width,
    double? height,
    double? radius,
    BoxFit? fit,
  }) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return const SizedBox();
    } else {
      final File _image = File(pickedFile.path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Image.file(
          _image,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
        ),
      );
    }
  }

  static Future<ui.Image> bytesToImage(Uint8List data) async {
    ui.Codec codec = await ui.instantiateImageCodec(data);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  static Future<ui.Image?> assetToImage(String asset) async {
    try {
      ByteData bytes = await rootBundle.load(asset);
      image.Image? baseSizeImage =
          image.decodeImage(bytes.buffer.asUint8List());
      final newWidth = Dimens.getInScreenSize(
          baseSizeImage?.width.toDouble() ?? 0,
          fitHeight: true);
      final newHeight = Dimens.getInScreenSize(
          baseSizeImage?.height.toDouble() ?? 0,
          fitHeight: true);
      if (newWidth == 0 || newHeight == 0 || baseSizeImage == null) {
        return bytesToImage(bytes.buffer.asUint8List());
      } else {
        image.Image resizeImage = image.copyResize(baseSizeImage,
            height: newHeight.toInt(), width: newWidth.toInt());
        ui.Codec codec = await ui.instantiateImageCodec(
            Uint8List.fromList(image.encodePng(resizeImage)));
        ui.FrameInfo frameInfo = await codec.getNextFrame();
        return frameInfo.image;
      }
    } catch (e) {
      Logger.error(e.toString());
    }
    return null;
  }
}
