import 'package:json_annotation/json_annotation.dart';
part 'transport_order_inspection_send.g.dart';

// @JsonSerializable()
// class TransportOrderInspectionSend {
//   String? transportOrderId;
//   String? transportOrderNo;
//   List<OrderLines>? orderLines;
//   String? overAllRemarks;

//   TransportOrderInspectionSend({
//     this.transportOrderId,
//     this.transportOrderNo,
//     this.orderLines,
//     this.overAllRemarks,
//   });

//   factory TransportOrderInspectionSend.fromJson(Map<String, dynamic> json) =>
//       _$TransportOrderInspectionSendFromJson(json);
//   Map<String, dynamic> toJson() => _$TransportOrderInspectionSendToJson(this);
// }

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
