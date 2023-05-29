// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'read_tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReadTagState {
  String? get details => throw _privateConstructorUsedError;
  CallStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReadTagStateCopyWith<ReadTagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadTagStateCopyWith<$Res> {
  factory $ReadTagStateCopyWith(
          ReadTagState value, $Res Function(ReadTagState) then) =
      _$ReadTagStateCopyWithImpl<$Res, ReadTagState>;
  @useResult
  $Res call({String? details, CallStatus status});
}

/// @nodoc
class _$ReadTagStateCopyWithImpl<$Res, $Val extends ReadTagState>
    implements $ReadTagStateCopyWith<$Res> {
  _$ReadTagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? details = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReadTagStateCopyWith<$Res>
    implements $ReadTagStateCopyWith<$Res> {
  factory _$$_ReadTagStateCopyWith(
          _$_ReadTagState value, $Res Function(_$_ReadTagState) then) =
      __$$_ReadTagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? details, CallStatus status});
}

/// @nodoc
class __$$_ReadTagStateCopyWithImpl<$Res>
    extends _$ReadTagStateCopyWithImpl<$Res, _$_ReadTagState>
    implements _$$_ReadTagStateCopyWith<$Res> {
  __$$_ReadTagStateCopyWithImpl(
      _$_ReadTagState _value, $Res Function(_$_ReadTagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? details = freezed,
    Object? status = null,
  }) {
    return _then(_$_ReadTagState(
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CallStatus,
    ));
  }
}

/// @nodoc

class _$_ReadTagState implements _ReadTagState {
  const _$_ReadTagState({required this.details, required this.status});

  @override
  final String? details;
  @override
  final CallStatus status;

  @override
  String toString() {
    return 'ReadTagState(details: $details, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReadTagState &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, details, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReadTagStateCopyWith<_$_ReadTagState> get copyWith =>
      __$$_ReadTagStateCopyWithImpl<_$_ReadTagState>(this, _$identity);
}

abstract class _ReadTagState implements ReadTagState {
  const factory _ReadTagState(
      {required final String? details,
      required final CallStatus status}) = _$_ReadTagState;

  @override
  String? get details;
  @override
  CallStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_ReadTagStateCopyWith<_$_ReadTagState> get copyWith =>
      throw _privateConstructorUsedError;
}
