// ignore_for_file: unnecessary_import, unused_local_variable, avoid_redundant_argument_values
import 'dart:io';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/permissions/permits_protocols.dart';
import 'package:basics/mediator/configs/asset_picker_configs.dart';
import 'package:basics/mediator/configs/camera_text_delegates.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class VideoMaker {
  // -----------------------------------------------------------------------------

  const VideoMaker();

  // -----------------------------------------------------------------------------

  /// PICKER CONFIG

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> pickVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
  }) async {

    File? _output;

    final bool _canPick = await PermitProtocol.fetchGalleryPermit(
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_canPick == true){

      List<AssetEntity>? pickedAssets = [];

      await tryAndCatch(
        invoker: '_pickMultiplePics',
        onError: onError,
        functions: () async {

          pickedAssets = await AssetPicker.pickAssets(
            context,
            // pageRouteBuilder: ,
            // useRootNavigator: true,
            pickerConfig: await AssetPickerConfigs.configs(
              requestType: RequestType.video,
              context: context,
              maxAssets: 1,
              selectedAssets: null,
              langCode: langCode,
              // titleTextStyle: ,
              // textStyle: ,
              // titleTextSpacing: ,
              // gridCount: ,
              // pageSize: ,
            ),
          );

        },
      );

      if (Lister.checkCanLoop(pickedAssets) == true){

        _output = await pickedAssets!.first.file;

        // for (final AssetEntity asset in pickedAssets!){
        //
        //   final Uint8List? _bytes = await Floaters.getBytesFromFile(await asset.file);
        //
        //   if (_bytes != null){
        //     _output.add(_bytes);
        //   }
        //
        // }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> shootCameraVideo({
    required BuildContext context,
    required String langCode,
    required Function(Permission) onPermissionPermanentlyDenied,
    required Function(String? error)? onError,
  }) async {

    if (kIsWeb == true || DeviceChecker.deviceIsWindows() == true){
      return null;
    }

    else {

      final bool _canShoot = await PermitProtocol.fetchCameraPermit(
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      if (_canShoot == true){
        AssetEntity? entity;

        await tryAndCatch(
          invoker: '_shootCameraPic',
          onError: onError,
          functions: () async {

            entity = await CameraPicker.pickFromCamera(
              context,
              pickerConfig: CameraPickerConfig(

                /// TURNS - ORIENTATION
                // cameraQuarterTurns: 1, // DEFAULT
                lockCaptureOrientation: DeviceOrientation.portraitUp, // DEFAULT

                /// AUDIO
                // enableAudio: true, // DEFAULT

                /// EXPOSURE
                // enableExposureControlOnPoint: true, // DEFAULT
                // enableSetExposure: true, // DEFAULT

                /// ZOOMING
                // enablePinchToZoom: true, // DEFAULT
                // enablePullToZoomInRecord: true, // DEFAULT

                /// PREVIEW
                // enableScaledPreview: true, // DEFAULT
                // shouldAutoPreviewVideo: false, // DEFAULT
                // shouldDeletePreviewFile: false, // DEFAULT

                /// VIDEO
                enableRecording: true,
                enableTapRecording: true,
                onlyEnableRecording: true,
                maximumRecordingDuration: const Duration(seconds: 10), // DEFAULT

                /// FORMAT
                imageFormatGroup: DeviceChecker.deviceIsIOS() == true ? ImageFormatGroup.bgra8888 : ImageFormatGroup.jpeg, // DEFAULT
                // resolutionPreset: ResolutionPreset.max, // DEFAULT

                /// CAMERA
                // preferredLensDirection: CameraLensDirection.back, // DEFAULT

                /// THEME - TEXTS
                textDelegate: getCameraTextDelegateByLangCode(langCode),
                // theme: ThemeData.dark(),

                // onError: (Object object, StackTrace trace){
                //   blog('onError : $object : trace : $trace');
                // },
                //
                // foregroundBuilder: (BuildContext ctx, CameraController cameraController){
                //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController?.cameraId}');
                //   return Container();
                // },
                //
                // onEntitySaving: (BuildContext xxx, CameraPickerViewType cameraPickerViewType, File file) async {
                //   blog('onEntitySaving : cameraPickerViewType : ${cameraPickerViewType.name} : file : ${file.path}');
                // },
                //
                // onXFileCaptured: (XFile xFile, CameraPickerViewType cameraPickerViewType){
                //   blog('onXFileCaptured : cameraPickerViewType : ${cameraPickerViewType.name} : xFile : ${xFile.path}');
                //   return true;
                // },
                //
                // previewTransformBuilder: (BuildContext xyz, CameraController cameraController, Widget widget){
                //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController.cameraId}');
                //   return Container();
                // },

              ),
            );

          },
        );

        if (entity == null){
          return null;
        }

        else {
          final File? _file = await entity!.file;
          // final Uint8List? _bytes = await Floaters.getBytesFromFile(_file);
          return _file;
        }

      }

      else {
        return null;
      }

    }

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
