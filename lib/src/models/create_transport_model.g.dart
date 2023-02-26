// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_transport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTransportModel _$CreateTransportModelFromJson(
        Map<String, dynamic> json) =>
    CreateTransportModel(
      orderingAgencyId: json['orderingAgencyId'] as String?,
      orderingAgencyCode: json['orderingAgencyCode'] as String?,
      orderingAgencyName: json['orderingAgencyName'] as String?,
      transporterAgencyId: json['transporterAgencyId'] as String?,
      transporterAgencyCode: json['transporterAgencyCode'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      receiverAgencyId: json['receiverAgencyId'] as String?,
      receiverAgencyCode: json['receiverAgencyCode'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      baseAmount: json['baseAmount'] as num?,
      vatAmount: json['vatAmount'] as num?,
      grossAmount: json['grossAmount'] as num?,
      cu: json['cu'] as String?,
      totalQuantity: json['totalQuantity'] as num?,
      inspectorAtLoadingPointFullname:
          json['inspectorAtLoadingPointFullname'] as String?,
      inspectorAtLoadingPointUsername:
          json['inspectorAtLoadingPointUsername'] as String?,
      inspectorAtLoadingPointEmail:
          json['inspectorAtLoadingPointEmail'] as String?,
      inspectorAtLoadingPointMobile:
          json['inspectorAtLoadingPointMobile'] as String?,
      singleReceiver: json['singleReceiver'] as bool?,
      receiverFullname: json['receiverFullname'] as String?,
      receiverUsername: json['receiverUsername'] as String?,
      receiverEmail: json['receiverEmail'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      singleInspectorAtDropLocation:
          json['singleInspectorAtDropLocation'] as bool?,
      inspectorAtDropLocationFullname:
          json['inspectorAtDropLocationFullname'] as String?,
      inspectorAtDropLocationUsername:
          json['inspectorAtDropLocationUsername'] as String?,
      inspectorAtDropLocationEmail:
          json['inspectorAtDropLocationEmail'] as String?,
      inspectorAtDropLocationMobile:
          json['inspectorAtDropLocationMobile'] as String?,
      sourceLocId: json['sourceLocId'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      sourceLatitude: json['sourceLatitude'] as num?,
      sourceLongitude: json['sourceLongitude'] as num?,
      singleDestinationLoc: json['singleDestinationLoc'] as bool?,
      destinationLocId: json['destinationLocId'] as String?,
      destinationLocName: json['destinationLocName'] as String?,
      destinationLatitude: json['destinationLatitude'] as num?,
      destinationLongitude: json['destinationLongitude'] as num?,
      travelPathId: json['travelPathId'] as String?,
      distanceKm: json['distanceKm'] as num?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CreateTransportModelToJson(
        CreateTransportModel instance) =>
    <String, dynamic>{
      'orderingAgencyId': instance.orderingAgencyId,
      'orderingAgencyCode': instance.orderingAgencyCode,
      'orderingAgencyName': instance.orderingAgencyName,
      'transporterAgencyId': instance.transporterAgencyId,
      'transporterAgencyCode': instance.transporterAgencyCode,
      'transporterAgencyName': instance.transporterAgencyName,
      'receiverAgencyId': instance.receiverAgencyId,
      'receiverAgencyCode': instance.receiverAgencyCode,
      'receiverAgencyName': instance.receiverAgencyName,
      'transportOrderDate': instance.transportOrderDate,
      'baseAmount': instance.baseAmount,
      'vatAmount': instance.vatAmount,
      'grossAmount': instance.grossAmount,
      'cu': instance.cu,
      'totalQuantity': instance.totalQuantity,
      'inspectorAtLoadingPointFullname':
          instance.inspectorAtLoadingPointFullname,
      'inspectorAtLoadingPointUsername':
          instance.inspectorAtLoadingPointUsername,
      'inspectorAtLoadingPointEmail': instance.inspectorAtLoadingPointEmail,
      'inspectorAtLoadingPointMobile': instance.inspectorAtLoadingPointMobile,
      'singleReceiver': instance.singleReceiver,
      'receiverFullname': instance.receiverFullname,
      'receiverUsername': instance.receiverUsername,
      'receiverEmail': instance.receiverEmail,
      'receiverMobile': instance.receiverMobile,
      'singleInspectorAtDropLocation': instance.singleInspectorAtDropLocation,
      'inspectorAtDropLocationFullname':
          instance.inspectorAtDropLocationFullname,
      'inspectorAtDropLocationUsername':
          instance.inspectorAtDropLocationUsername,
      'inspectorAtDropLocationEmail': instance.inspectorAtDropLocationEmail,
      'inspectorAtDropLocationMobile': instance.inspectorAtDropLocationMobile,
      'sourceLocId': instance.sourceLocId,
      'sourceLocName': instance.sourceLocName,
      'sourceLatitude': instance.sourceLatitude,
      'sourceLongitude': instance.sourceLongitude,
      'singleDestinationLoc': instance.singleDestinationLoc,
      'destinationLocId': instance.destinationLocId,
      'destinationLocName': instance.destinationLocName,
      'destinationLatitude': instance.destinationLatitude,
      'destinationLongitude': instance.destinationLongitude,
      'travelPathId': instance.travelPathId,
      'distanceKm': instance.distanceKm,
      'status': instance.status,
    };
