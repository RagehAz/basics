import 'package:basics/helpers/permissions/permits.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Permit allPermissionsMaps', () {
    final maps = Permit.allPermissionsMaps();

    test('Includes null spacer entries alongside permission entries', () {
      expect(maps.any((m) => m == null), true);
      expect(maps.any((m) => m != null), true);
    });

    test('Every non-null entry has a permission and a matching name', () {
      for (final map in maps) {
        if (map == null) {
          continue;
        }
        expect(map['permission'], isA<Permission>());
        expect(map['name'], isA<String>());
        expect((map['name'] as String).isNotEmpty, true);
      }
    });

    test('Entry names are unique', () {
      final names = maps
          .where((m) => m != null)
          .map((m) => m!['name'] as String)
          .toList();
      expect(names.length, names.toSet().length);
    });

    test('Includes the core media/location permissions', () {
      final names = maps
          .where((m) => m != null)
          .map((m) => m!['name'] as String)
          .toSet();
      expect(names.containsAll(['camera', 'photos', 'location', 'microphone']), true);
    });
  });
}
