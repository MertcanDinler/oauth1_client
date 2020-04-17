//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// oauth1_client_base.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:22:04.838Z
// Modified: 2020-04-17T22:47:40.687Z
//

import 'dart:io';

import 'package:http/http.dart' as http;

import 'authorization_header.dart';
import 'client.dart';
import 'credentials/consumer_credentials.dart';
import 'credentials/temporary_credentials.dart';
import 'credentials/token_credentials.dart';
import 'signatures/signature.dart';

/// # OAuth1Client
class OAuth1Client {
  Client _client;
  final AuthorizationHeader _authorizationHeader = AuthorizationHeader();
  TemporaryCredentials _temporaryCredentials;

  OAuth1Client(ConsumerCredentials consumer) {
    _authorizationHeader.consumer = consumer;
    _client = Client(_authorizationHeader);
  }
  http.Client get client => _client;
  set signatureMethod(Signature value) =>
      _authorizationHeader.signature = value;
  set token(TokenCredentials value) => _authorizationHeader.token = value;

  Future<TokenCredentials> fetchAccessToken(String url, String verifier) async {
    var response = await _client.post(
        '$url?oauth_token=${_temporaryCredentials.identifier}&oauth_verifier=$verifier');
    return TokenCredentials.fromResponse(response.body);
  }

  Future<TemporaryCredentials> fetchRequestToken(String url) async {
    var response = await _client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'oauth_callback'});
    _temporaryCredentials = TemporaryCredentials.fromResponse(response.body);
    return _temporaryCredentials;
  }

  String getAuthorizationUrl(url) {
    return '$url?oauth_token=${_temporaryCredentials.identifier}';
  }
}
