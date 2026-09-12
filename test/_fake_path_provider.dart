import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Points `getApplicationDocumentsDirectory()` (used by both `SembastInit`
/// and `StoreModel.createNewModel`) at a real, disposable temp directory
/// instead of a platform channel, so ldb/ldbob tests can open a real
/// on-disk database/store without a device or platform mocking harness.
class FakePathProviderPlatform extends PathProviderPlatform {
  FakePathProviderPlatform(this.documentsPath);

  final String documentsPath;

  @override
  Future<String?> getApplicationDocumentsPath() async => documentsPath;
}
