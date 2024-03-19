part of filing;

class LocalJSON {
  // -----------------------------------------------------------------------------

  const LocalJSON();

  // -----------------------------------------------------------------------------

  /// JSON

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> export({
    required Map<String, dynamic> map,
    required String fileName,
    required Function(Permission) onPermissionPermanentlyDenied,
    String exportToPath = '/storage/emulated/0/Misc'
  }) async {
    bool _success = false;

    final String _fileName = '$fileName.json';

    final File? _file = await Filer.createEmptyFile(
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
  static Future<Map<String, dynamic>?> read({
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
}
