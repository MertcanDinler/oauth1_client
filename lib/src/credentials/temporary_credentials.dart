//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// temporary_credentials.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-17T16:43:14.282Z
// Modified: 2020-04-17T22:36:12.542Z
//

import 'credentials.dart';

class TemporaryCredentials extends Credentials {
  TemporaryCredentials(String identifier, String secret)
      : super(identifier, secret);
  factory TemporaryCredentials.fromResponse(String str) {
    var map = Uri.splitQueryString(str);
    return TemporaryCredentials(map['oauth_token'], map['oauth_token_secret']);
  }
}
