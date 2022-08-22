import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/models/user.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
abstract class Account implements _$Account {
  const Account._();

  @JsonSerializable(explicitToJson: true)
  factory Account({
    int? id,
    required String name,
    @Default([]) List<User> users,
    @Default([]) List<Bill> bills,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
