// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: json['id'] as int?,
      name: json['name'] as String,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      bills: (json['bills'] as List<dynamic>?)
              ?.map((e) => Bill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      shops: (json['shops'] as List<dynamic>?)
              ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'users': instance.users.map((e) => e.toJson()).toList(),
      'bills': instance.bills.map((e) => e.toJson()).toList(),
      'shops': instance.shops.map((e) => e.toJson()).toList(),
      'categories': instance.categories.map((e) => e.toJson()).toList(),
    };
