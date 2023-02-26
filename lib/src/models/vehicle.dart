import 'package:json_annotation/json_annotation.dart';
part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
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
  String? masterViewModel;
  double? weightCapacity;
  String? weightCapacityUnit;

  @JsonKey(defaultValue: [])
  List<Driver>? driverList;

  Vehicle({
    this.id,
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
    this.masterViewModel,
    this.driverList,
    this.weightCapacity,
    this.weightCapacityUnit,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}

@JsonSerializable()
class Driver {
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
  String? masterViewModel;

  Driver({
    this.id,
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
    this.masterViewModel,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
