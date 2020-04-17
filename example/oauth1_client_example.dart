//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// oauth1_client_example.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-17T19:32:46.193Z
// Modified: 2020-04-17T22:44:34.077Z
//

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:oauth1_client/oauth1_client.dart';

// Twitter Example
Future<http.Client> authorize() async {
  var consumer = ConsumerCredentials('api key', 'api secret');
  var oauth1 = OAuth1Client(consumer);
  oauth1.signatureMethod = Signatures.hmacSha1;
  await oauth1.fetchRequestToken('https://api.twitter.com/oauth/request_token');
  print(oauth1.getAuthorizationUrl('https://api.twitter.com/oauth/authorize'));
  var verifier = stdin.readLineSync();
  oauth1.token = await oauth1.fetchAccessToken(
      'https://api.twitter.com/oauth/access_token', verifier);
  return oauth1.client; //authorized client
}

void main() {
  authorize().then((client) {
    client.post('https://api.twitter.com/1.1/friendships/create.json',
        body: {'screen_name': 'mertcandinler0'});
  });
}
