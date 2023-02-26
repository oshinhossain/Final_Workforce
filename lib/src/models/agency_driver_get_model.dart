import 'package:json_annotation/json_annotation.dart';
part 'agency_driver_get_model.g.dart';

@JsonSerializable()
class AgencyDriverModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? inviterFullname;
  String? inviterUsername;
  String? inviterEmail;
  String? inviterMobile;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? invitedOn;
  String? acceptedOn;
  String? status;
  String? digest;
  String? preferredCity;
  double? ridesKm;
  int? ridesCount;
  String? preferredTimeFrom;
  String? preferredTimeTo;
  double? userRating;
  String? licenseType;
  String? statusCode;
  String? vehicleClass;

  AgencyDriverModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.inviterFullname,
      this.inviterUsername,
      this.inviterEmail,
      this.inviterMobile,
      this.driverFullname,
      this.driverUsername,
      this.driverEmail,
      this.driverMobile,
      this.invitedOn,
      this.acceptedOn,
      this.status,
      this.digest,
      this.preferredCity,
      this.ridesKm,
      this.ridesCount,
      this.preferredTimeFrom,
      this.preferredTimeTo,
      this.userRating,
      this.licenseType,
      this.statusCode,
      this.vehicleClass});

  factory AgencyDriverModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyDriverModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyDriverModelToJson(this);
}
