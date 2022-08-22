import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:piggy_flow_mobile/models/user.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
abstract class Shop implements _$Shop {
  const Shop._();

  @JsonSerializable(explicitToJson: true)
  factory Shop({
    int? id,
    User? user,
    required String name,
  }) = _Shop;

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
