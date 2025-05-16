part of av;
/// GREAT
class CreateSingleAVConstructor {
  // --------------------------------------------------------------------------
  const CreateSingleAVConstructor({
    required this.uploadPath,
    required this.skipMeta,
    required this.bobDocName,
    this.ownersIDs,
    this.caption,
    this.originalURL,
    this.origin,
    this.durationMs,
    this.fileExt,
    this.width,
    this.height,
    this.originalXFilePath,
  });
  // --------------------
  final String uploadPath;
  final bool skipMeta;
  final String bobDocName;
  final List<String>? ownersIDs;
  final String? caption;
  final String? originalURL;
  final AvOrigin? origin;
  final int? durationMs;
  final FileExtType? fileExt;
  final double? width;
  final double? height;
  final String? originalXFilePath;
  // --------------------
  CreateSingleAVConstructor copyWith({
    String? uploadPath,
    bool? skipMeta,
    String? bobDocName,
    List<String>? ownersIDs,
    String? caption,
    String? originalURL,
    AvOrigin? origin,
    int? durationMs,
    FileExtType? fileExt,
    double? width,
    double? height,
    String? originalXFilePath,
  }) {
    return CreateSingleAVConstructor(
      uploadPath: uploadPath ?? this.uploadPath,
      skipMeta: skipMeta ?? this.skipMeta,
      bobDocName: bobDocName ?? this.bobDocName,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      caption: caption ?? this.caption,
      originalURL: originalURL ?? this.originalURL,
      origin: origin ?? this.origin,
      durationMs: durationMs ?? this.durationMs,
      fileExt: fileExt ?? this.fileExt,
      width: width ?? this.width,
      height: height ?? this.height,
      originalXFilePath: originalXFilePath ?? this.originalXFilePath,
    );
  }
  // --------------------------------------------------------------------------
}
/// GREAT
class CreateMultiAVConstructor {
  // --------------------------------------------------------------------------
  const CreateMultiAVConstructor({
    required this.uploadPathGenerator,
    required this.skipMeta,
    required this.bobDocName,
    this.origin,
    this.ownersIDs,
    this.captionGenerator,
  });

  // --------------------
  final String Function(int index, String? filePath) uploadPathGenerator;
  final bool skipMeta;
  final String bobDocName;
  final AvOrigin? origin;
  final List<String>? ownersIDs;
  final String Function(int index, String? url)? captionGenerator;
  // --------------------
  CreateMultiAVConstructor copyWith({
    String Function(int index, String? title)? uploadPathGenerator,
    bool? skipMeta,
    String? bobDocName,
    AvOrigin? origin,
    List<String>? ownersIDs,
    String Function(int index, String? urlOrPathOrID)? captionGenerator,
  }) {
    return CreateMultiAVConstructor(
      uploadPathGenerator: uploadPathGenerator ?? this.uploadPathGenerator,
      skipMeta: skipMeta ?? this.skipMeta,
      bobDocName: bobDocName ?? this.bobDocName,
      origin: origin ?? this.origin,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      captionGenerator: captionGenerator ?? this.captionGenerator,
    );
  }
// --------------------------------------------------------------------------
}
