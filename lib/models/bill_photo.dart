import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piggy_flow_mobile/models/bill.dart';

part 'bill_photo.freezed.dart';
part 'bill_photo.g.dart';

@freezed
abstract class BillPhoto implements _$BillPhoto {
  const BillPhoto._();

  @JsonSerializable(explicitToJson: true)
  factory BillPhoto({
    int? id,
    Bill? bill,
    String? name,
    String? path,
    String? blurhash,
  }) = _BillPhoto;

  factory BillPhoto.fromJson(Map<String, dynamic> json) => _$BillPhotoFromJson(json);
}
