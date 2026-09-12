import 'package:basics/helpers/wire/wire.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('ExtraWire set', () {
    test('Updates the value when mounted is true', () {
      final Wire<int> wire = Wire<int>(1);
      final result = wire.set(value: 2);
      expect(result, true);
      expect(wire.value, 2);
    });

    test('Does not update the value when mounted is false', () {
      final Wire<int> wire = Wire<int>(1);
      final result = wire.set(value: 2, mounted: false);
      expect(result, false);
      expect(wire.value, 1);
    });

    test('Returns false and skips the notifier when the value is unchanged', () {
      final Wire<int> wire = Wire<int>(5);
      final result = wire.set(value: 5);
      expect(result, false);
      expect(wire.value, 5);
    });

    test('Notifies listeners when the value actually changes', () {
      final Wire<int> wire = Wire<int>(0);
      var notifiedCount = 0;
      wire.addListener(() => notifiedCount++);

      wire.set(value: 1);
      expect(notifiedCount, 1);

      /// setting to the same value again should not notify
      wire.set(value: 1);
      expect(notifiedCount, 1);
    });
  });

  group('ExtraWire clear', () {
    test('Disposes the notifier so further use throws', () {
      final Wire<int> wire = Wire<int>(0);
      wire.clear();
      expect(() => wire.addListener(() {}), throwsFlutterError);
    });
  });
}
