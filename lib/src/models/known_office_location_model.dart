import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'known_office_location_model.g.dart';

@HiveType(typeId: 16)
@JsonSerializable()
class KnownOfficeLocationModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? locationCode;
  @HiveField(2)
  String? locationName;
  @HiveField(3)
  String? address;
  @HiveField(4)
  double? latitude;
  @HiveField(5)
  double? longitude;
  @HiveField(6)
  String? agencyId;
  @HiveField(7)
  String? agencyCode;
  @HiveField(8)
  String? agencyName;

  KnownOfficeLocationModel({
    this.id,
    this.locationCode,
    this.locationName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory KnownOfficeLocationModel.fromJson(Map<String, dynamic> json) =>
      _$KnownOfficeLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$KnownOfficeLocationModelToJson(this);
}
