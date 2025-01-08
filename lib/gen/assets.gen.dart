/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/IBMPlexSansArabic_Bold_700.ttf
  String get iBMPlexSansArabicBold700 =>
      'assets/fonts/IBMPlexSansArabic_Bold_700.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_ExtraLight_275.ttf
  String get iBMPlexSansArabicExtraLight275 =>
      'assets/fonts/IBMPlexSansArabic_ExtraLight_275.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_Light_300.ttf
  String get iBMPlexSansArabicLight300 =>
      'assets/fonts/IBMPlexSansArabic_Light_300.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_Medium_500.ttf
  String get iBMPlexSansArabicMedium500 =>
      'assets/fonts/IBMPlexSansArabic_Medium_500.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_Regular_400.ttf
  String get iBMPlexSansArabicRegular400 =>
      'assets/fonts/IBMPlexSansArabic_Regular_400.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_SemiBold_600.ttf
  String get iBMPlexSansArabicSemiBold600 =>
      'assets/fonts/IBMPlexSansArabic_SemiBold_600.ttf';

  /// File path: assets/fonts/IBMPlexSansArabic_Thin_250.ttf
  String get iBMPlexSansArabicThin250 =>
      'assets/fonts/IBMPlexSansArabic_Thin_250.ttf';

  /// List of all assets
  List<String> get values => [
        iBMPlexSansArabicBold700,
        iBMPlexSansArabicExtraLight275,
        iBMPlexSansArabicLight300,
        iBMPlexSansArabicMedium500,
        iBMPlexSansArabicRegular400,
        iBMPlexSansArabicSemiBold600,
        iBMPlexSansArabicThin250
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/Icon.png');

  /// File path: assets/images/archive.svg
  String get archive => 'assets/images/archive.svg';

  /// File path: assets/images/arrow-swap-horizontal.svg
  String get arrowSwapHorizontal => 'assets/images/arrow-swap-horizontal.svg';

  /// File path: assets/images/bell-active-alt.svg
  String get bellActiveAlt => 'assets/images/bell-active-alt.svg';

  /// File path: assets/images/book.svg
  String get book => 'assets/images/book.svg';

  /// File path: assets/images/calendar-2.svg
  String get calendar2 => 'assets/images/calendar-2.svg';

  /// File path: assets/images/calendar.svg
  String get calendar => 'assets/images/calendar.svg';

  /// File path: assets/images/calendarGreen.svg
  String get calendarGreen => 'assets/images/calendarGreen.svg';

  /// File path: assets/images/calendarUnsSelected.svg
  String get calendarUnsSelected => 'assets/images/calendarUnsSelected.svg';

  /// File path: assets/images/cardImage.png
  AssetGenImage get cardImage =>
      const AssetGenImage('assets/images/cardImage.png');

  /// File path: assets/images/document-text.svg
  String get documentText => 'assets/images/document-text.svg';

  /// File path: assets/images/eventImage.png
  AssetGenImage get eventImage =>
      const AssetGenImage('assets/images/eventImage.png');

  /// File path: assets/images/eventImage1.png
  AssetGenImage get eventImage1 =>
      const AssetGenImage('assets/images/eventImage1.png');

  /// File path: assets/images/export.svg
  String get export => 'assets/images/export.svg';

  /// File path: assets/images/gallery-slash.svg
  String get gallerySlash => 'assets/images/gallery-slash.svg';

  /// File path: assets/images/gift.svg
  String get gift => 'assets/images/gift.svg';

  /// File path: assets/images/mobile.svg
  String get mobile => 'assets/images/mobile.svg';

  /// File path: assets/images/moneys.svg
  String get moneys => 'assets/images/moneys.svg';

  /// File path: assets/images/newsPoster.png
  AssetGenImage get newsPoster =>
      const AssetGenImage('assets/images/newsPoster.png');

  /// File path: assets/images/saudiPoster.png
  AssetGenImage get saudiPoster =>
      const AssetGenImage('assets/images/saudiPoster.png');

  /// File path: assets/images/setting-2.svg
  String get setting2 => 'assets/images/setting-2.svg';

  /// File path: assets/images/share.svg
  String get share => 'assets/images/share.svg';

  /// File path: assets/images/timer.svg
  String get timer => 'assets/images/timer.svg';

  /// File path: assets/images/whatsapp.svg
  String get whatsapp => 'assets/images/whatsapp.svg';

  /// List of all assets
  List<dynamic> get values => [
        icon,
        archive,
        arrowSwapHorizontal,
        bellActiveAlt,
        book,
        calendar2,
        calendar,
        calendarGreen,
        calendarUnsSelected,
        cardImage,
        documentText,
        eventImage,
        eventImage1,
        export,
        gallerySlash,
        gift,
        mobile,
        moneys,
        newsPoster,
        saudiPoster,
        setting2,
        share,
        timer,
        whatsapp
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
