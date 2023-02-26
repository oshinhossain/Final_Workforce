import 'package:json_annotation/json_annotation.dart';
part 'select_driver_model.g.dart';

@JsonSerializable()
// class SelectDriverModel {
//   String? id;
//   String? countryCode;
//   String? countryName;
//   String? driverFullname;
//   String? driverUsername;
//   String? driverEmail;
//   String? driverMobile;
//   String? vehicleClass;
//   String? licenseType;
//   String? invitedOn;
//   bool? isChecked;
//   String? selectedId;

//   SelectDriverModel(
//       {this.id,
//       this.countryCode,
//       this.countryName,
//       this.driverFullname,
//       this.driverUsername,
//       this.driverEmail,
//       this.driverMobile,
//       this.vehicleClass,
//       this.licenseType,
//       this.invitedOn,
//       this.isChecked,
//       this.selectedId});

class SelectDriverModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? vehicleClass;
  String? licenseType;
  String? invitedOn;
  String? preferredCity;
  double? ridesKm;
  int? ridesCount;
  String? preferredTimeFrom;
  String? preferredTimeTo;
  double? userRating;
  bool? isChecked;
  String? selectedId;

  SelectDriverModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.driverFullname,
      this.driverUsername,
      this.driverEmail,
      this.driverMobile,
      this.vehicleClass,
      this.licenseType,
      this.invitedOn,
      this.preferredCity,
      this.ridesKm,
      this.ridesCount,
      this.preferredTimeFrom,
      this.preferredTimeTo,
      this.userRating,
      this.isChecked,
      this.selectedId});

  factory SelectDriverModel.fromJson(Map<String, dynamic> json) =>
      _$SelectDriverModelFromJson(json);
  Map<String, dynamic> toJson() => _$SelectDriverModelToJson(this);
}
