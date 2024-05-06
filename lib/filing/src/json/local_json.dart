part of filing;

class LocalJSON {
  // -----------------------------------------------------------------------------

  const LocalJSON();

  // -----------------------------------------------------------------------------

  /// FILE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> exportFile({
    required File? file,
    required Function(Permission) onPermissionPermanentlyDenied,
    String exportToPath = '/storage/emulated/0/Misc'
  }) async {
    bool _success = false;

    if (file != null){

      final bool _can = await Permit.requestPermission(
        permission: Permission.storage,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      );

      if (_can == true){
        await tryAndCatch(
          invoker: 'exportJSON',
          functions: () async {

            await Isolate.run(() async {
              await file.copy('$exportToPath/${file.fileName}');
            });

            _success = true;
          },
          onError: (String? error) async {

            final bool _pathNotFound = TextCheck.stringContainsSubString(
                string: error,
                subString: 'PathNotFoundException',
            );

            if (_pathNotFound == true){

              await tryAndCatch(
                invoker: 'exportJSON_2',
                functions: () async {

                  await Directory(exportToPath).create(recursive: true);

                  await Isolate.run(() async {
                    await file.copy('$exportToPath/${file.fileName}');
                  });

                  _success = true;

                },
              );

            }

          }

        );
      }

    }

    return _success;
  }
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

    final String _fileName = '$fileName.json';

    final File? _file = await Filer.createEmptyFile(
      fileName: _fileName,
      // useTemporaryDirectory: false,
    );

    await tryAndCatch(
      invoker: 'LocalJSON.export',
      functions: () async {
        final String jsonString = jsonEncode(map);
        await _file!.writeAsString(jsonString);
      },
    );

    final bool _success = await exportFile(
      file: _file,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      exportToPath: exportToPath,
    );

    await Filer.deleteFile(_file);

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
