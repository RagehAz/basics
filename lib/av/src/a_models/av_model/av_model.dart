part of av;

class AvModel {
  // -----------------------------------------------------------------------------
  const AvModel({
    required this.id,
    required this.xFile,
    this.ownersIDs,
    this.width,
    this.height,
    this.name,
    this.sizeMB,
    this.sizeB,
    this.fileExt,
    this.data,
    this.uploadPath,
    this.origin,
    this.originalURL,
    this.caption,
  });
  // --------------------
  final String id;
  final XFile xFile;
  final List<String>? ownersIDs;
  final double? width;
  final double? height;
  final String? name;
  final double? sizeMB;
  final int? sizeB;
  final FileExtType? fileExt;
  final Map<String, String>? data;
  final String? uploadPath; /// storage/collectionName/subCollectionName/fileName.ext
  final MediaOrigin? origin;
  final String? originalURL;
  final String? caption;
  // -----------------------------------------------------------------------------

  /// TITLE

  // --------------------
  ///
  AvModel copyWith({
    String? id,
    XFile? xFile,
    List<String>? ownersIDs,
    double? width,
    double? height,
    String? name,
    double? sizeMB,
    int? sizeB,
    FileExtType? fileExt,
    Map<String, String>? data,
    String? uploadPath,
    MediaOrigin? origin,
    String? originalURL,
    String? caption,
  }){

    return AvModel(
      id: id ?? this.id,
      xFile: xFile ?? this.xFile,
      ownersIDs: ownersIDs ?? this.ownersIDs,
      width: width ?? this.width,
      height: height ?? this.height,
      name: name ?? this.name,
      sizeMB: sizeMB ?? this.sizeMB,
      sizeB: sizeB ?? this.sizeB,
      fileExt: fileExt ?? this.fileExt,
      data: data ?? this.data,
      uploadPath: uploadPath ?? this.uploadPath,
      origin: origin ?? this.origin,
      originalURL: originalURL ?? this.originalURL,
      caption: caption ?? this.caption,
    );

  }
  // -----------------------------------------------------------------------------
}
