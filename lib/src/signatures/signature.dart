//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// signature.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:35:44.911Z
// Modified: 2020-04-17T22:36:41.249Z
//

/// An abstract class for signatures
abstract class Signature {
  final String _name;

  Signature(this._name);

  String get name => _name;

  String sign(String key, String string);

  @override
  String toString() => 'Signature(name: $_name)';
}
