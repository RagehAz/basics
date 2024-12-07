import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/fire_helpers/models/a_authing/sign_in_method.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/maps/mapper_ss.dart';
import 'package:flutter/material.dart';

/// => TAMAM
@immutable
class AuthModel {
  // --------------------------------------------------------------------------
  const AuthModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.imageURL,
    required this.signInMethod,
    required this.data,
  });
  // --------------------------------------------------------------------------
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageURL;
  final SignInMethod? signInMethod;
  final Map<String, dynamic>? data;
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  AuthModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imageURL,
    SignInMethod? signInMethod,
    Map<String, dynamic>? data,
  }){
    return AuthModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        imageURL: imageURL ?? this.imageURL,
        signInMethod: signInMethod ?? this.signInMethod,
        data: data ?? this.data,
    );
  }
  // --------------------------------------------------------------------------

  /// CYPHER

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'imageURL': imageURL,
      'signInMethod': cipherSignInMethod(signInMethod),
      'data': data,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthModel? decipher({
    required Map<String, dynamic>? map,
    required String? userID,
  }){
    AuthModel? _output;

    if (map != null){

      _output = AuthModel(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          phone: map['phone'],
          imageURL: map['imageURL'],
          signInMethod: decipherSignInMethod(
            providerID: map['signInMethod'],
            userID: userID,
          ),
          data: map['data'],
      );

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// SIGN IN METHOD

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherSignInMethod(SignInMethod? method){
    switch (method){

      case SignInMethod.google: return 'google.com';
      case SignInMethod.facebook: return 'facebook.com';
      case SignInMethod.anonymous: return 'anonymous';
      case SignInMethod.apple: return 'apple.com';
      case SignInMethod.password: return 'password';
      // case SignInMethod.phone: return 'phone'; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SignInMethod? decipherSignInMethod({
    required String? providerID,
    required String? userID,
  }){

    switch (providerID){

      case 'google.com': return SignInMethod.google;
      case 'facebook.com': return SignInMethod.facebook;
      case 'anonymous': return SignInMethod.anonymous;
      case 'apple.com': return SignInMethod.apple;
      case 'password': return SignInMethod.password;
      // case 'phone': return SignInMethod.phone;
      default: return userID == null ? null : SignInMethod.anonymous;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<SignInMethod> signInMethodsList = [
    SignInMethod.anonymous,
    SignInMethod.password,
    SignInMethod.google,
    SignInMethod.facebook,
    SignInMethod.apple,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getSignInMethodIcon({
    required SignInMethod? signInMethod,
  }){

    switch (signInMethod){

      case SignInMethod.anonymous:  return Iconz.anonymousUser;
      case SignInMethod.password:   return Iconz.comEmail;
      case SignInMethod.google:     return Iconz.comGoogleLogo;
      case SignInMethod.facebook:   return Iconz.comFacebook;
      case SignInMethod.apple:      return Iconz.comApple;
      default: return null;

    }

  }
  // -----------------------------------------------------------------------------

  /// CYPHER USER INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, String?>>? fixTheImmutableMapsThing(dynamic maps){

    // blog('1 _fixTheImmutableMapsThing : maps type is : ${maps.runtimeType}');
    final List<dynamic> _list = maps;
    // blog('2 _fixTheImmutableMapsThing : _list type is : ${_list.runtimeType}');

    final List<Map<String, String?>> _output = <Map<String, String?>>[];

    if (Lister.checkCanLoop(_list) == true){
      for (final dynamic object in _list){

        final Map<String, String?>? _stringStringMap = MapperSS.getStringStringMapFromImmutableMapStringObject(object);

        // blog('5 _fixTheImmutableMapsThing : _stringStringMap type is : ${_stringStringMap.runtimeType}');

        if (_stringStringMap != null){
          _output.add(_stringStringMap);
        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthModel({
    required AuthModel? authModel,
    String invoker = 'AuthModel',
  }){

    if (authModel == null){
      blog('blogAuthModel : $invoker : model is null');
    }

    else {
      blog('blogAuthModel : $invoker : ---------------> START');
      blog('id : ${authModel.id}');
      blog('name : ${authModel.name}');
      blog('email : ${authModel.email}');
      blog('imageURL : ${authModel.imageURL}');
      blog('signInMethod : ${authModel.signInMethod}');
      Mapper.blogMap(authModel.data);
      blog('blogAuthModel: ---------------> END');
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAuthModelsAreIdentical({
    required AuthModel? auth1,
    required AuthModel? auth2,
  }){
    bool _identical = false;

    if (auth1 == null && auth2 == null){
      _identical = true;
    }

    else if (auth1 != null && auth2 != null){

      if (
      auth1.id == auth2.id &&
      auth1.name == auth2.name &&
      auth1.email == auth2.email &&
      auth1.phone == auth2.phone &&
      auth1.imageURL == auth2.imageURL &&
      /// NO NEED TO COMPARE THE META DATA,, ITS THERE JUST FOR INFO
      // Mapper.checkMapsAreIdentical(map1: auth1.data, map2: auth2.data)
      auth1.signInMethod == auth2.signInMethod
      ){
        _identical = true;
      }

    }

    if (_identical == false){
      blogAuthModelDifferences(
        auth1: auth1,
        auth2: auth2,
      );
    }
    
    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogAuthModelDifferences({
    required AuthModel? auth1,
    required AuthModel? auth2,
  }) {
    blog('blogAuthModelDifferences : ---------------> START');

    if (auth1 == null && auth2 == null) {
      blog('blogAuthModelDifferences : both are null');
    }

    else if (auth1 == null) {
      blog('blogAuthModelDifferences : auth1 is null');
    }

    else if (auth2 == null) {
      blog('blogAuthModelDifferences : auth2 is null');
    }

    else {
      if (auth1.id != auth2.id) {
        blog('blogAuthModelDifferences : id is different');
        blog('auth1.id : ${auth1.id}');
        blog('auth2.id : ${auth2.id}');
      }

      if (auth1.name != auth2.name) {
        blog('blogAuthModelDifferences : name is different');
        blog('auth1.name : ${auth1.name}');
        blog('auth2.name : ${auth2.name}');
      }

      if (auth1.email != auth2.email) {
        blog('blogAuthModelDifferences : email is different');
        blog('auth1.email : ${auth1.email}');
        blog('auth2.email : ${auth2.email}');
      }

      if (auth1.phone != auth2.phone) {
        blog('blogAuthModelDifferences : phone is different');
        blog('auth1.phone : ${auth1.phone}');
        blog('auth2.phone : ${auth2.phone}');
      }

      if (auth1.imageURL != auth2.imageURL) {
        blog('blogAuthModelDifferences : imageURL is different');
        blog('auth1.imageURL : ${auth1.imageURL}');
        blog('auth2.imageURL : ${auth2.imageURL}');
      }

      if (auth1.signInMethod != auth2.signInMethod) {
        blog('blogAuthModelDifferences : signInMethod is different');
        blog('auth1.signInMethod : ${auth1.signInMethod}');
        blog('auth2.signInMethod : ${auth2.signInMethod}');
      }
   
      final bool _mapsAreIdentical = Mapper.checkMapsAreIdentical(
        map1: auth1.data,
        map2: auth2.data,
      );
      
      if (_mapsAreIdentical == false) {
        blog('blogAuthModelDifferences : data is different');
        Mapper.blogMapsDifferences(
          map1: auth1.data,
          map2: auth2.data,
          invoker: 'datas',
        );
      }
    }
    
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /// TESTED : WORKS PERFECT
   @override
   String toString(){
    return
    '''
    
    AuthModel(
        id: $id, 
        name: $name,
        email: $email, 
        phone: $phone,
        imageURL: $imageURL,
        signInMethod: $signInMethod,
        data: $data
    )
     ''';

   }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AuthModel){
      _areIdentical = checkAuthModelsAreIdentical(
        auth1: this,
        auth2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      email.hashCode^
      phone.hashCode^
      imageURL.hashCode^
      signInMethod.hashCode^
      data.hashCode;
  // -----------------------------------------------------------------------------
}
