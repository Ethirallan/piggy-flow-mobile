import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/models/bill.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User implements _$User {
  const User._();

  @JsonSerializable(explicitToJson: true)
  factory User({
    int? id,
    String? uid,
    String? email,
    String? displayName,
    @Default([]) List<Shop> shops,
    @Default([]) List<Category> categories,
    @Default([]) List<Account> accounts,
    @Default([]) List<Bill> bills,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
