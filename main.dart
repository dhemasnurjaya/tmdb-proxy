import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tmdb_proxy/auth/simple_auth.dart';
import 'package:tmdb_proxy/env.dart';
import 'package:tmdb_proxy/injection_container.dart';
import 'package:tmdb_proxy/network/network.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  // injection container
  final ic = InjectionContainer();

  return serve(
    handler.use(
      provider<Env>((context) {
        return ic.env;
      }),
    ).use(
      provider<Network>(
        (context) {
          return ic.network;
        },
      ),
    ).use(
      provider<SimpleAuth>((context) {
        return ic.simpleAuth;
      }),
    ),
    ip,
    port,
  );
}
