import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:tmdb_proxy/auth/simple_auth.dart';
import 'package:tmdb_proxy/auth/time.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:uuid/validation.dart';

/// Simple auth implementation using RSA.
/// Client will send a base64 UUID encrypted with public key, then the server
/// will decrypt it with private key and check if the UUID is valid.
class SimpleAuthRSA implements SimpleAuth {
  /// Creates a new [SimpleAuthRSA] instance.
  SimpleAuthRSA({
    required Env env,
    required Time time,
  })  : _env = env,
        _time = time;

  final Env _env;
  final Time _time;

  @override
  String? decryptToken(String token) {
    // read private key
    final keyBytes = base64.decode(_env.authPrivateKey);
    final keyParser = RSAKeyParser();
    final rsaPrivateKey =
        keyParser.parse(utf8.decode(keyBytes)) as RSAPrivateKey;

    // decrypt token
    final encrypter = Encrypter(RSA(privateKey: rsaPrivateKey));
    try {
      final decryptedToken = encrypter.decrypt64(token);
      return decryptedToken;
    } catch (e) {
      return null;
    }
  }

  @override
  bool isTokenValid(String decryptedToken) {
    // check if token is a valid UUID
    return UuidValidation.isValidUUID(fromString: decryptedToken);
  }

  @override
  bool isTokenExpired(int issuedAt) {
    const tokenLifetimeSeconds = 300;
    const allowedDriftSeconds = 10;

    final now = _time.getUnixTimestamp();
    final diff = now - issuedAt;

    return diff < -allowedDriftSeconds ||
        diff > (tokenLifetimeSeconds + allowedDriftSeconds);
  }
}
