import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tmdb_proxy/data/request_body.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:tmdb_proxy/error/error_response.dart';
import 'package:tmdb_proxy/network/network.dart';

const _baseUrl = 'https://api.themoviedb.org/3';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (request.method == HttpMethod.post) {
    final env = context.read<Env>();
    final network = context.read<Network>();

    final requestBody = RequestBody.fromJson(
      jsonDecode(await request.body()) as Map<String, dynamic>,
    );
    final requestUrl = StringBuffer(_baseUrl);

    if (requestBody.path.isEmpty) {
      return Response.json(
        body: {'message': 'Hi!'},
      );
    }

    // Append the path to the base URL
    if (requestBody.path.startsWith('/')) {
      requestUrl.write(requestBody.path);
    } else {
      requestUrl.write('/${requestBody.path}');
    }

    // Append the API key to the URL
    requestUrl.write('?api_key=${env.tmdbApiKey}');

    // Add any query parameters to the URL
    if (requestBody.queries.isNotEmpty) {
      final queries =
          requestBody.queries.entries.map((e) => '${e.key}=${e.value}');
      requestUrl.write('&${queries.join('&')}');
    }

    try {
      final uri = Uri.parse(requestUrl.toString());
      final result = await network.get(uri);
      final body = jsonDecode(result.body) as Map<String, dynamic>;
      final headers = Map.of(result.headers)
        ..remove('transfer-encoding')
        ..remove('content-encoding');
      return Response.json(
        statusCode: result.statusCode,
        body: body,
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
