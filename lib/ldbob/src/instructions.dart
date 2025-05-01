// ignore_for_file: avoid_redundant_argument_values
part of bob;

/// after finishing models
/// run
/// dart run build_runner build
@Entity()
class TestBobModel {
  // -----------------------------------------------------------------------------
  TestBobModel({
    required this.bobID,
    required this.modelID,
    required this.bytes,
    required this.strings,
    required this.numbers,
    required this.text,
    required this.integers,
    this.notStoredInObjectBox,
  });
  // --------------------
  @Id()
  int bobID;

  @Unique(onConflict: ConflictStrategy.replace) // @Index()
  final String modelID;

  @Property(type: PropertyType.byteVector)
  final Uint8List? bytes;

  @Transient()
  final int? notStoredInObjectBox;

  final List<String> strings;
  final double? numbers;
  final String? text;
  final int? integers;
  // -----------------------------------------------------------------------------
}
