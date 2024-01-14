// ignore_for_file: prefer_const_declarations
import 'package:basics/helpers/strings/text_directioners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('autoSwitchTextDirectionByController', () {
    test('Returns null when controller is empty', () {
      final controller = TextEditingController();

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, isNull);
    });

    test('Returns TextDirection.ltr when controller starts with English character', () {
      final controller = TextEditingController(text: 'Hello World');

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, equals(TextDirection.ltr));
    });

    test('Returns TextDirection.rtl when controller starts with Arabic character', () {
      final controller = TextEditingController(text: 'مرحبا بك');

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, equals(TextDirection.rtl));
    });

    test('Returns null when controller starts with non-English and non-Arabic character', () {
      final controller = TextEditingController(text: '12345');

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, isNull);
    });

    test('Returns null when controller is null', () {
      final controller = null;

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, isNull);
    });

    test('Returns TextDirection.ltr when controller starts with English character ignoring spaces',
        () {
      final controller = TextEditingController(text: '  Hello World');

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, equals(TextDirection.ltr));
    });

    test('Returns TextDirection.rtl when controller starts with Arabic character ignoring spaces',
        () {
      final controller = TextEditingController(text: '   مرحبا بك');

      final result = TextDir.autoSwitchTextDirectionByController(controller);

      expect(result, equals(TextDirection.rtl));
    });
  });

  group('autoSwitchTextDirection', () {
    test('Returns ltr when val starts with English character', () {
      final result = TextDir.autoSwitchTextDirection(val: 'Hello', appIsLTR: true);
      expect(result, equals(TextDirection.ltr));
    });

    test('Returns rtl when val starts with Arabic character', () {
      final result = TextDir.autoSwitchTextDirection(val: 'مرحبا', appIsLTR: true);
      expect(result, equals(TextDirection.rtl));
    });

    test('Returns ltr when val is empty and appIsLTR is true', () {
      final result = TextDir.autoSwitchTextDirection(val: '', appIsLTR: true);
      expect(result, equals(TextDirection.ltr));
    });

    test('Returns rtl when val is empty and appIsLTR is false', () {
      final result = TextDir.autoSwitchTextDirection(val: '', appIsLTR: false);
      expect(result, equals(TextDirection.rtl));
    });

    test('Returns ltr when val is null and appIsLTR is true', () {
      final result = TextDir.autoSwitchTextDirection(val: null, appIsLTR: true);
      expect(result, equals(TextDirection.ltr));
    });

    test('Returns rtl when val is null and appIsLTR is false', () {
      final result = TextDir.autoSwitchTextDirection(val: null, appIsLTR: false);
      expect(result, equals(TextDirection.rtl));
    });

    test('Returns ltr when val is a whitespace string', () {
      final result = TextDir.autoSwitchTextDirection(val: '    ', appIsLTR: true);
      expect(result, equals(TextDirection.ltr));
    });
  });

  group('concludeTextDirection', () {
    test('Returns definedDirection when it is not null', () {
      final result = TextDir.concludeTextDirection(
        definedDirection: TextDirection.rtl,
        detectedDirection: TextDirection.ltr,
        appIsLTR: true,
      );
      expect(result, equals(TextDirection.rtl));
    });

    test('Returns getAppLangTextDirection when detectedDirection is null', () {
      final result = TextDir.concludeTextDirection(
        definedDirection: null,
        detectedDirection: null,
        appIsLTR: true,
      );
      expect(result, equals(TextDir.getAppLangTextDirection(appIsLTR: true)));
    });

    test('Returns detectedDirection when definedDirection and detectedDirection are not null', () {
      final result = TextDir.concludeTextDirection(
        definedDirection: null,
        detectedDirection: TextDirection.rtl,
        appIsLTR: true,
      );
      expect(result, equals(TextDirection.rtl));
    });

    test(
        'Returns getAppLangTextDirection when definedDirection is null and detectedDirection is null',
        () {
      final result = TextDir.concludeTextDirection(
        definedDirection: null,
        detectedDirection: null,
        appIsLTR: false,
      );
      expect(result, equals(TextDir.getAppLangTextDirection(appIsLTR: false)));
    });

    test(
        'Returns getAppLangTextDirection when definedDirection is null and detectedDirection is ltr',
        () {
      final result = TextDir.concludeTextDirection(
        definedDirection: null,
        detectedDirection: TextDirection.ltr,
        appIsLTR: true,
      );
      expect(result, equals(TextDir.getAppLangTextDirection(appIsLTR: true)));
    });

    test(
        'Returns getAppLangTextDirection when definedDirection is null and detectedDirection is rtl',
        () {
      final result = TextDir.concludeTextDirection(
        definedDirection: null,
        detectedDirection: TextDirection.rtl,
        appIsLTR: false,
      );
      expect(result, equals(TextDir.getAppLangTextDirection(appIsLTR: false)));
    });
  });

}
