// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShopImpl _$$ShopImplFromJson(Map<String, dynamic> json) => _$ShopImpl(
      id: json['id'] as int?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ShopImplToJson(_$ShopImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
      'account': instance.account?.toJson(),
      'name': instance.name,
    };
