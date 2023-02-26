// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transportation_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportationOrderModel _$TransportationOrderModelFromJson(
        Map<String, dynamic> json) =>
    TransportationOrderModel(
      orderingAgencyName: json['orderingAgencyName'] as String?,
      totalDelivered: (json['totalDelivered'] as num?)?.toDouble(),
      deliveredToday: (json['deliveredToday'] as num?)?.toDouble(),
      totalPending: (json['totalPending'] as num?)?.toDouble(),
      orderedToday: (json['orderedToday'] as num?)?.toDouble(),
      totalOrdered: (json['totalOrdered'] as num?)?.toDouble(),
      projectName: json['projectName'] as String?,
      productName: json['productName'] as String?,
      baseUom: json['baseUom'] as String?,
      productFullcode: json['productFullcode'],
    );

Map<String, dynamic> _$TransportationOrderModelToJson(
        TransportationOrderModel instance) =>
    <String, dynamic>{
      'orderingAgencyName': instance.orderingAgencyName,
      'totalDelivered': instance.totalDelivered,
      'deliveredToday': instance.deliveredToday,
      'totalPending': instance.totalPending,
      'orderedToday': instance.orderedToday,
      'totalOrdered': instance.totalOrdered,
      'projectName': instance.projectName,
      'productName': instance.productName,
      'baseUom': instance.baseUom,
      'productFullcode': instance.productFullcode,
    };
