// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BillPhoto _$BillPhotoFromJson(Map<String, dynamic> json) {
  return _BillPhoto.fromJson(json);
}

/// @nodoc
mixin _$BillPhoto {
  int? get id => throw _privateConstructorUsedError;
  Bill? get bill => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get blurhash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillPhotoCopyWith<BillPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillPhotoCopyWith<$Res> {
  factory $BillPhotoCopyWith(BillPhoto value, $Res Function(BillPhoto) then) =
      _$BillPhotoCopyWithImpl<$Res, BillPhoto>;
  @useResult
  $Res call(
      {int? id, Bill? bill, String? name, String? path, String? blurhash});

  $BillCopyWith<$Res>? get bill;
}

/// @nodoc
class _$BillPhotoCopyWithImpl<$Res, $Val extends BillPhoto>
    implements $BillPhotoCopyWith<$Res> {
  _$BillPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bill = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? blurhash = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bill: freezed == bill
          ? _value.bill
          : bill // ignore: cast_nullable_to_non_nullable
              as Bill?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      blurhash: freezed == blurhash
          ? _value.blurhash
          : blurhash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BillCopyWith<$Res>? get bill {
    if (_value.bill == null) {
      return null;
    }

    return $BillCopyWith<$Res>(_value.bill!, (value) {
      return _then(_value.copyWith(bill: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BillPhotoImplCopyWith<$Res>
    implements $BillPhotoCopyWith<$Res> {
  factory _$$BillPhotoImplCopyWith(
          _$BillPhotoImpl value, $Res Function(_$BillPhotoImpl) then) =
      __$$BillPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, Bill? bill, String? name, String? path, String? blurhash});

  @override
  $BillCopyWith<$Res>? get bill;
}

/// @nodoc
class __$$BillPhotoImplCopyWithImpl<$Res>
    extends _$BillPhotoCopyWithImpl<$Res, _$BillPhotoImpl>
    implements _$$BillPhotoImplCopyWith<$Res> {
  __$$BillPhotoImplCopyWithImpl(
      _$BillPhotoImpl _value, $Res Function(_$BillPhotoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? bill = freezed,
    Object? name = freezed,
    Object? path = freezed,
    Object? blurhash = freezed,
  }) {
    return _then(_$BillPhotoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      bill: freezed == bill
          ? _value.bill
          : bill // ignore: cast_nullable_to_non_nullable
              as Bill?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      blurhash: freezed == blurhash
          ? _value.blurhash
          : blurhash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BillPhotoImpl extends _BillPhoto {
  _$BillPhotoImpl({this.id, this.bill, this.name, this.path, this.blurhash})
      : super._();

  factory _$BillPhotoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BillPhotoImplFromJson(json);

  @override
  final int? id;
  @override
  final Bill? bill;
  @override
  final String? name;
  @override
  final String? path;
  @override
  final String? blurhash;

  @override
  String toString() {
    return 'BillPhoto(id: $id, bill: $bill, name: $name, path: $path, blurhash: $blurhash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BillPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.bill, bill) || other.bill == bill) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.blurhash, blurhash) ||
                other.blurhash == blurhash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, bill, name, path, blurhash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BillPhotoImplCopyWith<_$BillPhotoImpl> get copyWith =>
      __$$BillPhotoImplCopyWithImpl<_$BillPhotoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BillPhotoImplToJson(
      this,
    );
  }
}

abstract class _BillPhoto extends BillPhoto {
  factory _BillPhoto(
      {final int? id,
      final Bill? bill,
      final String? name,
      final String? path,
      final String? blurhash}) = _$BillPhotoImpl;
  _BillPhoto._() : super._();

  factory _BillPhoto.fromJson(Map<String, dynamic> json) =
      _$BillPhotoImpl.fromJson;

  @override
  int? get id;
  @override
  Bill? get bill;
  @override
  String? get name;
  @override
  String? get path;
  @override
  String? get blurhash;
  @override
  @JsonKey(ignore: true)
  _$$BillPhotoImplCopyWith<_$BillPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
