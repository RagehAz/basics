import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// graphicWidth

  // --------------------
  group('SuperBoxController.graphicWidth', () {

    test('Returns 0 when icon is null', () {
      final result = SuperBoxController.graphicWidth(icon: null, height: 40, loading: false);
      expect(result, 0);
    });

    test('Returns 0 when height is null', () {
      final result = SuperBoxController.graphicWidth(icon: Icons.star, height: null, loading: false);
      expect(result, 0);
    });

    test('Returns 0 when height is 0', () {
      final result = SuperBoxController.graphicWidth(icon: Icons.star, height: 0, loading: false);
      expect(result, 0);
    });

    test('Uses the 0.7 default factor while loading', () {
      final result = SuperBoxController.graphicWidth(icon: Icons.star, height: 40, loading: true);
      expect(result, 28); // 40 * 0.7
    });

    test('Uses an explicit iconSizeFactor while loading', () {
      final result = SuperBoxController.graphicWidth(icon: Icons.star, height: 40, loading: true, iconSizeFactor: 0.5);
      expect(result, 20);
    });

    test('Returns height * iconSizeFactor (default 1) for an IconData icon', () {
      final result = SuperBoxController.graphicWidth(icon: Icons.star, height: 40, loading: false);
      expect(result, 40);
    });

    test('Returns height * iconSizeFactor for an SVG asset path', () {
      final result = SuperBoxController.graphicWidth(icon: 'assets/icon.svg', height: 40, loading: false, iconSizeFactor: 0.5);
      expect(result, 20);
    });

    test('Returns height * iconSizeFactor for a PNG asset path', () {
      final result = SuperBoxController.graphicWidth(icon: 'assets/icon.png', height: 40, loading: false);
      expect(result, 40);
    });

    test('Returns 0 for a String icon that is neither SVG nor JPG/PNG', () {
      final result = SuperBoxController.graphicWidth(icon: 'not-an-image', height: 40, loading: false);
      expect(result, 0);
    });

    test('Returns the raw height for a non-IconData, non-String icon (e.g. a widget)', () {
      final result = SuperBoxController.graphicWidth(icon: const SizedBox(), height: 40, loading: false);
      expect(result, 40);
    });

  });
  // -----------------------------------------------------------------------------

  /// iconMargin / iconMarginFromGraphicWidth (must agree -- iconMargin
  /// delegates to iconMarginFromGraphicWidth with a freshly computed
  /// graphicWidth)

  // --------------------
  group('SuperBoxController.iconMargin / iconMarginFromGraphicWidth', () {

    test('iconMargin returns 0 when text is null', () {
      final result = SuperBoxController.iconMargin(icon: Icons.star, height: 40, iconSizeFactor: null, text: null, loading: false);
      expect(result, 0);
    });

    test('iconMargin returns 0 when there is no icon and not loading', () {
      final result = SuperBoxController.iconMargin(icon: null, height: 40, iconSizeFactor: null, text: 'hi', loading: false);
      expect(result, 0);
    });

    test('iconMargin returns 0 when height is null', () {
      final result = SuperBoxController.iconMargin(icon: Icons.star, height: null, iconSizeFactor: null, text: 'hi', loading: false);
      expect(result, 0);
    });

    test('iconMargin computes (height - graphicWidth) / 2 for an icon+text box', () {
      final result = SuperBoxController.iconMargin(icon: Icons.star, height: 40, iconSizeFactor: 0.5, text: 'hi', loading: false);
      expect(result, 10); // (40 - 20) / 2
    });

    test('iconMargin treats loading (no icon) as having zero graphicWidth (icon==null short-circuits graphicWidth to 0)', () {
      final result = SuperBoxController.iconMargin(icon: null, height: 40, iconSizeFactor: null, text: 'hi', loading: true);
      expect(result, 20); // (40 - 0) / 2, since graphicWidth returns 0 when icon is null
    });

    test('iconMargin agrees with iconMarginFromGraphicWidth given the matching graphicWidth', () {
      const icon = Icons.star;
      const height = 40.0;
      const iconSizeFactor = 0.6;
      const text = 'hi';
      const loading = false;

      final graphicWidth = SuperBoxController.graphicWidth(icon: icon, height: height, loading: loading, iconSizeFactor: iconSizeFactor);

      final viaIconMargin = SuperBoxController.iconMargin(icon: icon, height: height, iconSizeFactor: iconSizeFactor, text: text, loading: loading);
      final viaGraphicWidth = SuperBoxController.iconMarginFromGraphicWidth(graphicWidth: graphicWidth, icon: icon, height: height, text: text, loading: loading);

      expect(viaIconMargin, viaGraphicWidth);
    });

  });
  // -----------------------------------------------------------------------------

  /// verseWidth / verseMaxWidth

  // --------------------
  group('SuperBoxController.verseWidth / verseMaxWidth', () {

    test('verseWidth returns null when width is null', () {
      final result = SuperBoxController.verseWidth(width: null, iconMargin: 5, graphicWidth: 20, hasIcon: true);
      expect(result, isNull);
    });

    test('verseWidth subtracts margins, graphicWidth and spacing from width', () {
      final result = SuperBoxController.verseWidth(width: 200, iconMargin: 5, graphicWidth: 20, hasIcon: true);
      final leftSpacing = SuperBoxController.getVerseLeftSpacing(iconMargin: 5, hasIcon: true, widthIsGiven: true);
      final rightSpacing = SuperBoxController.getVerseRightSpacing(iconMargin: 5, hasIcon: true, widthIsGiven: true);
      expect(result, 200 - (5 * 2) - 20 - leftSpacing - rightSpacing);
    });

    test('verseMaxWidth returns null when maxWidth is null', () {
      final result = SuperBoxController.verseMaxWidth(maxWidth: null, iconMargin: 5, graphicWidth: 20, hasIcon: true);
      expect(result, isNull);
    });

    test("verseMaxWidth mirrors verseWidth's formula against maxWidth", () {
      final width = SuperBoxController.verseWidth(width: 200, iconMargin: 5, graphicWidth: 20, hasIcon: true);
      final maxWidth = SuperBoxController.verseMaxWidth(maxWidth: 200, iconMargin: 5, graphicWidth: 20, hasIcon: true);
      expect(maxWidth, width);
    });

  });
  // -----------------------------------------------------------------------------

  /// verseHorizontalMargin / getVerseLeftSpacing / getVerseRightSpacing

  // --------------------
  group('SuperBoxController spacing helpers', () {

    test('verseHorizontalMargin returns 3 when width is given and there is an icon', () {
      expect(SuperBoxController.verseHorizontalMargin(hasIcon: true, widthIsGiven: true), 3);
    });

    test('verseHorizontalMargin returns 5 when width is given and there is no icon', () {
      expect(SuperBoxController.verseHorizontalMargin(hasIcon: false, widthIsGiven: true), 5);
    });

    test('verseHorizontalMargin returns 10 when width is not given, regardless of icon', () {
      expect(SuperBoxController.verseHorizontalMargin(hasIcon: true, widthIsGiven: false), 10);
      expect(SuperBoxController.verseHorizontalMargin(hasIcon: false, widthIsGiven: false), 10);
    });

    test('getVerseLeftSpacing never goes negative', () {
      final result = SuperBoxController.getVerseLeftSpacing(iconMargin: 100, hasIcon: true, widthIsGiven: true);
      expect(result, 0);
    });

    test('getVerseRightSpacing adds iconMargin to the horizontal margin', () {
      final result = SuperBoxController.getVerseRightSpacing(iconMargin: 5, hasIcon: true, widthIsGiven: true);
      expect(result, 3 + 5);
    });

  });
  // -----------------------------------------------------------------------------

  /// superMargins

  // --------------------
  group('SuperBoxController.superMargins', () {

    test('Returns EdgeInsets.zero when margin is null', () {
      expect(SuperBoxController.superMargins(margin: null), EdgeInsets.zero);
    });

    test('Returns EdgeInsets.zero when margin is 0', () {
      expect(SuperBoxController.superMargins(margin: 0), EdgeInsets.zero);
    });

    test('Wraps a double margin in EdgeInsets.all', () {
      expect(SuperBoxController.superMargins(margin: 8.0), const EdgeInsets.all(8));
    });

    test('Wraps an int margin in EdgeInsets.all as a double', () {
      expect(SuperBoxController.superMargins(margin: 8), const EdgeInsets.all(8));
    });

    test('Passes an EdgeInsets margin straight through', () {
      const insets = EdgeInsets.symmetric(horizontal: 4, vertical: 2);
      expect(SuperBoxController.superMargins(margin: insets), insets);
    });

  });
  // -----------------------------------------------------------------------------

  /// boxColor / textColor / iconColor

  // --------------------
  group('SuperBoxController colors', () {

    test('boxColor returns white10 when disabled', () {
      expect(SuperBoxController.boxColor(greyScale: false, color: Colors.red, isDisabled: true), Colorz.white10);
    });

    test('boxColor returns white10 when color is null', () {
      expect(SuperBoxController.boxColor(greyScale: false, color: null, isDisabled: false), Colorz.white10);
    });

    test('boxColor returns the given color when enabled and not fully transparent', () {
      expect(SuperBoxController.boxColor(greyScale: false, color: Colors.red, isDisabled: false), Colors.red);
    });

    test('textColor returns a translucent white when disabled', () {
      expect(SuperBoxController.textColor(colorOverride: Colors.red, isDisabled: true, greyScale: false),
          const Color.fromARGB(30, 255, 255, 255));
    });

    test('textColor falls back to white50 when greyScale and no override', () {
      expect(SuperBoxController.textColor(colorOverride: null, isDisabled: false, greyScale: true), Colorz.white50);
    });

    test('textColor returns the override when neither disabled nor greyScale', () {
      expect(SuperBoxController.textColor(colorOverride: Colors.blue, isDisabled: false, greyScale: false), Colors.blue);
    });

    test('iconColor returns white50 when disabled', () {
      expect(SuperBoxController.iconColor(greyScale: false, isDisabled: true, colorOverride: Colors.blue), Colorz.white50);
    });

    test('iconColor returns the override color when enabled', () {
      expect(SuperBoxController.iconColor(greyScale: false, isDisabled: false, colorOverride: Colors.blue), Colors.blue);
    });

  });
  // -----------------------------------------------------------------------------

  /// checkTextIsCentered / getContentsRowMainAxisAlignment

  // --------------------
  group('SuperBoxController alignment helpers', () {

    test('checkTextIsCentered returns true when verseCentered is true', () {
      expect(SuperBoxController.checkTextIsCentered(verseCentered: true, icon: Icons.star), true);
    });

    test('checkTextIsCentered returns false when there is an icon and verseCentered is false', () {
      expect(SuperBoxController.checkTextIsCentered(verseCentered: false, icon: Icons.star), false);
    });

    test('checkTextIsCentered returns verseCentered as-is when there is no icon', () {
      expect(SuperBoxController.checkTextIsCentered(verseCentered: false, icon: null), false);
    });

    test('getContentsRowMainAxisAlignment maps centered to MainAxisAlignment.center', () {
      expect(SuperBoxController.getContentsRowMainAxisAlignment(centered: true), MainAxisAlignment.center);
    });

    test('getContentsRowMainAxisAlignment maps not-centered to MainAxisAlignment.start', () {
      expect(SuperBoxController.getContentsRowMainAxisAlignment(centered: false), MainAxisAlignment.start);
    });

  });
}
