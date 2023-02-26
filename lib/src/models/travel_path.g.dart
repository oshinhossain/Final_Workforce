// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelPath _$TravelPathFromJson(Map<String, dynamic> json) => TravelPath(
      id: json['id'] as String?,
      pathLenghtKm: (json['pathLenghtKm'] as num?)?.toDouble(),
      pathConstruct: json['pathConstruct'] as String?,
      tollPlazaCount: json['tollPlazaCount'] as int?,
      refuellingStationCount: json['refuellingStationCount'] as int?,
      checkPostCount: json['checkPostCount'] as int?,
      travelPathCode: json['travelPathCode'] as String?,
      travelPathName: json['travelPathName'] as String?,
      routeType: json['routeType'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      points: (json['points'] as List<dynamic>?)
          ?.map((e) => LatLng.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TravelPathToJson(TravelPath instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pathLenghtKm': instance.pathLenghtKm,
      'pathConstruct': instance.pathConstruct,
      'tollPlazaCount': instance.tollPlazaCount,
      'refuellingStationCount': instance.refuellingStationCount,
      'checkPostCount': instance.checkPostCount,
      'travelPathCode': instance.travelPathCode,
      'travelPathName': instance.travelPathName,
      'routeType': instance.routeType,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'points': instance.points,
    };
