// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bill _$BillFromJson(Map<String, dynamic> json) {
  return _Bill.fromJson(json);
}

/// @nodoc
mixin _$Bill {
  int? get id => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  Account? get account => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Shop? get shop => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  List<BillPhoto> get photos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BillCopyWith<Bill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BillCopyWith<$Res> {
  factory $BillCopyWith(Bill value, $Res Function(Bill) then) =
      _$BillCopyWithImpl<$Res, Bill>;
  @useResult
  $Res call(
      {int? id,
      User? user,
      Account? account,
      DateTime date,
      Shop? shop,
      Category? category,
      double price,
      String? comment,
      List<BillPhoto> photos});

  $UserCopyWith<$Res>? get user;
  $AccountCopyWith<$Res>? get account;
  $ShopCopyWith<$Res>? get shop;
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$BillCopyWithImpl<$Res, $Val extends Bill>
    implements $BillCopyWith<$Res> {
  _$BillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? account = freezed,
    Object? date = null,
    Object? shop = freezed,
    Object? category = freezed,
    Object? price = null,
    Object? comment = freezed,
    Object? photos = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<BillPhoto>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountCopyWith<$Res>? get account {
    if (_value.account == null) {
      return null;
    }

    return $AccountCopyWith<$Res>(_value.account!, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShopCopyWith<$Res>? get shop {
    if (_value.shop == null) {
      return null;
    }

    return $ShopCopyWith<$Res>(_value.shop!, (value) {
      return _then(_value.copyWith(shop: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BillCopyWith<$Res> implements $BillCopyWith<$Res> {
  factory _$$_BillCopyWith(_$_Bill value, $Res Function(_$_Bill) then) =
      __$$_BillCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      User? user,
      Account? account,
      DateTime date,
      Shop? shop,
      Category? category,
      double price,
      String? comment,
      List<BillPhoto> photos});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $AccountCopyWith<$Res>? get account;
  @override
  $ShopCopyWith<$Res>? get shop;
  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$_BillCopyWithImpl<$Res> extends _$BillCopyWithImpl<$Res, _$_Bill>
    implements _$$_BillCopyWith<$Res> {
  __$$_BillCopyWithImpl(_$_Bill _value, $Res Function(_$_Bill) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user = freezed,
    Object? account = freezed,
    Object? date = null,
    Object? shop = freezed,
    Object? category = freezed,
    Object? price = null,
    Object? comment = freezed,
    Object? photos = null,
  }) {
    return _then(_$_Bill(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Account?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shop: freezed == shop
          ? _value.shop
          : shop // ignore: cast_nullable_to_non_nullable
              as Shop?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<BillPhoto>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Bill extends _Bill {
  _$_Bill(
      {this.id,
      this.user,
      this.account,
      required this.date,
      this.shop,
      this.category,
      required this.price,
      this.comment,
      final List<BillPhoto> photos = const []})
      : _photos = photos,
        super._();

  factory _$_Bill.fromJson(Map<String, dynamic> json) => _$$_BillFromJson(json);

  @override
  final int? id;
  @override
  final User? user;
  @override
  final Account? account;
  @override
  final DateTime date;
  @override
  final Shop? shop;
  @override
  final Category? category;
  @override
  final double price;
  @override
  final String? comment;
  final List<BillPhoto> _photos;
  @override
  @JsonKey()
  List<BillPhoto> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  String toString() {
    return 'Bill(id: $id, user: $user, account: $account, date: $date, shop: $shop, category: $category, price: $price, comment: $comment, photos: $photos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bill &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.shop, shop) || other.shop == shop) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality().equals(other._photos, _photos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, account, date, shop,
      category, price, comment, const DeepCollectionEquality().hash(_photos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BillCopyWith<_$_Bill> get copyWith =>
      __$$_BillCopyWithImpl<_$_Bill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BillToJson(
      this,
    );
  }
}

abstract class _Bill extends Bill {
  factory _Bill(
      {final int? id,
      final User? user,
      final Account? account,
      required final DateTime date,
      final Shop? shop,
      final Category? category,
      required final double price,
      final String? comment,
      final List<BillPhoto> photos}) = _$_Bill;
  _Bill._() : super._();

  factory _Bill.fromJson(Map<String, dynamic> json) = _$_Bill.fromJson;

  @override
  int? get id;
  @override
  User? get user;
  @override
  Account? get account;
  @override
  DateTime get date;
  @override
  Shop? get shop;
  @override
  Category? get category;
  @override
  double get price;
  @override
  String? get comment;
  @override
  List<BillPhoto> get photos;
  @override
  @JsonKey(ignore: true)
  _$$_BillCopyWith<_$_Bill> get copyWith => throw _privateConstructorUsedError;
}
