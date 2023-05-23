// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BillPhoto _$$_BillPhotoFromJson(Map<String, dynamic> json) => _$_BillPhoto(
      id: json['id'] as int?,
      bill: json['bill'] == null
          ? null
          : Bill.fromJson(json['bill'] as Map<String, dynamic>),
      name: json['name'] as String?,
      path: json['path'] as String?,
      blurhash: json['blurhash'] as String?,
    );

Map<String, dynamic> _$$_BillPhotoToJson(_$_BillPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bill': instance.bill?.toJson(),
      'name': instance.name,
      'path': instance.path,
      'blurhash': instance.blurhash,
    };
