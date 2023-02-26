// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transportation_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportationHistory _$TransportationHistoryFromJson(
        Map<String, dynamic> json) =>
    TransportationHistory(
      id: json['id'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      driverName: json['driverName'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      sourceLatitude: (json['sourceLatitude'] as num?)?.toDouble(),
      sourceLongitude: (json['sourceLongitude'] as num?)?.toDouble(),
      destinationLocName: json['destinationLocName'] as String?,
      destinationLatitude: (json['destinationLatitude'] as num?)?.toDouble(),
      destinationLongitude: (json['destinationLongitude'] as num?)?.toDouble(),
      ets: json['ets'] as String?,
      etd: json['etd'] as String?,
      items:
          (json['items'] as List<dynamic>?)?.map((e) => e as String).toList(),
      distanceKm: json['distanceKm'] as num?,
      vehicleRegNo: json['vehicleRegNo'] as String?,
      status: json['status'] as String?,
      dropLocation: (json['dropLocation'] as List<dynamic>?)
          ?.map((e) => DropLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      isExpand: json['isExpand'] as bool?,
    );

Map<String, dynamic> _$TransportationHistoryToJson(
        TransportationHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transporterAgencyName': instance.transporterAgencyName,
      'transportOrderNo': instance.transportOrderNo,
      'driverName': instance.driverName,
      'sourceLocName': instance.sourceLocName,
      'sourceLatitude': instance.sourceLatitude,
      'sourceLongitude': instance.sourceLongitude,
      'destinationLocName': instance.destinationLocName,
      'destinationLatitude': instance.destinationLatitude,
      'destinationLongitude': instance.destinationLongitude,
      'ets': instance.ets,
      'etd': instance.etd,
      'items': instance.items,
      'distanceKm': instance.distanceKm,
      'vehicleRegNo': instance.vehicleRegNo,
      'status': instance.status,
      'dropLocation': instance.dropLocation,
      'isExpand': instance.isExpand,
    };

DropLocation _$DropLocationFromJson(Map<String, dynamic> json) => DropLocation(
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DropLocationToJson(DropLocation instance) =>
    <String, dynamic>{
      'productCode': instance.productCode,
      'productName': instance.productName,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
    };
