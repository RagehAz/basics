part of av;
/// => GREAT
abstract class _PickPDFFromDevice {
  // -----------------------------------------------------------------------------

  /// PICK SINGLE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AvModel?> pickPDF({
    required String dialogTitle,
    required String bobDocName,
    required String uploadPath,
    List<String>? ownersIDs,
  }) async {

    AvModel? _output;

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // allowCompression: true,
      // allowMultiple: false,
      dialogTitle: dialogTitle,
      // lockParentWindow: false,
      onFileLoading: (FilePickerStatus status){
        blog('status : ${status.name}');
      },
      /// ??
      allowedExtensions: <String>['pdf'],
      // initialDirectory:
      /// ??
      withData: true,
      // withReadStream:

    );

    if (result != null){

      final PlatformFile _platformFile = result.files.first;

      // blog('_platformFile name        : ${_platformFile.name}');
      // blog('_platformFile size        : ${_platformFile.size}');
      // blog('_platformFile path        : ${_platformFile.path}'); // this throws error in web
      // On web `path` is always `null`,
      // You should access `bytes` property instead,
      // blog('_platformFile bytes       : ${_platformFile.bytes?.length} bytes');
      // blog('_platformFile extension   : ${_platformFile.extension}');
      // blog('_platformFile identifier  : ${_platformFile.identifier}');
      // blog('_platformFile identifier  : ${_platformFile.identifier}');

      _output = await AvOps.createFromBytes(
        bytes: _platformFile.bytes,
        data: CreateSingleAVConstructor(
          skipMeta: false,
          bobDocName: bobDocName,
          uploadPath: uploadPath,
          ownersIDs: ownersIDs,
          originalXFilePath: _platformFile.path,
          origin: AvOrigin.deviceFiles,
          caption: _platformFile.name,
          fileExt: FileExtType.pdf,
          // originalURL: null,
          // durationMs: null,
          // width: null,
          // height: null,
        ),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
