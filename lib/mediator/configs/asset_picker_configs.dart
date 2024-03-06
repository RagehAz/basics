// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../configs/picker_text_delegates.dart';

class AssetPickerConfigs {
  // -----------------------------------------------------------------------------

  const AssetPickerConfigs();

  // -----------------------------------------------------------------------------

  /// PICKER CONFIG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AssetPickerConfig> configs({
    required BuildContext context,
    required int maxAssets,
    required List<AssetEntity>? selectedAssets,
    required String? langCode,
    TextStyle? textStyle,
    int gridCount = 3,
    int pageSize = 12,
    TextStyle? titleTextStyle,
    double? titleTextSpacing,
    RequestType requestType = RequestType.image,
  }) async {

    return AssetPickerConfig(

      /// ASSETS SELECTION
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,

      /// ASSETS TYPE
      requestType: requestType,

      /// GRID AND SIZING
      gridCount: gridCount,
      // gridThumbnailSize: defaultAssetGridPreviewSize,
      pageSize: pageSize,
      // pathThumbnailSize: defaultPathThumbnailSize,
      // previewThumbnailSize: ThumbnailSize.square(50),
      // shouldRevertGrid: false,

      /// THEME
      // themeColor: Colorz.yellow255, /// either use themeColor or pickerTheme
      pickerTheme: ThemeData(
        /// FONT
        fontFamily: BldrsThemeFonts.fontHead,
        /// BACKGROUND COLOR
        canvasColor: Colorz.black255,
        /// BUTTON AND CHECK COLOR : DEPRECATED
        // accentColor: Colorz.yellow255,
        /// COLOR THEME
        colorScheme: const ColorScheme(
          // ----------------------------------------------------->
          /// BRIGHTNESS
          brightness: Brightness.dark,
          /// DEVICE FOLDERS LIST BACKGROUND
          background: Colorz.black200,
          /// APP BAR BACKGROUND
          surface: Colorz.black255,
          /// BUTTON AND CHECK BACKGROUND COLOR
          secondary: Colorz.yellow255,
          /// DROPDOWN ARROW
          primary: Colorz.blue255,
          /// ERRORS
          onError: Colorz.red255,
          error: Colorz.red255,
          // errorContainer: Colorz.white50,
          // onErrorContainer: Colorz.white50,
          /// UNKNOWN
          onBackground: Colorz.nothing,
          /// primary
          onPrimary: Colorz.nothing,
          // inversePrimary: Colorz.green50,
          // primaryVariant: Colorz.white50, // deprecated on favor of primaryContainer
          // onPrimaryContainer: Colorz.green50,
          // primaryContainer: Colorz.white50,
          /// surface
          onSurface: Colorz.nothing,
          // onSurfaceVariant: Colorz.green50,
          // inverseSurface: Colorz.green50,
          // surfaceTint: Colorz.green50,
          // surfaceVariant: Colorz.green50,
          // onInverseSurface: Colorz.green50,
          /// secondary
          onSecondary: Colorz.nothing, /// LAYER ON TOP OF BACKGROUND AND BEHIND THE IMAGE
          // secondaryVariant: Colorz.white50, // deprecated on favor of secondaryContainer
          // secondaryContainer: Colorz.green50,
          // onSecondaryContainer: Colorz.green50,
          /// tertiary
          // onTertiary: Colorz.green50,
          // onTertiaryContainer: Colorz.green50,
          // tertiary: Colorz.green50,
          // tertiaryContainer: Colorz.green50,
          /// outline
          // outline: Colorz.green50,
          // outlineVariant: Colorz.green50,
          // scrim: Colorz.green50,
          // shadow: Colorz.green50,
          // ----------------------------------------------------->
        ),
        textTheme: TextTheme(
          ///DISPLAY
          displayLarge: textStyle,
          displayMedium: textStyle,
          displaySmall: textStyle,
          /// HEADLINE
          headlineLarge: textStyle,
          headlineMedium:textStyle,
          headlineSmall: textStyle,
          /// TITLE
          titleLarge: textStyle,
          titleMedium:textStyle,
          titleSmall:textStyle,
          /// BODY
          bodyLarge:textStyle,
          bodyMedium:textStyle,
          bodySmall:textStyle,
          /// LABEL
          labelLarge:textStyle,
          labelMedium:textStyle,
          labelSmall:textStyle,
          /// DEPRECATED
          // headline2: ,
          // headline1: ,
          // button: ,
          // bodyText2: ,
          // bodyText1: ,
          // caption: ,
          // headline3: ,
          // headline4: ,
          // headline5: ,
          // headline6: ,
          // overline: ,
          // subtitle1: ,
          // subtitle2: ,
        ),
        appBarTheme: AppBarTheme(
          /// BACKGROUND COLOR
          // color: Colorz.darkGrey255, // backgroundColor: Colorz.black255,
          // foregroundColor: Colorz.green255,
          // shadowColor: Colorz.bloodTest,
          centerTitle: false,
          elevation: 10,
          scrolledUnderElevation: 100,
          // shape: ,
          // surfaceTintColor: Colorz.bloodTest,
          // systemOverlayStyle: SystemUiOverlayStyle.dark,
          /// ICON
          // actionsIconTheme: ,
          // iconTheme: ,
          /// TITLE
          titleTextStyle: titleTextStyle,
          titleSpacing: titleTextSpacing,
          // textTheme: , /// deprecated in favor of titleTextStyle & toolbarTextStyle
          /// TOOL BAR
          // toolbarTextStyle: ,
          // toolbarHeight: ,
          /// DEPRECATED
          // backwardsCompatibility: ,
          // brightness: Brightness.light,
        ),
      ),
      textDelegate: getPickerTextDelegateByLangCode(langCode),
      /// SCROLLING
      // keepScrollOffset: false,
      // specialItemPosition: SpecialItemPosition.none,
      /// PERMISSION
      // limitedPermissionOverlayPredicate: (PermissionState permissionState){
      //   blog('pickMultipleImages : permissionState : $permissionState');
      //   return true;
      // },
      /// LOADING
      // loadingIndicatorBuilder: (BuildContext context, bool loading){
      //   return Loading(loading: loading);
      // },
      /// ASSET NAME
      // pathNameBuilder: (AssetPathEntity assetPathEntity){
      //   blog('assetPathEntity : $assetPathEntity');
      //   return 'Fuck you';
      // },
      // sortPathDelegate: SortPathDelegate.common,
      /// WHO THE FUCK ARE YOU
      // selectPredicate: (BuildContext xxx, AssetEntity assetEntity, bool wtf) async {
      //   blog('pickMultipleImages : ${assetEntity.id} : wtf : $wtf');
      //   return wtf;
      // },
      // specialItemBuilder: (BuildContext xyz, AssetPathEntity assetPathEntity, int number){
      //   return const SizedBox();;
      // },
      // specialPickerType: SpecialPickerType.wechatMoment,
      //
      // filterOptions: FilterOptionGroup(
      //   audioOption: const FilterOption(
      //     durationConstraint: DurationConstraint(
      //       allowNullable: false,
      //       max: const Duration(days: 1),
      //       min: Duration.zero,
      //     ),
      //     needTitle: true,
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //   ),
      //   containsEmptyAlbum: true,
      //   containsLivePhotos: true,
      //   containsPathModified: true,
      //   createTimeCond: DateTimeCond(
      //     ignore: true,
      //     min: DateTime.now(),
      //     max: DateTime.now(),
      //   ),
      //   imageOption: FilterOption(
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //     needTitle: true,
      //     durationConstraint: DurationConstraint(
      //       allowNullable: false,
      //       max: const Duration(days: 1),
      //       min: Duration.zero,
      //     ),
      //   ),
      //   onlyLivePhotos: false,
      //   orders: <OrderOption>[
      //     OrderOption(
      //       asc: false,
      //       type: OrderOptionType.createDate,
      //     ),
      //   ],
      //     updateTimeCond: DateTimeCond(
      //     ignore: true,
      //     min: 0,
      //     max: ,
      //   ),
      //   videoOption: FilterOption(
      //     sizeConstraint: SizeConstraint(
      //       maxHeight: 100000,
      //       minHeight: 0,
      //       ignoreSize: true,
      //       maxWidth: 100000,
      //       minWidth: 0,
      //     ),
      //   ),
      // ),
    );

  }
  // -----------------------------------------------------------------------------


  // -----------------------------------------------------------------------------
  void f(){}
}
