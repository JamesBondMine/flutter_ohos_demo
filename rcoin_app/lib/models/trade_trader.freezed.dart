// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trade_trader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TradeTrader _$TradeTraderFromJson(Map<String, dynamic> json) {
  return _TradeTrader.fromJson(json);
}

/// @nodoc
mixin _$TradeTrader {
  String? get email => throw _privateConstructorUsedError;
  String? get headerImg => throw _privateConstructorUsedError;
  String? get nickName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TradeTraderCopyWith<TradeTrader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TradeTraderCopyWith<$Res> {
  factory $TradeTraderCopyWith(
          TradeTrader value, $Res Function(TradeTrader) then) =
      _$TradeTraderCopyWithImpl<$Res, TradeTrader>;
  @useResult
  $Res call({String? email, String? headerImg, String? nickName});
}

/// @nodoc
class _$TradeTraderCopyWithImpl<$Res, $Val extends TradeTrader>
    implements $TradeTraderCopyWith<$Res> {
  _$TradeTraderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? headerImg = freezed,
    Object? nickName = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      headerImg: freezed == headerImg
          ? _value.headerImg
          : headerImg // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TradeTraderImplCopyWith<$Res>
    implements $TradeTraderCopyWith<$Res> {
  factory _$$TradeTraderImplCopyWith(
          _$TradeTraderImpl value, $Res Function(_$TradeTraderImpl) then) =
      __$$TradeTraderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? headerImg, String? nickName});
}

/// @nodoc
class __$$TradeTraderImplCopyWithImpl<$Res>
    extends _$TradeTraderCopyWithImpl<$Res, _$TradeTraderImpl>
    implements _$$TradeTraderImplCopyWith<$Res> {
  __$$TradeTraderImplCopyWithImpl(
      _$TradeTraderImpl _value, $Res Function(_$TradeTraderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? headerImg = freezed,
    Object? nickName = freezed,
  }) {
    return _then(_$TradeTraderImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      headerImg: freezed == headerImg
          ? _value.headerImg
          : headerImg // ignore: cast_nullable_to_non_nullable
              as String?,
      nickName: freezed == nickName
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TradeTraderImpl implements _TradeTrader {
  const _$TradeTraderImpl({this.email, this.headerImg, this.nickName});

  factory _$TradeTraderImpl.fromJson(Map<String, dynamic> json) =>
      _$$TradeTraderImplFromJson(json);

  @override
  final String? email;
  @override
  final String? headerImg;
  @override
  final String? nickName;

  @override
  String toString() {
    return 'TradeTrader(email: $email, headerImg: $headerImg, nickName: $nickName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TradeTraderImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.headerImg, headerImg) ||
                other.headerImg == headerImg) &&
            (identical(other.nickName, nickName) ||
                other.nickName == nickName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, headerImg, nickName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TradeTraderImplCopyWith<_$TradeTraderImpl> get copyWith =>
      __$$TradeTraderImplCopyWithImpl<_$TradeTraderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TradeTraderImplToJson(
      this,
    );
  }
}

abstract class _TradeTrader implements TradeTrader {
  const factory _TradeTrader(
      {final String? email,
      final String? headerImg,
      final String? nickName}) = _$TradeTraderImpl;

  factory _TradeTrader.fromJson(Map<String, dynamic> json) =
      _$TradeTraderImpl.fromJson;

  @override
  String? get email;
  @override
  String? get headerImg;
  @override
  String? get nickName;
  @override
  @JsonKey(ignore: true)
  _$$TradeTraderImplCopyWith<_$TradeTraderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
