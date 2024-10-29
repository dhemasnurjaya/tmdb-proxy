// ignore_for_file: public_member_api_docs

import 'package:tmdb_proxy/auth/simple_auth.dart';
import 'package:tmdb_proxy/auth/simple_auth_rsa.dart';
import 'package:tmdb_proxy/auth/time.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:tmdb_proxy/network/network.dart';

/// A container for dependency injection.
class InjectionContainer {
  factory InjectionContainer() {
    return _instance;
  }

  InjectionContainer._internal();
  static final InjectionContainer _instance = InjectionContainer._internal();

  Env? _env;
  Network? _network;
  Time? _time;
  SimpleAuth? _simpleAuth;

  /// [Env] instance, used for environment variables.
  Env get env => _env ??= EnvImpl();

  /// [Network] instance, used for network operations.
  Network get network => _network ??= NetworkImpl();

  /// [Time] instance, used for time operations.
  Time get time => _time ??= TimeImpl();

  /// [SimpleAuth] instance, used for authentication.
  SimpleAuth get simpleAuth => _simpleAuth ??= SimpleAuthRSA(
        env: env,
        time: time,
      );
}
