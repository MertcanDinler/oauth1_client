//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// hmac_sha1.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:38:03.000Z
// Modified: 2020-04-17T22:46:45.900Z
//

import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'signature.dart';

/// HmacSha1 Signature
class HmacSha1 extends Signature {
  HmacSha1() : super('HMAC-SHA1');

  @override
  String sign(String key, String string) {
    var hmac = Hmac(sha1, utf8.encode(key));
    var digest = hmac.convert(utf8.encode(string));
    return base64.encode(digest.bytes);
  }
}
