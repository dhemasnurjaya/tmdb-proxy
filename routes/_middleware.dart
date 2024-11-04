import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';

import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;
import 'package:tmdb_proxy/auth/auth_model.dart';
import 'package:tmdb_proxy/auth/simple_auth.dart';

Handler middleware(Handler handler) {
  // chain the middlewares
  return handler.use(_authCheck).use(requestLogger()).use(_cors);
}

Handler _cors(Handler handler) {
  return handler.use(
    fromShelfMiddleware(
      shelf.corsHeaders(
        headers: {
          shelf.ACCESS_CONTROL_ALLOW_ORIGIN: 'https://tmdb.dhemasnurjaya.com',
        },
      ),
    ),
  );
}

Handler _authCheck(Handler handler) {
  return handler.use(
    bearerAuthentication<bool>(
      authenticator: (context, token) async {
        final authenticator = context.read<SimpleAuth>();

        try {
          final decryptedToken = authenticator.decryptToken(token);
          if (decryptedToken == null) {
            throw Exception('Unable to decrypt token');
          }

          final authJson = jsonDecode(decryptedToken) as Map<String, dynamic>;
          final authModel = AuthModel.fromJson(authJson);

          final isTokenValid = authenticator.isTokenValid(authModel.token);
          final isTokenExpired =
              authenticator.isTokenExpired(authModel.issuedAt);

          if (isTokenValid && !isTokenExpired) {
            return true;
          }

          throw Exception('Token is invalid or expired');
        } on Exception catch (_) {
          return null;
        }
      },
    ),
  );
}
