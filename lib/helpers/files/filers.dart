import 'dart:convert';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/nums/numeric.dart';
import 'package:basics/helpers/permissions/permits.dart';
import 'package:basics/helpers/rest/rest.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Filers {
  // -----------------------------------------------------------------------------

  const Filers();

  // -----------------------------------------------------------------------------

  /// CREATORS - WRITING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> createNewEmptyFile({
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {
    File? _output;

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

      final String? _filePath = await createNewFilePath(
        fileName: fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

      /// ONLY FOR WINDOWS,MAKE SURE PATH EXISTS
      if (Platform.isWindows == true) {
        final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(
            text: _filePath,
            specialCharacter: _slash,
        )!;
        await Directory(_pathWithoutDocName).create(recursive: true);
      }

      if (_filePath != null) {
        _output = File(_filePath);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> writeUint8ListOnFile({
    required File? file,
    required Uint8List? uint8list,
  }) async {

    if (kIsWeb == true || file == null || uint8list == null) {
      return null;
    }

    else {
      await file.writeAsBytes(uint8list);
      await file.create(recursive: true);
      return file;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> writeBytesOnFile({
    required File? file,
    required ByteData? byteData,
  }) async {

    if (kIsWeb == true || file == null || byteData == null){
      return null;
    }

    else {

      final Uint8List? _uInts = Floaters.getBytesFromByteData(byteData);
      return writeUint8ListOnFile(
        file: file,
        uint8list: _uInts,
      );

    }
  }
  // --------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */
  // -----------------------------------------------------------------------------

  /// JSON

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> exportJSON({
    required Map<String, dynamic> map,
    required String fileName,
    required Function(Permission) onPermissionPermanentlyDenied,
    String exportToPath = '/storage/emulated/0/Misc'
  }) async {
    bool _success = false;

    final String _fileName = '$fileName.json';

    final File? _file = await Filers.createNewEmptyFile(
      fileName: _fileName,
      // useTemporaryDirectory: false,
    );

    await tryAndCatch(
        functions: () async {
          final String jsonString = jsonEncode(map);
          await _file!.writeAsString(jsonString);
        },
    );

    final bool _can = await Permit.requestPermission(
      permission: Permission.storage,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
    );

    if (_can == true){
      await tryAndCatch(
        invoker: 'exportJSON',
        functions: () async {
          await _file?.copy('$exportToPath/$_fileName');
          _success = true;
          },

      );
    }

    return _success;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> readLocalJSON({
    required String? path,
  }) async {
    Map<String, dynamic>? _output;

    if (path != null){

      await tryAndCatch(
        invoker: 'readLocalJSON',
        functions: () async {

          final String _jsonStringValues = await rootBundle.loadString(path);
          _output = json.decode(_jsonStringValues);

        },
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILE PATH

  // --------------------
  static final String _slash = kIsWeb ? '/' : Platform.pathSeparator;
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? fixFilePath(String? path) {
    String? _output = path;
    if (path != null) {
      _output = path.replaceAll(r'\', _slash);
      _output = path.replaceAll(r'/', _slash);
    }
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> createNewFilePath({
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || fileName == null){
      return null;
    }

    else {
      final Directory _appDocDir = useTemporaryDirectory ?
      await getTemporaryDirectory()
          :
      await getApplicationDocumentsDirectory();

      return fixFilePath('${_appDocDir.path}$_slash$fileName');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFileNameFromFile({
    required File? file,
    required bool withExtension,
  }){

    if (kIsWeb == true || file == null){
      return null;
    }

    else {
      String? _fileName;

        final String _path = file.path;
        _fileName = TextMod.removeTextBeforeLastSpecialCharacter(
            text: _path,
            specialCharacter: _slash,
        );

        if (withExtension == false) {
          _fileName = TextMod.removeTextAfterLastSpecialCharacter(
              text: _fileName,
              specialCharacter: '.',
          );
        }

      return _fileName;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>?> getFilesNamesFromFiles({
    required List<File>? files,
    required bool withExtension,
  }) async {

    if (kIsWeb == true || files == null){
      return null;
    }

    else {
      final List<String> _names = <String>[];

      if (Lister.checkCanLoop(files) == true){

        for (final File _file in files){

          final String? _name = getFileNameFromFile(
            file: _file,
            withExtension: withExtension,
          );

          if (_name != null){
            _names.add(_name);
          }

        }

      }

      return _names;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFileExtensionFromFile(File? file){

    if (kIsWeb == true || file == null){
      return null;
    }

    ///  NOTE 'jpg' - 'png' - 'pdf' ... etc => which does not include the '.'
    else {

        final String _dotExtension = extension(file.path);

        return TextMod.removeTextBeforeLastSpecialCharacter(
            text: _dotExtension,
            specialCharacter: '.',
        );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> downloadDirectory() async {
    String? _output;

    if (DeviceChecker.deviceIsAndroid() == true){
      _output = await AndroidPathProvider.downloadsPath;
    }
    else {
      final Directory? downloadsDirectory = await getDownloadsDirectory();
      _output = downloadsDirectory?.path;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSizeInMb(File? file){

    if (kIsWeb == true || file == null){
      return 0;
    }

    else {
      return getFileSizeWithUnit(
        file: file,
        unit: FileSizeUnit.megaByte,
      );
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? getFileSizeWithUnit({
    required File? file,
    required FileSizeUnit unit,
    int fractionDigits = 1,
  }){

    if (kIsWeb == true || file == null){
      return 0;
    }

    else {
      final int _bytes = file.lengthSync();
      final double? _output = calculateSize(_bytes, unit);
      return Numeric.roundFractions(_output, fractionDigits);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
    static double? calculateSize(int? bytes, FileSizeUnit unit){

    double? _size;

      if (bytes != null){
        switch (unit){
          case FileSizeUnit.byte:      _size = bytes.toDouble(); break;
          case FileSizeUnit.kiloByte:  _size = bytes / 1024; break;
          case FileSizeUnit.megaByte:  _size = bytes/ (1024 * 1024); break;
          case FileSizeUnit.gigaByte:  _size = bytes/ (1024 * 1024 * 1024); break;
          case FileSizeUnit.teraByte:  _size = bytes/ (1024 * 1024 * 1024 * 1024); break;
          default:                     _size = bytes.toDouble(); break;
        }
      }

      return Numeric.roundFractions(_size, 2);
    }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// LOCAL RASTER ASSET
  // ---------------------

  // --------------------
  /// Uint8List
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> getFileFromUint8List({
    required Uint8List? uInt8List,
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || uInt8List == null || fileName == null){
      return null;
    }

    else {
      final File? _file = await createNewEmptyFile(
        fileName: fileName,
        useTemporaryDirectory: useTemporaryDirectory,
      );

      return writeUint8ListOnFile(
        uint8list: uInt8List,
        file: _file,
      );
    }

  }
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>?> getFilesFromUint8Lists({
    required List<Uint8List>? uInt8Lists,
    required List<String>? filesNames,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || uInt8Lists == null || filesNames == null){
      return null;
    }

    else {
      final List<File> _output = <File>[];

      if (Lister.checkCanLoop(uInt8Lists) == true){

        for (int i = 0; i < uInt8Lists.length; i++){

          final File? _file = await getFileFromUint8List(
            uInt8List: uInt8Lists[i],
            fileName: filesNames[i],
            useTemporaryDirectory: useTemporaryDirectory,
          );

          if (_file != null){
            _output.add(_file);
          }

        }

      }

      return _output;
    }

  }
  // --------------------
  /// ImgImage
  // ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File?> getFileFromImgImage({
    required img.Image? imgImage,
    required String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || imgImage == null || fileName == null){
      return null;
    }

    else {

      final Uint8List? _uIntAgain = Floaters.getBytesFromImgImage(imgImage);

      return Filers.getFileFromUint8List(
          uInt8List: _uIntAgain,
          fileName: fileName,
          useTemporaryDirectory: useTemporaryDirectory,
        );

    }

  }
  // --------------------
  /// URL
  // ---------------------
  /// TASK : TEST ME
  static Future<File?> getFileFromURL({
    required String? url,
    String? fileName,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || url == null){
      return null;
    }

    else {
      File? _file;

      if (ObjectCheck.isAbsoluteURL(url) == true){

        /// call http.get method and pass imageUrl into it to get response.
        final http.Response? _response = await Rest.get(
          rawLink: url,
          // timeout: 60,
          invoker: 'getFileFromURL',
        );

        if (_response != null && _response.statusCode == 200){

          final String _fileName = fileName ?? Numeric.createUniqueID().toString();

          _file = await createNewEmptyFile(
            fileName: _fileName,
            useTemporaryDirectory: useTemporaryDirectory,
          );

          _file = await writeUint8ListOnFile(
            uint8list: _response.bodyBytes,
            file: _file,
          );

        }

      }

      return _file;
    }

  }
  // --------------------
  /// BASE 64
  // ---------------------
  static Future<File?> getFileFromBase64({
    required String? base64,
    bool useTemporaryDirectory = false,
  }) async {

    if (kIsWeb == true || base64 == null){
      return null;
    }

    else {
      final Uint8List _fileAgainAsInt = base64Decode(base64);
      // await null;

      final File? _fileAgain = await getFileFromUint8List(
        uInt8List: _fileAgainAsInt,
        fileName: '${Numeric.createUniqueID()}',
        useTemporaryDirectory: useTemporaryDirectory,
      );

      return _fileAgain;
    }
  }
  // --------------------
  /// DYNAMICS
  // ---------------------
  ///
  static Future<File?> getFileFromDynamics(dynamic pic) async {

    if (kIsWeb == true || pic == null){
      return null;
    }

    else {
      File? _file;

      if (pic != null) {

        /// FILE
        if (ObjectCheck.objectIsFile(pic) == true) {
          _file = pic;
        }

        /// ASSET
        // else if (ObjectChecker.objectIsAsset(pic) == true) {
        //   _file = await getFileFromPickerAsset(pic);
        // }

        /// URL
        else if (ObjectCheck.isAbsoluteURL(pic) == true) {
          _file = await getFileFromURL(
            url: pic,
          );
        }

        /// RASTER
        else if (ObjectCheck.objectIsJPGorPNG(pic) == true) {
          // _file = await getFile
        }

      }

      return _file;
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFilesAreIdentical({
    required File? file1,
    required File? file2,
    String invoker = 'checkFilesAreIdentical',
  }) {

    if (kIsWeb == true){
      return true;
    }

    else {
      bool _identical = false;

      if (file1 == null && file2 == null){
        _identical = true;
      }

      else if (file1 != null && file2 != null){
        if (file1.path == file2.path){
          if (file1.lengthSync() == file2.lengthSync()){
            if (file1.resolveSymbolicLinksSync() == file2.resolveSymbolicLinksSync()){

              final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
                  accuracy: TimeAccuracy.microSecond,
                  time1: file1.lastModifiedSync(),
                  time2: file2.lastModifiedSync()
              );

              if (_lastModifiedAreIdentical == true){
                _identical = true;
              }

            }
          }
        }
      }

      if (_identical == false){
        blogFilesDifferences(
          file1: file1,
          file2: file2,
        );
      }

      return _identical;
    }

  }
  // --------------------
  /*
    static bool checkFileSizeIsBiggerThan({
      required File file,
      required double megaBytes,
    }){
      bool _bigger = false;

      if (file != null && megaBytes != null){

        final double fileSize = getFileSize(file);

          _bigger = fileSize > megaBytes;

      }

      return _bigger;
    }
   */
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFile({
    required File? file,
    String invoker = 'BLOG FILE',
  }){

    if (kIsWeb == true){
      blog('blogFile : ON WEB there are no Files');
    }

    else if (file == null){
      blog('blogFile : file is null');
    }

    else {

      blog('blogFile : $invoker : file.path : ${file.path}');
      blog('blogFile : $invoker : file.absolute : ${file.absolute}');
      blog('blogFile : $invoker : file.fileNameWithExtension : ${file.fileNameWithExtension}');
      blog('blogFile : $invoker : file.runtimeType : ${file.runtimeType}');
      blog('blogFile : $invoker : file.isAbsolute : ${file.isAbsolute}');
      blog('blogFile : $invoker : file.parent : ${file.parent}');
      // blog('blogFile : $invoker : file.resolveSymbolicLinksSync() : ${file.resolveSymbolicLinksSync()}');
      blog('blogFile : $invoker : file.lengthSync() : ${file.lengthSync()}');
      blog('blogFile : $invoker : file.toString() : $file');
      blog('blogFile : $invoker : file.lastAccessedSync() : ${file.lastAccessedSync()}');
      blog('blogFile : $invoker : file.lastModifiedSync() : ${file.lastModifiedSync()}');
      // blog('blogFile : $invoker : file.openSync() : ${file.openSync()}');
      // blog('blogFile : $invoker : file.openWrite() : ${file.openWrite()}');
      // blog('blogFile : $invoker : file.statSync() : ${file.statSync()}');
      blog('blogFile : $invoker : file.existsSync() : ${file.existsSync()}');
      // DynamicLinks.blogURI(
      //   uri: file.uri,
      //   invoker: invoker,
      // );
      blog('blogFile : $invoker : file.hashCode : ${file.hashCode}');

      // blog('blogFile : $invoker : file.readAsLinesSync() : ${file.readAsLinesSync()}'); /// Unhandled Exception: FileSystemException: Failed to decode data using encoding 'utf-8',
      // blog('blogFile : $invoker : file.readAsStringSync() : ${file.readAsStringSync()}'); /// ERROR WITH IMAGE FILES
      // blog('blogFile : $invoker : file.readAsBytesSync() : ${file.readAsBytesSync()}'); /// TOO LONG

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFilesDifferences({
    required File? file1,
    required File? file2,
  }){

    if (kIsWeb == true){
      blog('blogFilesDifferences : ON WEB there are no Files');
    }

    if (file1 == null){
      blog('blogFilesDifferences : file1 is null');
    }

    if (file2 == null){
      blog('blogFilesDifferences : file2 is null');
    }

    if (file1 != null && file2 != null){

      if (file1.path != file2.path){
        blog('blogFilesDifferences: files paths are not Identical');
      }
      if (file1.lengthSync() != file2.lengthSync()){
        blog('blogFilesDifferences: files lengthSync()s are not Identical');
      }
      if (file1.resolveSymbolicLinksSync() != file2.resolveSymbolicLinksSync()){
        blog('blogFilesDifferences: files resolveSymbolicLinksSync()s are not Identical');
      }
      final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
          accuracy: TimeAccuracy.microSecond,
          time1: file1.lastModifiedSync(),
          time2: file2.lastModifiedSync()
      );
      if (_lastModifiedAreIdentical == true){
        blog('blogFilesDifferences: files lastModifiedSync()s are not Identical');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DIRECTORY - LOCAL ASSET PATH

  // --------------------
  /*
  ///
  static String imageDir({
    required String prefix,
    required String fileName,
    required double pixelRatio,
    required bool isIOS,
  }) {

    /// MediaQueryData data = MediaQuery.of(context);
    /// double ratio = data.devicePixelRatio;
    ///
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    ///
    /// If the platform is not iOS, you would implement the buckets in your code. Combining the logic into one method:
    ///
    /// double markerScale;
    /// bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    /// if (isIOS){markerScale = 0.7;}else{markerScale = 1;}

    String directory = '/';

    if (!isIOS) {
      if (pixelRatio >= 1.5) {
        directory = '/2.0x/';
      }

      else if (pixelRatio >= 2.5) {
        directory = '/3.0x/';
      }

      else if (pixelRatio >= 3.5) {
        directory = '/4.0x/';
      }

    }

    return '$prefix$directory$fileName';
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getLocalAssetsPaths() async {
    final List<String> _allAssetsPaths = <String>[];

    final Map<String, dynamic>? _json = await Filers.readLocalJSON(
      path: 'AssetManifest.json',
    );

    if (_json != null){

      final List<String> _keys = _json.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){
        for (final String key in _keys){
          _allAssetsPaths.add(_json[key].first);
        }
      }

    }

    return _allAssetsPaths;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getLocalAssetPathFromLocalPaths({
    required List<String> allAssetsPaths,
    required String? assetName,
  }){

    final List<String> _assetPath = Pathing.findPathsContainingSubstring(
      paths: allAssetsPaths,
      subString: assetName,
    );

    return _assetPath.isNotEmpty ? _assetPath.first : null;
  }
  // -----------------------------------------------------------------------------
}
