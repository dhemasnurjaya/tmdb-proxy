import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_body.freezed.dart';
part 'request_body.g.dart';

/// Used to parse the request body from a POST request.
/// [path] is the path of TMDB API endpoint.
/// [queries] are the query parameters to be sent to the endpoint.
@freezed
class RequestBody with _$RequestBody {
  /// Create a [RequestBody] object.
  const factory RequestBody({
    required String path,
    required Map<String, dynamic> queries,
  }) = _RequestBody;

  /// Create a [RequestBody] object from a JSON object.
  factory RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestBodyFromJson(json);
}
