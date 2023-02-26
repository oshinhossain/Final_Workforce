import 'package:json_annotation/json_annotation.dart';

part 'inspect_materials_to_transport.g.dart';

@JsonSerializable()
class InspectMaterialsTransportOrder {
  String? id;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? orderingAgencyName;
  String? sourceLocName;

  InspectMaterialsTransportOrder({
    this.id,
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.orderingAgencyName,
    this.sourceLocName,
  });

  factory InspectMaterialsTransportOrder.fromJson(Map<String, dynamic> json) =>
      _$InspectMaterialsTransportOrderFromJson(json);
  Map<String, dynamic> toJson() => _$InspectMaterialsTransportOrderToJson(this);
}

// Transport Order Lines

@JsonSerializable()
class InspectMaterialsTransportOrderLines {
  String? id;

  bool? foundItOkayAtLoadingPoint;
  num? inspectorFoundQuantityAtLoadingPoint;
  String? inspectorRemarkAtLoadingPoint;
  String? productName;
  String? productCode;
  double? baseUomQuantity;
  String? dropLocName;
  String? transportOrderId;
  String? transportOrderNo;

  InspectMaterialsTransportOrderLines({
    this.id,
    this.foundItOkayAtLoadingPoint,
    this.inspectorFoundQuantityAtLoadingPoint,
    this.inspectorRemarkAtLoadingPoint,
    this.productName,
    this.productCode,
    this.baseUomQuantity,
    this.dropLocName,
    this.transportOrderId,
    this.transportOrderNo,
  });

  factory InspectMaterialsTransportOrderLines.fromJson(
          Map<String, dynamic> json) =>
      _$InspectMaterialsTransportOrderLinesFromJson(json);
  Map<String, dynamic> toJson() =>
      _$InspectMaterialsTransportOrderLinesToJson(this);
}
