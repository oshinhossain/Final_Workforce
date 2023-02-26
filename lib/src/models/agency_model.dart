import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agency_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class AgencyModel {
  @HiveField(0)
  String? empId;

  @HiveField(1)
  String? userId;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? fullname;

  @HiveField(4)
  String? email;

  @HiveField(5)
  String? mobile;

  @HiveField(6)
  String? gender;

  @HiveField(7)
  String? reportingManagerUsername;

  @HiveField(8)
  String? reportingManagerFullname;

  @HiveField(9)
  String? reportingManagerEmail;

  @HiveField(10)
  String? reportingManagerMobile;

  @HiveField(11)
  String? agencyId;

  @HiveField(12)
  String? agencyCode;

  @HiveField(13)
  String? agencyName;

  @HiveField(14)
  String? countryId;

  @HiveField(15)
  String? countryCode;

  @HiveField(16)
  String? countryName;

  @HiveField(17)
  num? latitude;

  @HiveField(18)
  num? longitude;
  // num? currentLocationUpdatedOn;
  // num? currentLocationUpdatedAt;

  AgencyModel({
    this.empId,
    this.userId,
    this.username,
    this.fullname,
    this.email,
    this.mobile,
    this.gender,
    this.reportingManagerUsername,
    this.reportingManagerFullname,
    this.reportingManagerEmail,
    this.reportingManagerMobile,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.latitude,
    this.longitude,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyModelToJson(this);
}
