import 'package:basics/helpers/checks/error_helpers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';

/// => TAMAM
abstract class TextClipBoard {
  // -----------------------------------------------------------------------------

  /// COPY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> copy({
    required String? copy,
  }) async {

    if (TextCheck.isEmpty(copy) == false){

      await tryAndCatch(
        invoker: 'TextClipBoard.copy',
        functions: () async {
          await Clipboard.setData(ClipboardData(text: copy!));
        },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// PASTE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> paste() async {
    String? _output;

    await tryAndCatch(
      invoker: 'TextClipBoard.paste',
      functions: () async {
        final String? _text = await FlutterClipboard.paste();
        _output = _text?.trim();
      },
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CLEAR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clear() async {

    await tryAndCatch(
      invoker: 'TextClipBoard.clear',
      functions: () async {
        await Clipboard.setData(const ClipboardData(text: '',));
      },
    );

  }
  // ----------------------------------------------------------------------------- 
}
