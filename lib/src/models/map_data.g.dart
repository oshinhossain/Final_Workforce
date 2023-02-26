// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
      placeId: json['place_id'] as int?,
      licence: json['licence'] as String?,
      osmType: json['osm_type'] as String?,
      osmId: json['osm_id'] as int?,
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
      displayName: json['display_name'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
      'place_id': instance.placeId,
      'licence': instance.licence,
      'osm_type': instance.osmType,
      'osm_id': instance.osmId,
      'lat': instance.lat,
      'lon': instance.lon,
      'display_name': instance.displayName,
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      suburb: json['suburb'] as String?,
      city: json['city'] as String?,
      municipality: json['municipality'] as String?,
      stateDistrict: json['state_district'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'suburb': instance.suburb,
      'city': instance.city,
      'municipality': instance.municipality,
      'state_district': instance.stateDistrict,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
      'country_code': instance.countryCode,
    };
