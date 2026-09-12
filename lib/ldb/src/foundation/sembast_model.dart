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
    if (model1 == null || model2 == null){
      return model1 == model2;
    }

    /// compare the 3 fields directly instead of building and comparing two
    /// multi-line toString() templates -- also fixes a hashCode/== contract
    /// risk: hashCode is field-based while database's toString() calls
    /// toJson() (not identity-based), so the old string comparison could
    /// disagree with hashCode for objects considered unequal by identity.
    return model1.docName == model2.docName &&
        model1.doc == model2.doc &&
        model1.database == model2.database;
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
