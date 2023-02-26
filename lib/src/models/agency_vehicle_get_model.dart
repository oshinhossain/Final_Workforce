import 'package:json_annotation/json_annotation.dart';
part 'agency_vehicle_get_model.g.dart';

@JsonSerializable()
class AgencyVehicleGetModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? custodianFullname;
  String? custodianUsername;
  String? custodianEmail;
  String? custodianMobile;
  String? vehicleType;
  double? capacity;
  String? capacityUnit;
  String? brand;
  String? model;
  String? registrationNo;
  String? primaryTypeOfFuel;
  String? secondaryTypeOfFuel;
  String? invitedOn;
  String? acceptedOn;
  String? status;
  String? digest;
  String? agencyShortName;
  double? weightCapacity;
  String? weightCapacityUnit;
  double? volumeCapacity;
  String? volumeCapacityUnit;
  int? seatCapacity;
  String? seatCapacityUnit;
  bool? weightCapacityApplicable;
  bool? volumeCapacityApplicable;
  bool? seatCapacityApplicable;

  AgencyVehicleGetModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.custodianFullname,
      this.custodianUsername,
      this.custodianEmail,
      this.custodianMobile,
      this.vehicleType,
      this.capacity,
      this.capacityUnit,
      this.brand,
      this.model,
      this.registrationNo,
      this.primaryTypeOfFuel,
      this.secondaryTypeOfFuel,
      this.invitedOn,
      this.acceptedOn,
      this.status,
      this.digest,
      this.agencyShortName,
      this.weightCapacity,
      this.weightCapacityUnit,
      this.volumeCapacity,
      this.volumeCapacityUnit,
      this.seatCapacity,
      this.seatCapacityUnit,
      this.weightCapacityApplicable,
      this.volumeCapacityApplicable,
      this.seatCapacityApplicable});

  factory AgencyVehicleGetModel.fromJson(Map<String, dynamic> json) =>
      _$AgencyVehicleGetModelFromJson(json);
  Map<String, dynamic> toJson() => _$AgencyVehicleGetModelToJson(this);
}
