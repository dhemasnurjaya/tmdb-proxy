/// Represents the authentication token for each request.
class AuthModel {
  /// Create a new [AuthModel].
  const AuthModel({
    required this.token,
    required this.issuedAt,
  });

  /// Create a new [AuthModel] from a JSON object.
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      issuedAt: json['issuedAt'] as int,
    );
  }

  /// An UUID string, unique per request.
  final String token;

  /// Unix time in seconds. It is the time when the token was issued.
  /// Will expire after a time window.
  final int issuedAt;
}
