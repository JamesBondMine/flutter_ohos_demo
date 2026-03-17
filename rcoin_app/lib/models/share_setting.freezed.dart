// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShareSetting _$ShareSettingFromJson(Map<String, dynamic> json) {
  return _ShareSetting.fromJson(json);
}

/// @nodoc
mixin _$ShareSetting {
  double? get limit => throw _privateConstructorUsedError;
  double? get reward => throw _privateConstructorUsedError;
  String? get rewardSetting => throw _privateConstructorUsedError;
  @JsonKey(name: "ShareUrl")
  String? get shareUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShareSettingCopyWith<ShareSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareSettingCopyWith<$Res> {
  factory $ShareSettingCopyWith(
          ShareSetting value, $Res Function(ShareSetting) then) =
      _$ShareSettingCopyWithImpl<$Res, ShareSetting>;
  @useResult
  $Res call(
      {double? limit,
      double? reward,
      String? rewardSetting,
      @JsonKey(name: "ShareUrl") String? shareUrl});
}

/// @nodoc
class _$ShareSettingCopyWithImpl<$Res, $Val extends ShareSetting>
    implements $ShareSettingCopyWith<$Res> {
  _$ShareSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = freezed,
    Object? reward = freezed,
    Object? rewardSetting = freezed,
    Object? shareUrl = freezed,
  }) {
    return _then(_value.copyWith(
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double?,
      reward: freezed == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardSetting: freezed == rewardSetting
          ? _value.rewardSetting
          : rewardSetting // ignore: cast_nullable_to_non_nullable
              as String?,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareSettingImplCopyWith<$Res>
    implements $ShareSettingCopyWith<$Res> {
  factory _$$ShareSettingImplCopyWith(
          _$ShareSettingImpl value, $Res Function(_$ShareSettingImpl) then) =
      __$$ShareSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? limit,
      double? reward,
      String? rewardSetting,
      @JsonKey(name: "ShareUrl") String? shareUrl});
}

/// @nodoc
class __$$ShareSettingImplCopyWithImpl<$Res>
    extends _$ShareSettingCopyWithImpl<$Res, _$ShareSettingImpl>
    implements _$$ShareSettingImplCopyWith<$Res> {
  __$$ShareSettingImplCopyWithImpl(
      _$ShareSettingImpl _value, $Res Function(_$ShareSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? limit = freezed,
    Object? reward = freezed,
    Object? rewardSetting = freezed,
    Object? shareUrl = freezed,
  }) {
    return _then(_$ShareSettingImpl(
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double?,
      reward: freezed == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardSetting: freezed == rewardSetting
          ? _value.rewardSetting
          : rewardSetting // ignore: cast_nullable_to_non_nullable
              as String?,
      shareUrl: freezed == shareUrl
          ? _value.shareUrl
          : shareUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareSettingImpl implements _ShareSetting {
  const _$ShareSettingImpl(
      {this.limit,
      this.reward,
      this.rewardSetting,
      @JsonKey(name: "ShareUrl") this.shareUrl});

  factory _$ShareSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareSettingImplFromJson(json);

  @override
  final double? limit;
  @override
  final double? reward;
  @override
  final String? rewardSetting;
  @override
  @JsonKey(name: "ShareUrl")
  final String? shareUrl;

  @override
  String toString() {
    return 'ShareSetting(limit: $limit, reward: $reward, rewardSetting: $rewardSetting, shareUrl: $shareUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareSettingImpl &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.reward, reward) || other.reward == reward) &&
            (identical(other.rewardSetting, rewardSetting) ||
                other.rewardSetting == rewardSetting) &&
            (identical(other.shareUrl, shareUrl) ||
                other.shareUrl == shareUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, limit, reward, rewardSetting, shareUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareSettingImplCopyWith<_$ShareSettingImpl> get copyWith =>
      __$$ShareSettingImplCopyWithImpl<_$ShareSettingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareSettingImplToJson(
      this,
    );
  }
}

abstract class _ShareSetting implements ShareSetting {
  const factory _ShareSetting(
      {final double? limit,
      final double? reward,
      final String? rewardSetting,
      @JsonKey(name: "ShareUrl") final String? shareUrl}) = _$ShareSettingImpl;

  factory _ShareSetting.fromJson(Map<String, dynamic> json) =
      _$ShareSettingImpl.fromJson;

  @override
  double? get limit;
  @override
  double? get reward;
  @override
  String? get rewardSetting;
  @override
  @JsonKey(name: "ShareUrl")
  String? get shareUrl;
  @override
  @JsonKey(ignore: true)
  _$$ShareSettingImplCopyWith<_$ShareSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
