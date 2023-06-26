import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';

/// => TAMAM
class TextClipBoard {
  // -----------------------------------------------------------------------------

  const TextClipBoard();

  // -----------------------------------------------------------------------------

  /// COPY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> copy({
    required String? copy,
  }) async {

    if (TextCheck.isEmpty(copy) == false){

        await Clipboard.setData(
        ClipboardData(
          text: copy!,
        )
    );

    }

  }
  // -----------------------------------------------------------------------------

  /// PASTE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String?> paste() async {
    final String? _text = await FlutterClipboard.paste();
    return _text;
  }
  // -----------------------------------------------------------------------------
}
