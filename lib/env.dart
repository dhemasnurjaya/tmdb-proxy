// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:envied/envied.dart';

part 'env.g.dart';

abstract class Env {
  String get tmdbApiKey;
  String get authPrivateKey;
}

@Envied(path: '.env')
class EnvImpl implements Env {
  @EnviedField(varName: 'TMDB_API_KEY', obfuscate: true)
  static final String _tmdbApiKey = _EnvImpl._tmdbApiKey;

  @EnviedField(varName: 'AUTH_PRIVATE_KEY', obfuscate: true)
  static final String _authPrivateKey = _EnvImpl._authPrivateKey;

  @override
  String get tmdbApiKey => Platform.environment['TMDB_API_KEY'] ?? _tmdbApiKey;

  @override
  String get authPrivateKey =>
      Platform.environment['AUTH_PRIVATE_KEY'] ?? _authPrivateKey;
}
