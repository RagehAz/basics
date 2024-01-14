import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_clip_board.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:flutter/material.dart';

class ValueBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ValueBox({
    required this.dataKey,
    required this.value,
    this.color = Colorz.bloodTest,
  super.key
  });
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic value;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {

        blog('copyToClipboard : value.runTimeType : ${value.runtimeType}');

        await TextClipBoard.copy(
          copy: value,
        );

      },
      child: Container(
        height: 40,
        width: 80,
        color: color,
        margin: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperText(
              text: dataKey,
              italic: true,
              textHeight: 15,
            ),

            SuperText(
              text: value.toString(),
              textHeight: 15,
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
