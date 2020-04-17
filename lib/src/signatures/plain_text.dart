//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// plain_text.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:40:55.656Z
// Modified: 2020-04-17T22:46:46.876Z
//

import 'signature.dart';

/// Plaintext signature
class PlainText extends Signature {
  PlainText() : super('PLAINTEXT');

  @override
  String sign(String key, _) {
    return key;
  }
}
