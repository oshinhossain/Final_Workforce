import 'package:json_annotation/json_annotation.dart';
part 'map_data.g.dart';

@JsonSerializable()
class MapData {
  @JsonKey(name: 'place_id')
  int? placeId;
  String? licence;
  @JsonKey(name: 'osm_type')
  String? osmType;
  @JsonKey(name: 'osm_id')
  int? osmId;
  String? lat;
  String? lon;
  @JsonKey(name: 'display_name')
  String? displayName;
  Address? address;

  MapData({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.displayName,
    this.address,
  });

  factory MapData.fromJson(Map<String, dynamic> json) => _$MapDataFromJson(json);
  Map<String, dynamic> toJson() => _$MapDataToJson(this);
}

@JsonSerializable()
class Address {
  String? suburb;
  String? city;
  String? municipality;
  @JsonKey(name: 'state_district')
  String? stateDistrict;

  String? state;

  String? postcode;
  String? country;
  @JsonKey(name: 'country_code')
  String? countryCode;

  Address({
    this.suburb,
    this.city,
    this.municipality,
    this.stateDistrict,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
