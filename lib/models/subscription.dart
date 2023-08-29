import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/models/user.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
abstract class Subscription implements _$Subscription {
  const Subscription._();

  @JsonSerializable(explicitToJson: true)
  factory Subscription({
    int? id,
    User? user,
    Account? account,
    required int chargeDay,
    Shop? shop,
    Category? category,
    required double price,
    String? name,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);
}
