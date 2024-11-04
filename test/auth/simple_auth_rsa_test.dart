import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tmdb_proxy/auth/simple_auth_rsa.dart';
import 'package:tmdb_proxy/auth/time.dart';
import 'package:tmdb_proxy/env.dart';

class MockEnv extends Mock implements EnvImpl {}

class MockTime extends Mock implements Time {}

void main() {
  late MockEnv mockEnv;
  late MockTime mockTime;
  late SimpleAuthRSA rsaAuth;

  setUp(() {
    mockEnv = MockEnv();
    mockTime = MockTime();
    rsaAuth = SimpleAuthRSA(
      env: mockEnv,
      time: mockTime,
    );
  });

  test('should decrypt token with private key', () {
    // arrange
    const tPrivKey =
        'LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlDWEFJQkFBS0JnUURFUE8yc3'
        'RjQVoxN0UxQmhQMllNSGZRa0RVSWI1a1VwSzhSdlR5QzlHR0RhNG5hampaCkR2TzB6b0lD'
        'dmlqWjZOT3kvTTUrSTYwNWt3QkdMV3Q0eWE3SThEUjE5aElzUHFUU2NjRmt6NDZOSmpjd'
        'FNDbHQKZTJtOUtuY3NnN2hkMFJ1UGRxYjhXWTB1OWNNZzFnK0xFTVBvbm15d2t6TTBlVGd'
        '6aDBFT3ZRamVUUUlEQVFBQgpBb0dBSTZUdGh2RjhjelU2ZXVjZnVTRGFGak55a3hXTi82c'
        'i8vRExuU3cvYWZ2NzlJeXVvSjhVUGYwZ0RWWHcwCjcxL2JGQ2ZYV2hJZzVOUk91SENIbE9'
        'rTlZpRGQ2by9KNkNEeXkrdjRqaTc0QVNyd2JhempzL1Q1dmhFMjhPaFYKOWhHdlVERmpUT'
        'VZja0d3V0Yrb1RKSEl1UWcxZkRxS0Q0OXRWWDloT3pWd21FQUVDUVFEaUtFZTg1QjdQQUF'
        'aeAo5b2pvRlM2MElwbXd5NW1ad3FxSU9RdXp6ZnUydTNiTVdGRHpzejdVK2pmVGJBVkt2M'
        'Vp6UWVrcW85Y1hVVzVoCnZjanpDVE9GQWtFQTNpSDB6M01MSTEyamJHMWtzRW1KdkxaMHJ'
        'tUUF4U1NaUjZQdWwxWjE1VVUzbmpCdDl0clkKaTArMHRLTTExTUZpRnkrdW1iWEQ3ODk1M'
        'TI4eG1MaUdLUUpCQUxmNWJvcEJ4TEk5NGdCWlBud1ZwejJRbkJnUApPRysxeFVZMXFjaG1'
        'PMnNtU3ZqbXEwdmtONnZIdFJ3L1ZucTg5aFdpdTR3ZFpqOG8xak9hME5xc1ZJVUNRQzZGC'
        'jhoNFl2RFoyQUNwUFp3MDgrYW9hbEttSnJGZWQ2TFNHY3d3alFhSDVNMExnWmNlVDRsS2J'
        'LUC9FUnh2K1BLc2EKZzNrU0JxMk5TTG1FUW1ENEZMRUNRR3UwWThSSCtyQkdXT1ZLV2NNT'
        'UtHZzZqYkZ5cUVoSFovMER3ZWNGRElWWgpUR01IMGJPcjJaTjV3S1dSZ01CMUd4dzAzRGN'
        'QY1F0VXNlZU1xK1hHa3c4PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQ==';
    const tToken =
        'VwG7aAQ+8cbfyHuHAJzJeq2n9bQnJ1v/OiQQfWuQvtw0voQkbCYGsT0kWI3hHmJDQ6q2v0'
        'L8Lrx4AwGzqJXNlhH/P6YGXykGabD8N/5ROWoRc5cCemP1EESyZLk531LSPEg4tFkWN1ML'
        'U/4As7Jif4nVbkfwJznDaspjb5evF6s=';
    const tDecryptedToken = '94bccf9c-7ca4-4f2d-86ce-1f9f03ebf34f';

    when(() => mockEnv.authPrivateKey).thenReturn(tPrivKey);

    // act
    final decryptedToken = rsaAuth.decryptToken(tToken);

    // assert
    expect(decryptedToken, tDecryptedToken);
  });

  group('isTokenValid', () {
    test('should return false when token is not valid', () {
      // arrange
      const tToken = 'invalid-token';
      // act
      final isValid = rsaAuth.isTokenValid(tToken);
      // assert
      expect(isValid, false);
    });

    test('should return true when token is valid', () {
      // arrange
      const tToken = '94bccf9c-7ca4-4f2d-86ce-1f9f03ebf34f';
      // act
      final isValid = rsaAuth.isTokenValid(tToken);
      // assert
      expect(isValid, true);
    });
  });

  group('isTokenExpired', () {
    const tIssuedAt = 1630000000;
    const tTokenLifetimeSeconds = 300;
    const tAllowedDriftSeconds = 10;

    test('should not expired', () {
      // arrange
      when(() => mockTime.getUnixTimestamp()).thenReturn(tIssuedAt);
      // act
      final isExpired = rsaAuth.isTokenExpired(tIssuedAt);
      // assert
      expect(isExpired, false);
    });

    test('should not expired with positive drift', () {
      // arrange
      when(() => mockTime.getUnixTimestamp())
          .thenReturn(tIssuedAt + tTokenLifetimeSeconds);
      // act
      final isExpired = rsaAuth.isTokenExpired(tIssuedAt);
      // assert
      expect(isExpired, false);
    });

    test('should not expired with negative drift', () {
      // arrange
      when(() => mockTime.getUnixTimestamp())
          .thenReturn(tIssuedAt - tAllowedDriftSeconds);
      // act
      final isExpired = rsaAuth.isTokenExpired(tIssuedAt);
      // assert
      expect(isExpired, false);
    });

    test('should expired with positive drift', () {
      // arrange
      when(() => mockTime.getUnixTimestamp()).thenReturn(
        tIssuedAt + tTokenLifetimeSeconds + tAllowedDriftSeconds + 1,
      );
      // act
      final isExpired = rsaAuth.isTokenExpired(tIssuedAt);
      // assert
      expect(isExpired, true);
    });

    test('should expired with negative drift', () {
      // arrange
      when(() => mockTime.getUnixTimestamp())
          .thenReturn(tIssuedAt - tAllowedDriftSeconds - 1);
      // act
      final isExpired = rsaAuth.isTokenExpired(tIssuedAt);
      // assert
      expect(isExpired, true);
    });
  });
}
