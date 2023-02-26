// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_order_inspection_send.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderLines _$OrderLinesFromJson(Map<String, dynamic> json) => OrderLines(
      id: json['id'] as String?,
      foundItOkayAtLoadingPoint: json['foundItOkayAtLoadingPoint'] as bool?,
      inspectorFoundQuantityAtLoadingPoint:
          (json['inspectorFoundQuantityAtLoadingPoint'] as num?)?.toDouble(),
      inspectorRemarkAtLoadingPoint:
          json['inspectorRemarkAtLoadingPoint'] as String? ?? '',
      productName: json['productName'] as String?,
      productCode: json['productCode'] as String?,
      orderedQuantity: (json['orderedQuantity'] as num?)?.toDouble(),
      dropLocName: json['dropLocName'] as String?,
    );

Map<String, dynamic> _$OrderLinesToJson(OrderLines instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foundItOkayAtLoadingPoint': instance.foundItOkayAtLoadingPoint,
      'inspectorFoundQuantityAtLoadingPoint':
          instance.inspectorFoundQuantityAtLoadingPoint,
      'inspectorRemarkAtLoadingPoint': instance.inspectorRemarkAtLoadingPoint,
      'productName': instance.productName,
      'productCode': instance.productCode,
      'orderedQuantity': instance.orderedQuantity,
      'dropLocName': instance.dropLocName,
    };
