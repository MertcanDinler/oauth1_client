//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// Consumer.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:22:04.838Z
// Modified: 2020-04-17T22:35:59.351Z
//

import 'credentials.dart';

class ConsumerCredentials extends Credentials {
  String callbackUrl;
  ConsumerCredentials(String identifier, String secret, {callbackUrl = 'oob'})
      : super(identifier, secret) {
    this.callbackUrl = callbackUrl;
  }
}
