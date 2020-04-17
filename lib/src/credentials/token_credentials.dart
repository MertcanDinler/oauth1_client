//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// token.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:25:50.965Z
// Modified: 2020-04-17T22:36:16.015Z
//

import 'credentials.dart';

class TokenCredentials extends Credentials {
  TokenCredentials(String identifier, String secret)
      : super(identifier, secret);

  factory TokenCredentials.fromResponse(String str) {
    var map = Uri.splitQueryString(str);
    return TokenCredentials(map['oauth_token'], map['oauth_token_secret']);
  }
}
