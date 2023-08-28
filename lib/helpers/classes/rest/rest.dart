import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:basics/helpers/classes/checks/error_helpers.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:http/http.dart' as http;

class Rest {
  // -----------------------------------------------------------------------------

  const Rest();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<http.Response?> postMap({
    required Map<String, dynamic> map,
    required String rawLink,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = 'Rest.postMap',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'REST : postMap : $invoker',
      functions: () async {

        /// POST REQUEST
        _response = await http.post(
          Uri.parse(rawLink),
          body: json.encode(map),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response?> get({
    required String rawLink,
    required String invoker,
    Map<String, String>? headers,
    int timeoutSeconds = 10,
  }) async {

    http.Response? _response;

    try {

      /// GET REQUEST
      _response = await http.get(
        Uri.parse(rawLink),
        headers: headers,
      ).timeout(
          Duration(seconds: timeoutSeconds),
          onTimeout: () async {
            blog('Rest.get timeout occurred');
            return http.Response('Rest.get timeout occurred', 408);
          }
      );

      // blog('rest.get : _response : ${_response?.body}');

    }
    on TimeoutException catch (error) {
      blog('Rest.get.TimeoutException : $invoker : error.message : ${error.message}');
    }
    on Exception catch (error) {
      blog('Rest.get.Exception : $invoker : error.message : $error');
    }

    // if (_response != null){
      // final response = await request.close().timeout(const Duration(seconds: 10));
    // }

    return _response;

  }
  // --------------------
  ///
  static Future<Uint8List?> readBytes({
    required String rawLink,
    String invoker = '',
    int timeoutSeconds = 2,
    Map<String, String>? headers,
  }) async {
    Uint8List? _uInts;

    await tryAndCatch(
      // context: context,
      invoker: 'REST : get : $invoker',
      functions: () async {

        /// GET REQUEST
        _uInts = await http.readBytes(
          Uri.parse(rawLink),
          headers: headers,
        ).timeout(
            Duration(seconds: timeoutSeconds),
            onTimeout: () async {
              blog('Rest.get timeout occurred');
              return Uint8List(0);
            }
        );

      },

    );

    return _uInts;

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<http.Response?> patchMap({
    required Map<String, dynamic> input,
    required String rawLink,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = '',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'Rest : patch : $invoker',
      functions: () async {

        /// PATCH REQUEST
        _response = await http.patch(
          Uri.parse(rawLink),
          body: json.encode(input),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<http.Response?> delete({
    required String rawLink,
    Object? body,
    Map<String, String>? headers,
    Encoding? encoding,
    String invoker = '',
  }) async {

    http.Response? _response;

    await tryAndCatch(
      invoker: 'Rest : delete : $invoker',
      functions: () async {

        /// DELETE REQUEST
        _response = await http.delete(
          Uri.parse(rawLink),
          body: body,
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _response;

  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogURI({
    required Uri? uri,
    String invoker = ':',
  }){

    if (uri == null){
      blog('blogURI $invoker : uri is null');
    }
    else {
      blog('blogURI $invoker : uri : $uri');
      blog('blogURI $invoker : uri.toString : $uri');
      blog('blogURI $invoker : uri.path : ${uri.path}');
      blog('blogURI $invoker : uri.hashCode : ${uri.hashCode}');
      blog('blogURI $invoker : uri.data : ${uri.data}');
      blog('blogURI $invoker : uri.queryParameters : ${uri.queryParameters}');
      blog('blogURI $invoker : uri.authority : ${uri.authority}');
      blog('blogURI $invoker : uri.fragment : ${uri.fragment}');
      blog('blogURI $invoker : uri.hasAbsolutePath : ${uri.hasAbsolutePath}');
      blog('blogURI $invoker : uri.hasAuthority : ${uri.hasAuthority}');
      blog('blogURI $invoker : uri.hasEmptyPath : ${uri.hasEmptyPath}');
      blog('blogURI $invoker : uri.hasFragment : ${uri.hasFragment}');
      blog('blogURI $invoker : uri.hasPort : ${uri.hasPort}');
      blog('blogURI $invoker : uri.hasQuery : ${uri.hasQuery}');
      blog('blogURI $invoker : uri.hasScheme : ${uri.hasScheme}');
      blog('blogURI $invoker : uri.query : ${uri.query}');
      blog('blogURI $invoker : uri.host : ${uri.host}');
      blog('blogURI $invoker : uri.isAbsolute : ${uri.isAbsolute}');
      blog('blogURI $invoker : uri.pathSegments : ${uri.pathSegments}');
      blog('blogURI $invoker : uri.port : ${uri.port}');
      blog('blogURI $invoker : uri.scheme : ${uri.scheme}');
      blog('blogURI $invoker : uri.userInfo : ${uri.userInfo}');
      blog('blogURI $invoker : uri.queryParametersAll : ${uri.queryParametersAll}');
      // blog('blogURI $invoker : link.origin : ${uri?.origin}'); // Unhandled Exception: Bad state: Origin is only applicable schemes http and https:
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogResponse({
    required http.Response? response,
  }){

     if (response == null){
       blog('blogResponse : response in null');
     }
     else {

       blog('response.body : ${response.body}');
       blog('response.bodyBytes.length : ${response.bodyBytes.length}');
       blog('response.statusCode : ${response.statusCode}');
       blog('response.request : ${response.request}');
       blog('response.headers : ${response.headers}');
       blog('response.isRedirect : ${response.isRedirect}');
       blog('response.persistentConnection : ${response.persistentConnection}');
       blog('response.reasonPhrase : ${response.reasonPhrase}');
       blog('response.contentLength : ${response.contentLength}');

     }

  }
  // -----------------------------------------------------------------------------

  /// ERROR HANDLING

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<http.Response> _checkUpResponse({
    required http.Response response,
    required String invoker,
    Function(http.Response response) onError,
  }) async {

    http.Response _output;

    /// RESPONSE IS NULL
    if (response == null){
      blog('REST : _checkUpResponse : response is null');
    }

    /// RESPONSE RECEIVED
    else {

      if (response.statusCode == 200){
        _output = response;
      }

      else if (response.statusCode >= 400){

        if (onError != null){
          onError(response);
        }

      }

    }

    return _output;
  }
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> _onHttpError({
    required BuildContext context,
    required String error,
    required String invoker,
  }) async {

    blog('onHttpError : $invoker : error : $error');

  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///TESTED : WORKS PERFECT
  static bool checkResponseBodyIsGood(http.Response? res){
    return res?.statusCode == 200 && res?.body != null;
  }
  // -----------------------------------------------------------------------------
}
