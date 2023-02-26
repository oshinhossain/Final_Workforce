import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';
part 'travel_path.g.dart';

@JsonSerializable()
class TravelPath {
  String? id;
  double? pathLenghtKm;
  String? pathConstruct;
  int? tollPlazaCount;
  int? refuellingStationCount;
  int? checkPostCount;
  String? travelPathCode;
  String? travelPathName;
  String? routeType;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? countryCode;
  String? countryName;
  List<LatLng>? points;

  TravelPath({
    this.id,
    this.pathLenghtKm,
    this.pathConstruct,
    this.tollPlazaCount,
    this.refuellingStationCount,
    this.checkPostCount,
    this.travelPathCode,
    this.travelPathName,
    this.routeType,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.countryCode,
    this.countryName,
    this.points,
  });

  factory TravelPath.fromJson(Map<String, dynamic> json) =>
      _$TravelPathFromJson(json);
  Map<String, dynamic> toJson() => _$TravelPathToJson(this);
}
