import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/models/user.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
abstract class Bill implements _$Bill {
  const Bill._();

  @JsonSerializable(explicitToJson: true)
  factory Bill({
    int? id,
    User? user,
    Account? account,
    required DateTime date,
    Shop? shop,
    Category? category,
    required double price,
    String? comment,
  }) = _Bill;

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
}
