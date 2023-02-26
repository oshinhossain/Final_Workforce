import 'package:json_annotation/json_annotation.dart';
part 'transport_order_inspection_receiving.g.dart';

@JsonSerializable()
class OrderLines {
  String? id;
  bool? foundItOkayAtLoadingPoint;
  double? inspectorFoundQuantityAtLoadingPoint;
  @JsonKey(defaultValue: '')
  String? inspectorRemarkAtLoadingPoint;
  String? productName;
  String? productCode;
  double? orderedQuantity;
  String? dropLocName;

  OrderLines({
    this.id,
    this.foundItOkayAtLoadingPoint,
    this.inspectorFoundQuantityAtLoadingPoint,
    this.inspectorRemarkAtLoadingPoint,
    this.productName,
    this.productCode,
    this.orderedQuantity,
    this.dropLocName,
  });

  factory OrderLines.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLinesToJson(this);
}
