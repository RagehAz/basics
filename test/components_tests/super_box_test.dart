import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  Future<void> pump(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Center(child: child)),
    ));
  }

  group('SuperBox text rendering', () {

    testWidgets('Renders short text in a normal-height box without error', (tester) async {
      await pump(tester, const SuperBox(
        height: 60,
        width: 200,
        text: 'Hello',
      ));

      expect(tester.takeException(), isNull);
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('Does not throw a RenderFlex overflow error when text overflows a small box', (tester) async {
      await pump(tester, const SuperBox(
        height: 10,
        width: 50,
        text: 'This is a fairly long piece of text that will not fit',
        secondText: 'And an even longer second line of text underneath it as well',
      ));

      expect(tester.takeException(), isNull);
    });

    testWidgets('Renders both text and secondText when both are provided', (tester) async {
      await pump(tester, const SuperBox(
        height: 80,
        width: 200,
        text: 'Main line',
        secondText: 'Second line',
      ));

      expect(tester.takeException(), isNull);
      expect(find.text('Main line'), findsOneWidget);
      expect(find.text('Second line'), findsOneWidget);
    });

    testWidgets('Renders nothing extra and does not throw when no text is given', (tester) async {
      await pump(tester, const SuperBox(
        height: 60,
        width: 200,
      ));

      expect(tester.takeException(), isNull);
    });

    testWidgets('Does not throw with a very small height and long text (stress case)', (tester) async {
      await pump(tester, const SuperBox(
        height: 5,
        width: 40,
        text: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      ));

      expect(tester.takeException(), isNull);
    });

  });

}
