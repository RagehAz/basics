import 'dart:convert';
import 'dart:typed_data';
import 'package:basics/helpers/rest/rest.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

/// AI GENERATED : BUT NOT TESTED : NEED VALID URL LINK TO TEST
void main() {

  test('test postMap method', () async {
    // Setup
    final map = {'key': 'value'};
    const rawLink = 'https://www.example.com';
    final headers = {'headerKey': 'headerValue'};
    final encoding = Encoding.getByName('utf-8');
    const invoker = 'test';

    // Call method
    final response = await Rest.postMap(
      map: map,
      rawLink: rawLink,
      headers: headers,
      encoding: encoding,
      invoker: invoker,
    );

    // Assertions
    expect(response, isA<http.Response>());
  });

  test('test get method', () async {
    // Setup
    const rawLink = 'https://www.example.com';
    const invoker = 'test';
    final headers = {'headerKey': 'headerValue'};
    // const timeoutSeconds = 10;

    // Call method
    final response = await Rest.get(
      rawLink: rawLink,
      invoker: invoker,
      headers: headers,
      // timeoutSeconds: timeoutSeconds,
    );

    // Assertions
    expect(response, isA<http.Response>());
  });

  test('test readBytes method', () async {
    // Setup
    const rawLink = 'https://www.example.com';
    const invoker = 'test';
    // const timeoutSeconds = 2;
    final headers = {'headerKey': 'headerValue'};

    // Call method
    final uInts = await Rest.readBytes(
      rawLink: rawLink,
      invoker: invoker,
      // timeoutSeconds: timeoutSeconds,
      headers: headers,
    );

    // Assertions
    expect(uInts, isA<Uint8List>());
  });

  test('test patchMap method', () async {
    // Setup
    final input = {'key': 'value'};
    const rawLink = 'https://www.example.com';
    final headers = {'headerKey': 'headerValue'};
    final encoding = Encoding.getByName('utf-8');
    const invoker = 'test';

    // Call method
    final response = await Rest.patchMap(
      input: input,
      rawLink: rawLink,
      headers: headers,
      encoding: encoding,
      invoker: invoker,
    );

    // Assertions
    expect(response, isA<http.Response>());
  });

  test('test delete method', () async {
    // Setup
    const rawLink = 'https://www.example.com';
    final body = {'key': 'value'};
    final headers = {'headerKey': 'headerValue'};
    final encoding = Encoding.getByName('utf-8');
    const invoker = 'test';

    // Call method
    final response = await Rest.delete(
      rawLink: rawLink,
      body: body,
      headers: headers,
      encoding: encoding,
      invoker: invoker,
    );

    // Assertions
    expect(response, isA<http.Response>());
  });

}
