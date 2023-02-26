// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_vehicle_and_driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignVehicleTransportOrder _$AssignVehicleTransportOrderFromJson(
        Map<String, dynamic> json) =>
    AssignVehicleTransportOrder(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      destinationLocName: json['destinationLocName'] as String?,
    );

Map<String, dynamic> _$AssignVehicleTransportOrderToJson(
        AssignVehicleTransportOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'sourceLocName': instance.sourceLocName,
      'destinationLocName': instance.destinationLocName,
    };

TransportOrderLines _$TransportOrderLinesFromJson(Map<String, dynamic> json) =>
    TransportOrderLines(
      id: json['id'] as String?,
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productSerial: json['productSerial'] as String?,
      productName: json['productName'] as String?,
      baseUom: json['baseUom'] as String?,
      baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
      weightKg: (json['weightKg'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransportOrderLinesToJson(
        TransportOrderLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'productSerial': instance.productSerial,
      'baseUom': instance.baseUom,
      'baseUomQuantity': instance.baseUomQuantity,
      'weightKg': instance.weightKg,
    };
