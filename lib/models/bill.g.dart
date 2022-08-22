// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bill _$$_BillFromJson(Map<String, dynamic> json) => _$_Bill(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$_BillToJson(_$_Bill instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
      'date': instance.date.toIso8601String(),
      'shop': instance.shop?.toJson(),
      'category': instance.category?.toJson(),
      'price': instance.price,
      'comment': instance.comment,
    };
