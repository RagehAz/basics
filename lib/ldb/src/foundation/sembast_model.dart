part of ldb;
/// TAMAM
@immutable
class DBModel {
  // -----------------------------------------------------------------------------
  const DBModel({
    required this.database,
    required this.doc,
    required this.docName,
  });
  // -----------------------------------------------------------------------------
  final Database database;
  final StoreRef<int, Map<String, dynamic>> doc;
  final String docName;
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkModelsAreIdentical({
    required DBModel? model1,
    required DBModel? model2,
  }){
    return model1?.toString() == model2?.toString();
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
       TemplateModel(
          database : $database,
          doc : $doc,
          docName : $docName,
       )  
       ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DBModel){
      _areIdentical = checkModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      docName.hashCode^
      doc.hashCode^
      database.hashCode;
// -----------------------------------------------------------------------------
}

typedef DBSnap = RecordSnapshot<int, Map<String, dynamic>>;
