import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tmdb_proxy/data/request_body.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:tmdb_proxy/error/error_response.dart';
import 'package:tmdb_proxy/network/network.dart';

import '../../routes/index.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

class MockEnv extends Mock implements Env {}

class MockNetwork extends Mock implements Network {}

void main() {
  late MockRequestContext mockContext;
  late MockEnv mockEnv;
  late MockNetwork mockNetwork;

  setUp(() {
    mockContext = MockRequestContext();
    mockEnv = MockEnv();
    mockNetwork = MockNetwork();

    registerFallbackValue(Uri.parse('http://test.com/'));
  });

  test('should return 405 when request method is not POST', () async {
    // arrange
    final tExpectedResponse = Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: const ErrorResponse(
        message: 'Method not allowed',
        code: HttpStatus.methodNotAllowed,
      ).toJson(),
    );
    when(() => mockContext.request).thenReturn(
      Request(
        'GET',
        Uri.parse('http://test.com/'),
      ),
    );

    // act
    final response = await route.onRequest(mockContext);

    // assert
    final tBody = await response.body();
    final tExpectedBody = await tExpectedResponse.body();
    expect(response.statusCode, HttpStatus.methodNotAllowed);
    expect(tBody, tExpectedBody);
  });

  test('should return 500 when an error occurs', () async {
    // Arrange
    final tException = Exception('Exception');
    final tExpectedResponse = Response.json(
      statusCode: HttpStatus.internalServerError,
      body: ErrorResponse(
        message: tException.toString(),
        code: HttpStatus.internalServerError,
      ).toJson(),
    );

    when(() => mockContext.read<Env>()).thenReturn(mockEnv);
    when(() => mockContext.read<Network>()).thenReturn(mockNetwork);
    when(() => mockContext.request).thenReturn(
      Request(
        'POST',
        Uri.http('test.com', '/'),
        body:
            jsonEncode(const RequestBody(path: '/test', queries: {}).toJson()),
      ),
    );
    when(() => mockEnv.tmdbApiKey).thenReturn('api_key');
    when(() => mockNetwork.get(any()))
        .thenAnswer((_) async => Future.error(tException));

    // Act
    final response = await route.onRequest(mockContext);

    // Assert
    final tBody = await response.body();
    final tExpectedBody = await tExpectedResponse.body();
    expect(response.statusCode, HttpStatus.internalServerError);
    expect(tBody, tExpectedBody);
  });

  test('should return 200 when request method is POST', () async {
    // arrange
    final tExpectedResponse = Response.json(
      body: {'message': 'Hi!'},
    );
    when(() => mockContext.read<Env>()).thenReturn(mockEnv);
    when(() => mockContext.read<Network>()).thenReturn(MockNetwork());
    when(() => mockContext.request).thenReturn(
      Request(
        'POST',
        Uri.parse('http://test.com/'),
        body: jsonEncode(const RequestBody(path: '', queries: {}).toJson()),
      ),
    );

    // act
    final response = await route.onRequest(mockContext);

    // assert
    final tBody = await response.body();
    final tExpectedBody = await tExpectedResponse.body();
    expect(response.statusCode, HttpStatus.ok);
    expect(tBody, tExpectedBody);
  });
}
