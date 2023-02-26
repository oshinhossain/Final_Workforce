// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspect_materials_to_transport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspectMaterialsTransportOrder _$InspectMaterialsTransportOrderFromJson(
        Map<String, dynamic> json) =>
    InspectMaterialsTransportOrder(
      id: json['id'] as String?,
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      orderingAgencyName: json['orderingAgencyName'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
    );

Map<String, dynamic> _$InspectMaterialsTransportOrderToJson(
        InspectMaterialsTransportOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'orderingAgencyName': instance.orderingAgencyName,
      'sourceLocName': instance.sourceLocName,
    };

InspectMaterialsTransportOrderLines
    _$InspectMaterialsTransportOrderLinesFromJson(Map<String, dynamic> json) =>
        InspectMaterialsTransportOrderLines(
          id: json['id'] as String?,
          foundItOkayAtLoadingPoint: json['foundItOkayAtLoadingPoint'] as bool?,
          inspectorFoundQuantityAtLoadingPoint:
              json['inspectorFoundQuantityAtLoadingPoint'] as num?,
          inspectorRemarkAtLoadingPoint:
              json['inspectorRemarkAtLoadingPoint'] as String?,
          productName: json['productName'] as String?,
          productCode: json['productCode'] as String?,
          baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
          dropLocName: json['dropLocName'] as String?,
          transportOrderId: json['transportOrderId'] as String?,
          transportOrderNo: json['transportOrderNo'] as String?,
        );

Map<String, dynamic> _$InspectMaterialsTransportOrderLinesToJson(
        InspectMaterialsTransportOrderLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foundItOkayAtLoadingPoint': instance.foundItOkayAtLoadingPoint,
      'inspectorFoundQuantityAtLoadingPoint':
          instance.inspectorFoundQuantityAtLoadingPoint,
      'inspectorRemarkAtLoadingPoint': instance.inspectorRemarkAtLoadingPoint,
      'productName': instance.productName,
      'productCode': instance.productCode,
      'baseUomQuantity': instance.baseUomQuantity,
      'dropLocName': instance.dropLocName,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
    };
