import 'package:json_annotation/json_annotation.dart';

part 'assign_vehicle_and_driver.g.dart';

@JsonSerializable()
class AssignVehicleTransportOrder {
  String? id;
  String? transportOrderNo;
  String? transportOrderDate;
  String? sourceLocName;
  String? destinationLocName;

  AssignVehicleTransportOrder({
    this.id,
    this.transportOrderNo,
    this.transportOrderDate,
    this.sourceLocName,
    this.destinationLocName,
  });

  factory AssignVehicleTransportOrder.fromJson(Map<String, dynamic> json) =>
      _$AssignVehicleTransportOrderFromJson(json);
  Map<String, dynamic> toJson() => _$AssignVehicleTransportOrderToJson(this);
}

// Transport Order Lines
@JsonSerializable()
class TransportOrderLines {
  String? id;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? productId;
  String? productCode;
  String? productName;
  String? productSerial;
  String? baseUom;
  double? baseUomQuantity;
  double? weightKg;

  TransportOrderLines({
    this.id,
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.productId,
    this.productCode,
    this.productSerial,
    this.productName,
    this.baseUom,
    this.baseUomQuantity,
    this.weightKg,
  });

  factory TransportOrderLines.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderLinesFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderLinesToJson(this);
}
