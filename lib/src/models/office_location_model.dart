import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'office_location_model.g.dart';

@HiveType(typeId: 15)
@JsonSerializable()
class OfficeLocationModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? locationCode;
  @HiveField(2)
  String? locationName;
  @HiveField(3)
  String? address;
  @HiveField(4)
  double? officeLatitude;
  @HiveField(5)
  double? officeLongitude;
  @HiveField(6)
  String? agencyId;
  @HiveField(7)
  String? agencyCode;
  @HiveField(8)
  String? agencyName;

  OfficeLocationModel({
    this.id,
    this.locationCode,
    this.locationName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.address,
    this.officeLatitude,
    this.officeLongitude,
  });

  factory OfficeLocationModel.fromJson(Map<String, dynamic> json) =>
      _$OfficeLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeLocationModelToJson(this);
}
