//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// signatures.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T13:49:00.310Z
// Modified: 2020-04-17T22:47:44.363Z
//
import 'signatures/hmac_sha1.dart';
import 'signatures/plain_text.dart';
import 'signatures/signature.dart';

class Signatures {
  static final Signature plainText = PlainText();
  static final Signature hmacSha1 = HmacSha1();
}
