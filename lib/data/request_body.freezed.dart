// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) {
  return _RequestBody.fromJson(json);
}

/// @nodoc
mixin _$RequestBody {
  String get path => throw _privateConstructorUsedError;
  Map<String, dynamic> get queries => throw _privateConstructorUsedError;

  /// Serializes this RequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequestBodyCopyWith<RequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestBodyCopyWith<$Res> {
  factory $RequestBodyCopyWith(
          RequestBody value, $Res Function(RequestBody) then) =
      _$RequestBodyCopyWithImpl<$Res, RequestBody>;
  @useResult
  $Res call({String path, Map<String, dynamic> queries});
}

/// @nodoc
class _$RequestBodyCopyWithImpl<$Res, $Val extends RequestBody>
    implements $RequestBodyCopyWith<$Res> {
  _$RequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? queries = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      queries: null == queries
          ? _value.queries
          : queries // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestBodyImplCopyWith<$Res>
    implements $RequestBodyCopyWith<$Res> {
  factory _$$RequestBodyImplCopyWith(
          _$RequestBodyImpl value, $Res Function(_$RequestBodyImpl) then) =
      __$$RequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, Map<String, dynamic> queries});
}

/// @nodoc
class __$$RequestBodyImplCopyWithImpl<$Res>
    extends _$RequestBodyCopyWithImpl<$Res, _$RequestBodyImpl>
    implements _$$RequestBodyImplCopyWith<$Res> {
  __$$RequestBodyImplCopyWithImpl(
      _$RequestBodyImpl _value, $Res Function(_$RequestBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? queries = null,
  }) {
    return _then(_$RequestBodyImpl(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      queries: null == queries
          ? _value._queries
          : queries // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RequestBodyImpl implements _RequestBody {
  const _$RequestBodyImpl(
      {required this.path, required final Map<String, dynamic> queries})
      : _queries = queries;

  factory _$RequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequestBodyImplFromJson(json);

  @override
  final String path;
  final Map<String, dynamic> _queries;
  @override
  Map<String, dynamic> get queries {
    if (_queries is EqualUnmodifiableMapView) return _queries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_queries);
  }

  @override
  String toString() {
    return 'RequestBody(path: $path, queries: $queries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestBodyImpl &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other._queries, _queries));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, path, const DeepCollectionEquality().hash(_queries));

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestBodyImplCopyWith<_$RequestBodyImpl> get copyWith =>
      __$$RequestBodyImplCopyWithImpl<_$RequestBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestBodyImplToJson(
      this,
    );
  }
}

abstract class _RequestBody implements RequestBody {
  const factory _RequestBody(
      {required final String path,
      required final Map<String, dynamic> queries}) = _$RequestBodyImpl;

  factory _RequestBody.fromJson(Map<String, dynamic> json) =
      _$RequestBodyImpl.fromJson;

  @override
  String get path;
  @override
  Map<String, dynamic> get queries;

  /// Create a copy of RequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestBodyImplCopyWith<_$RequestBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
