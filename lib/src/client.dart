//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// client.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-17T19:32:46.193Z
// Modified: 2020-04-17T22:36:32.559Z
//
import 'dart:io';

import 'package:http/http.dart' as http;

import 'authorization_header.dart';
import 'credentials/credentials.dart';

class Client extends http.BaseClient {
  final http.Client _client = http.Client();
  AuthorizationHeader _authorizationHeader;
  Credentials token;

  Client(AuthorizationHeader authorizationHeader) {
    _authorizationHeader = authorizationHeader;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    _authorizationHeader.initRequest(request.method, request.url.toString());
    var headers = request.headers;
    if (headers.isNotEmpty) {
      if (headers.containsKey(HttpHeaders.authorizationHeader)) {
        _authorizationHeader.params.addAll(
            Uri.splitQueryString(headers[HttpHeaders.authorizationHeader]));
      }
      if (headers.containsKey(HttpHeaders.contentTypeHeader) &&
          headers[HttpHeaders.contentTypeHeader]
              .contains('application/x-www-form-urlencoded') &&
          (request as http.Request).body != null) {
        _authorizationHeader.params
            .addAll(Uri.splitQueryString((request as http.Request).body));
      }
    }
    if (request.url.queryParameters.isNotEmpty) {
      _authorizationHeader.params.addAll(request.url.queryParameters);
    }
    request.headers[HttpHeaders.authorizationHeader] =
        _authorizationHeader.getOauthString();
    return _client.send(request);
  }
}
