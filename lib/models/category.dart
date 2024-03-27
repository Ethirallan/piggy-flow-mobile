import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:piggy_flow_mobile/models/user.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category implements _$Category {
  const Category._();

  @JsonSerializable(explicitToJson: true)
  factory Category({
    int? id,
    User? user,
    required String name,
    required String emoji,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
