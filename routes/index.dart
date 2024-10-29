import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:tmdb_proxy/error/error_response.dart';
import 'package:tmdb_proxy/network/network.dart';

const _baseUrl = 'https://api.themoviedb.org/3';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (request.method == HttpMethod.get) {
    final env = context.read<Env>();
    final network = context.read<Network>();

    final path = request.uri.queryParameters['path'];
    final query = request.uri.queryParameters['query'];
    final requestUrl = StringBuffer(_baseUrl);

    if (path == null) {
      return Response.json(
        body: {'message': 'Hi!'},
      );
    }

    // Append the path to the base URL
    if (path.startsWith('/')) {
      requestUrl.write(path);
    } else {
      requestUrl.write('/$path');
    }

    // Append the API key to the URL
    requestUrl.write('?api_key=${env.tmdbApiKey}');

    // Add any query parameters to the URL
    if (query != null) {
      requestUrl.write('&$query');
    }

    final uri = Uri.parse(requestUrl.toString());

    try {
      final result = await network.get(uri);
      final headers = Map.of(result.headers)..remove('transfer-encoding');
      return Response(
        statusCode: result.statusCode,
        body: result.body,
        headers: headers,
      );
    } on Exception catch (e) {
      return Response.json(
        statusCode: HttpStatus.internalServerError,
        body: ErrorResponse(
          message: e.toString(),
          code: HttpStatus.internalServerError,
        ).toJson(),
      );
    }
  }

  return Response.json(
    statusCode: HttpStatus.methodNotAllowed,
    body: const ErrorResponse(
      message: 'Method not allowed',
      code: HttpStatus.methodNotAllowed,
    ).toJson(),
  );
}
