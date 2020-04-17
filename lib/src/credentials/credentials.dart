//
// Author: Mertcan Dinler (mertdinlerin@gmail.com)
// credentals.dart (c) 2020
//
// This software is released under the MIT License.
// https://raw.githubusercontent.com/mrtcndnlr/oauth1_client/master/LICENSE
//
// Created:  2020-04-16T09:23:17.705Z
// Modified: 2020-04-17T22:36:08.022Z
//

abstract class Credentials {
  /// The credentials identifier.
  final String _identifier;

  /// The credentials secret.
  final String _secret;

  /// A constructor for credentials
  /// @param identifier
  /// @param secret
  Credentials(this._identifier, this._secret);

  /// The credentials identifier getter.
  String get identifier => _identifier;

  /// The credentials secret getter.
  String get secret => _secret;

  @override
  String toString() =>
      'Credentials(identifier: $_identifier, secret: $_secret)';
}
