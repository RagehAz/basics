
/// => TAMAM
class Lister {
  // -----------------------------------------------------------------------------

  const Lister();

  // -----------------------------------------------------------------------------

  /// LOOPING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> loop<T>({
    required List<T?>? models,
    required Function(int index, T? model) onLoop,
    Function? onListIsEmpty,
  }) async {

    if (checkCanLoop(models) == true){

      for (int i = 0; i < models!.length; i++){
        await onLoop(i, models[i]);
      }

    }

    else {
      await onListIsEmpty?.call();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void loopSync<T>({
    required List<T?>? models,
    required Function(int index, T? model) onLoop,
    Function? onListIsEmpty,
  }) {

    if (checkCanLoop(models) == true){

      for (int i = 0; i < models!.length; i++){
        onLoop(i, models[i]);
      }

    }

    else {
      onListIsEmpty?.call();
    }

  }
  // -----------------------------------------------------------------------------

  /// LENGTH

  // --------------------
  /// TESTED : WORKS PERFECT
  static int superLength(dynamic list){
    int _output = 0;

    if (list == null){
      _output = 0;
    }

    else if (list is List<dynamic>){
      if (Lister.checkCanLoop(list) == true){
        _output = list.length;
      }
    }
    else if (list is String? || list is String){
      _output = list?.length;
    }
    else if (list is int || list is int?){
      _output = list ?? 0;
    }
    else if (list is double || list is double?){
      _output = list?.toInt();
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// AI TESTED
  static bool checkListHasNullValue(List<dynamic>? list){
    bool _hasNull = false;

    if (checkCanLoop(list) == true){

      _hasNull = list!.contains(null);

    }

    return _hasNull;
  }
  // --------------------
  /// AI TESTED
  static bool checkListsAreIdentical({
    required List<dynamic>? list1,
    required List<dynamic>? list2
  }) {
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoop(list1) == true && checkCanLoop(list2) == true){

      if (list1!.length != list2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( $list1 )');
        // blog(' ---> lis2 is ( $list2 )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          if (list1[i] != list2[i]) {
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (list1[i].toString() == list2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// NOT USED
  /*
    ///
    static bool checkIsLastListObject({
      required List<dynamic> list,
      required int index,
    }){

      bool _isAtLast = false;

      if (checkCanLoopList(list) == true){

        if (index != null){

          _isAtLast = index == (list.length - 1);

        }

      }

      return _isAtLast;
    }
     */
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getItemIndex({
    required List<dynamic>? items,
    required dynamic item,
  }){
    int _output = -1;

    if (checkCanLoop(items) == true){
      _output = items!.indexWhere((element) => element == item);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FILLERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<dynamic> fillEmptySlotsUntilIndex({
    required List<dynamic> list,
    required dynamic fillValue,
    required int index,
  }){

    final List<dynamic> _output = [];

    final bool _listIsTaller = list.length > (index + 1);
    final int _tallestLength = _listIsTaller == true ? list.length : index + 1;

    for (int i = 0; i < _tallestLength; i++){
      _output.add(fillValue);
    }

    for (int i = 0; i < list.length; i++){
      _output.removeAt(i);
      _output.insert(i, list[i]);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
