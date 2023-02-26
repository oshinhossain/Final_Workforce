import 'package:json_annotation/json_annotation.dart';
part 'vehicle_get_model.g.dart';

@JsonSerializable()
class VehicleGet {
  // String? id;
  // String? countryCode;
  // String? countryName;
  // String? vehicleTypeId;
  // String? vehicleType;
  // num? weightCapacity;
  // String? weightCapacityUnit;
  // String? brand;
  // String? registrationNo;
  // bool? isChecked;
  // String? selectedId;

  // VehicleGet({
  //   this.id,
  //   this.countryCode,
  //   this.countryName,
  //   this.vehicleTypeId,
  //   this.vehicleType,
  //   this.weightCapacity,
  //   this.weightCapacityUnit,
  //   this.brand,
  //   this.registrationNo,
  //   this.isChecked,
  //   this.selectedId,
  // });

  String? id;
  String? countryCode;
  String? countryName;
  String? authorityAgencyId;
  String? authorityAgencyCode;
  String? authorityAgencyName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? routeType;
  String? weightType;
  String? vehicleTypeId;
  String? vehicleType;
  double? weightCapacity;
  String? weightCapacityUnit;
  double? volumeCapacity;
  String? volumeCapacityUnit;
  int? seatCapacity;
  String? seatCapacityUnit;
  String? brand;
  String? model;
  String? registrationNo;
  String? vin;
  String? engineNo;
  String? color;
  String? registrationDate;
  String? registrationPlace;
  String? primaryTypeOfFuel;
  double? primaryFuelCapacity;
  String? primaryFuelUnit;
  String? secondaryTypeOfFuel;
  double? secondaryFuelCapacity;
  String? secondaryFuelUnit;
  double? annualRoadTax;
  double? annualFitnessFee;
  String? lastFitnessChecked;
  String? digest;
  bool? weightCapacityApplicable;
  bool? volumeCapacityApplicable;
  bool? seatCapacityApplicable;
  bool? isChecked;
  String? selectedId;

  VehicleGet({
    this.id,
    this.countryCode,
    this.countryName,
    this.authorityAgencyId,
    this.authorityAgencyCode,
    this.authorityAgencyName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.fullname,
    this.username,
    this.email,
    this.mobile,
    this.routeType,
    this.weightType,
    this.vehicleTypeId,
    this.vehicleType,
    this.weightCapacity,
    this.weightCapacityUnit,
    this.volumeCapacity,
    this.volumeCapacityUnit,
    this.seatCapacity,
    this.seatCapacityUnit,
    this.brand,
    this.model,
    this.registrationNo,
    this.vin,
    this.engineNo,
    this.color,
    this.registrationDate,
    this.registrationPlace,
    this.primaryTypeOfFuel,
    this.primaryFuelCapacity,
    this.primaryFuelUnit,
    this.secondaryTypeOfFuel,
    this.secondaryFuelCapacity,
    this.secondaryFuelUnit,
    this.annualRoadTax,
    this.annualFitnessFee,
    this.lastFitnessChecked,
    this.digest,
    this.weightCapacityApplicable,
    this.volumeCapacityApplicable,
    this.seatCapacityApplicable,
    this.isChecked,
    this.selectedId,
  });

  factory VehicleGet.fromJson(Map<String, dynamic> json) =>
      _$VehicleGetFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleGetToJson(this);
}
