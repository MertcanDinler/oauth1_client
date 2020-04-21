//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// authorization_header.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T11:10:36.220Z
// Modified: 2020-04-21T22:08:00.371Z
//

import 'dart:convert';
import 'dart:math';

import 'credentials/consumer_credentials.dart';
import 'credentials/token_credentials.dart';
import 'signatures/signature.dart';
import 'signatures.dart';

class AuthorizationHeader {
  ConsumerCredentials _consumer;

  String method;
  String url;
  Map<String, String> params = {};
  TokenCredentials token;
  Signature signature = Signatures.plainText;

  ConsumerCredentials get consumer => _consumer;

  set consumer(ConsumerCredentials value) => _consumer = value;
  String get timestamp =>
      (DateTime.now().millisecondsSinceEpoch / 1000).floor().toString();

  String enc(String c) => Uri.encodeComponent(c);

  Map<String, String> getOauthParams() {
    var authorizationParams = <String, String>{
      'oauth_timestamp': timestamp,
      'oauth_nonce': _generateNonce(),
      'oauth_signature_method': signature.name,
      'oauth_consumer_key': consumer.identifier,
      'oauth_version': '1.0'
    };
    params.keys.map((k) => print('${k}\t\t= ${params[k]}'));
    if (params.containsKey('oauth_callback')) {
      params['oauth_callback'] = consumer.callbackUrl;
    }
    params.forEach((k, v) {
      if (k.startsWith('oauth')) {
        authorizationParams[k] = v;
      }
    });
    if (token != null) {
      authorizationParams['oauth_token'] = token.identifier;
    }
    params.addAll(authorizationParams);
    authorizationParams['oauth_signature'] = _generateSignature();
    return authorizationParams;
  }

  String getOauthString() {
    var _ = getOauthParams();
    return 'OAuth ' +
        _.keys.map((k) => '${k}="${enc(_[k])}"').toList().join(', ');
  }

  void initRequest(String method, String url) {
    params.clear();
    this.method = method;
    this.url = url.split('?')[0];
  }

  @override
  String toString() {
    return 'AuthorizationHeader(_consumer: $_consumer, method: $method, url: $url, params: $params, token: $token, signature: $signature)';
  }

  String _generateNonce() {
    var _ = Random();
    var values = List<int>.generate(32, (i) => _.nextInt(256));
    return base64Url.encode(values);
  }

  String _generateSignature() {
    var list = params.keys.map((k) => '${enc(k)}=${enc(params[k])}').toList()
      ..sort();
    var string = list.join('&');
    var base = '${method.toUpperCase()}&${enc(url)}&${enc(string)}';
    var tokenSecret = token == null ? '' : enc(token.secret);
    var key = '${enc(consumer.secret)}&$tokenSecret';
    return signature.sign(key, base);
  }
}
