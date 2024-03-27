// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BillPhotoImpl _$$BillPhotoImplFromJson(Map<String, dynamic> json) =>
    _$BillPhotoImpl(
      id: json['id'] as int?,
      bill: json['bill'] == null
          ? null
          : Bill.fromJson(json['bill'] as Map<String, dynamic>),
      name: json['name'] as String?,
      path: json['path'] as String?,
      blurhash: json['blurhash'] as String?,
    );

Map<String, dynamic> _$$BillPhotoImplToJson(_$BillPhotoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bill': instance.bill?.toJson(),
      'name': instance.name,
      'path': instance.path,
      'blurhash': instance.blurhash,
    };
