import 'package:basics/components/texting/super_text/src/super_text_structure/d_text_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // -----------------------------------------------------------------------------

  /// TextBuilder with highlight -- exercises _generateTextSpans

  // --------------------
  group('TextBuilder highlighting', () {

    testWidgets('Renders a single unhighlighted span when the highlight does not match', (tester) async {
      final highlight = ValueNotifier<dynamic>('zzz');

      await tester.pumpWidget(MaterialApp(
        home: Row(children: [TextBuilder(text: 'Hello World', highlight: highlight)]),
      ));

      final richText = tester.widget<RichText>(find.byType(RichText));
      final span = richText.text as TextSpan;
      expect(span.children, hasLength(1));
      expect((span.children!.first as TextSpan).text, 'Hello World');
    });

    testWidgets('Splits the text around a matching highlight (case-insensitive)', (tester) async {
      final highlight = ValueNotifier<dynamic>('world');

      await tester.pumpWidget(MaterialApp(
        home: Row(children: [TextBuilder(text: 'Hello World', highlight: highlight)]),
      ));

      final richText = tester.widget<RichText>(find.byType(RichText));
      final span = richText.text as TextSpan;
      final texts = span.children!.map((c) => (c as TextSpan).text).toList();

      expect(texts, ['Hello ', 'World']);
    });

    testWidgets('Highlights every occurrence of the matched substring', (tester) async {
      final highlight = ValueNotifier<dynamic>('a');

      await tester.pumpWidget(MaterialApp(
        home: Row(children: [TextBuilder(text: 'banana', highlight: highlight)]),
      ));

      final richText = tester.widget<RichText>(find.byType(RichText));
      final span = richText.text as TextSpan;
      final texts = span.children!.map((c) => (c as TextSpan).text).toList();

      expect(texts, ['b', 'a', 'n', 'a', 'n', 'a']);
    });

    testWidgets('Renders unhighlighted text when highlight is null', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Row(children: [TextBuilder(text: 'Hello World')]),
      ));

      expect(find.text('Hello World'), findsOneWidget);
      expect(find.byType(RichText), findsWidgets); // plain Text also renders via an internal RichText
    });

    testWidgets('Renders an empty SizedBox when text is null', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Row(children: [TextBuilder(text: null)]),
      ));

      expect(find.byKey(const ValueKey<String>('TextBuilder')), findsNothing);
    });

    testWidgets('Gives the leading and trailing non-highlighted spans the same style', (tester) async {
      const style = TextStyle(fontSize: 22, color: Colors.blue);
      final highlight = ValueNotifier<dynamic>('lo Wo');

      await tester.pumpWidget(MaterialApp(
        home: Row(children: [TextBuilder(text: 'Hello World', style: style, highlight: highlight)]),
      ));

      final richText = tester.widget<RichText>(find.byType(RichText));
      final span = richText.text as TextSpan;
      final children = span.children!.cast<TextSpan>();

      final leading = children.first;
      final trailing = children.last;

      expect(leading.text, 'Hel');
      expect(trailing.text, 'rld');
      expect(leading.style!.fontSize, style.fontSize);
      expect(trailing.style!.fontSize, style.fontSize);
      expect(trailing.style!.color, style.color);
    });

    testWidgets('Updates the rendered spans when the highlight value changes', (tester) async {
      final highlight = ValueNotifier<dynamic>('');

      await tester.pumpWidget(MaterialApp(
        home: Row(children: [TextBuilder(text: 'Hello World', highlight: highlight)]),
      ));

      highlight.value = 'hello';
      await tester.pump();

      final richText = tester.widget<RichText>(find.byType(RichText));
      final span = richText.text as TextSpan;
      final texts = span.children!.map((c) => (c as TextSpan).text).toList();

      expect(texts, ['Hello', ' World']);
    });

  });
}
