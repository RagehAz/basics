import 'dart:io';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'filers.dart';

extension Extra on XFile {
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  String get stringifyXFile => 'XFile(path: $path, name: $name)';
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TASK : TEST_ME_NOW
  Future<double?> readSize({
    FileSizeUnit fileSizeUnit = FileSizeUnit.megaByte,
  }) async {
    final Uint8List _bytes = await readAsBytes();
    return Filers.calculateSize(_bytes.length, fileSizeUnit);
  }
  // -----------------------------------------------------------------------------

  /// DIMENSIONS

  // --------------------
  /// TASK : TEST_ME_NOW
  Future<Dimensions?> readDimensions() async {
    final Dimensions? _dims =  await DimensionsGetter.fromXFile(
        xfile: this,
    );
    return _dims;
  }
  // -----------------------------------------------------------------------------
}

class XFilers {
  // -----------------------------------------------------------------------------

  const XFilers();

  // -----------------------------------------------------------------------------

  /// BASICS

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> _createNewEmptyFile({
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {
    XFile? _output;

    if (kIsWeb == true || fileName == null){
      return null;
    }

    else {

      /// --------------------
      /// ANDROID APP DIRECTORY
      /// /data/user/0/com.bldrs.net/app_flutter/{fileName}
      /// ANDROID TEMPORARY DIRECTORY
      /// /data/user/0/com.bldrs.net/cache/{fileName}
      /// --------------------
      /// WINDOWS APP DIRECTORY
      /// C:\Users\rageh\Documents
      /// WINDOWS TEMPORARY DIRECTORY
      /// C:\Users\rageh\AppData\Local\Temp
      /// --------------------

      final String? _filePath = await Filers.createNewFilePath(
        fileName: fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

      /// ONLY FOR WINDOWS,MAKE SURE PATH EXISTS
      if (DeviceChecker.deviceIsWindows() == true) {
        final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
          text: _filePath,
          specialCharacter: Filers.slash,
        )!;
        await Directory(_pathWithoutDocName).create(recursive: true);
      }

      if (_filePath != null) {
        _output = XFile(_filePath);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> _writeUint8ListOnFile({
    required XFile? file,
    required Uint8List? bytes,
  }) async {

    if (kIsWeb == true || file == null || bytes == null) {
      return null;
    }

    else {
      return XFile.fromData(
        bytes,
        path: file.path,
        name: file.name,
        lastModified: DateTime.now(),
        length: bytes.length,
        mimeType: file.mimeType,
        // overrides:
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// CREATORS - WRITING

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> replaceBytes({
    required XFile? file,
    required Uint8List? newBytes,
  }) async {

    if (newBytes == null){
      return file;
    }
    else {
      return _writeUint8ListOnFile(file: file, bytes: newBytes);
    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static XFile? createXFileFromFile({
    required File? file,
  }) {
    XFile? _output;

    if (file != null){

      _output = XFile(file.path);

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> createXFileFromURL({
    required String? url,
    required String? fileName
  }) async {
    XFile? _output;

    if (fileName != null && url != null){

      final Uint8List? _bytes = await Floaters.getBytesFromURL(url);

      _output = await createXFileFromBytes(
        bytes: _bytes,
        fileName: fileName,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> createXFileFromBytes({
    required Uint8List? bytes,
    required String? fileName
  }) async {
    XFile? _output;

    if (fileName != null && bytes != null){

      final XFile? _file = await _createNewEmptyFile(
        fileName: fileName,
      );

      _output = await _writeUint8ListOnFile(
        bytes: bytes,
        file: _file,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<XFile?> createXFileFromLocalAsset({
    required String? asset,
  }) async {

    final Uint8List? _bytes = await Floaters.getBytesFromLocalAsset(
      localAsset: asset,
      // width: width,
    );

    final String? _fileName = Filers.getFileNameFromFilePath(
      filePath: asset,
      withExtension: true,
    );

    return createXFileFromBytes(
      fileName: _fileName,
      bytes: _bytes,
    );

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<XFile?> createXFileFromAssetEntity({
    required AssetEntity? assetEntity,
  }) async {
    XFile? _output;

    if (assetEntity?.relativePath != null){

      _output = XFile(assetEntity!.relativePath!);

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static File? createFileFromXFile({
    required XFile? xFile,
  }){

    if (xFile?.path != null){
      return File(xFile!.path);
    }
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// DELETION

  // --------------------
  static Future<void> deleteFile(String? path) async {

    if (TextCheck.isEmpty(path) == false){



    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<bool> checkXFilesAreIdentical({
    required XFile? file1,
    required XFile? file2,
    String invoker = 'checkFilesAreIdentical',
  }) async {
      bool _identical = false;

      if (file1 == null && file2 == null){
        _identical = true;
      }

      else if (file1 != null && file2 != null){
        if (file1.path == file2.path){

            final bool _bytesAreIdentical = Floaters.checkBytesAreIdentical(
              bytes1: await file1.readAsBytes(),
              bytes2: await file2.readAsBytes(),
            );

            if (_bytesAreIdentical == true){
              _identical = true;
            }

        }
      }

      return _identical;

  }
  // -----------------------------------------------------------------------------
}
