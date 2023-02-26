import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? locationName;
  String? address;
  String? businessTag;
  double? latitude;
  double? longitude;
  String? countryCode;
  String? countryName;
  String? geoLevel1Code;
  String? geoLevel1Name;
  String? geoLevel2Code;
  String? geoLevel2Name;
  String? geoLevel3Code;
  String? geoLevel3Name;
  String? geoLevel4Code;
  String? geoLevel4Name;
  String? createdByCode;
  String? createdByName;
  String? createdByUsername;
  String? createdByEmail;
  String? createdByCompanyCode;
  String? createdByCompanyName;
  num? createdAt;
  String? updatedByCode;
  String? updatedByName;
  String? updatedByUsername;
  String? updatedByEmail;
  String? updatedByCompanyCode;
  String? updatedByCompanyName;
  num? updatedAt;
  int? status;
  String? masterViewModel;

  LocationModel(
      {this.id,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.locationName,
      this.address,
      this.businessTag,
      this.latitude,
      this.longitude,
      this.countryCode,
      this.countryName,
      this.geoLevel1Code,
      this.geoLevel1Name,
      this.geoLevel2Code,
      this.geoLevel2Name,
      this.geoLevel3Code,
      this.geoLevel3Name,
      this.geoLevel4Code,
      this.geoLevel4Name,
      this.createdByCode,
      this.createdByName,
      this.createdByUsername,
      this.createdByEmail,
      this.createdByCompanyCode,
      this.createdByCompanyName,
      this.createdAt,
      this.updatedByCode,
      this.updatedByName,
      this.updatedByUsername,
      this.updatedByEmail,
      this.updatedByCompanyCode,
      this.updatedByCompanyName,
      this.updatedAt,
      this.status,
      this.masterViewModel});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
