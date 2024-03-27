import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/models/user.dart';
import 'package:piggy_flow_mobile/models/category.dart';


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
    @Default([]) List<Shop> shops,
    @Default([]) List<Category> categories,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
