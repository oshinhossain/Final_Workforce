import 'package:json_annotation/json_annotation.dart';
part 'assign_vehicle_add.g.dart';

@JsonSerializable()
class AssignVehicleAdd {
  String? id;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? driverUsername;
  String? driverFullname;
  String? driverEmail;
  String? driverMobile;
  String? brand;
  String? capacity;
  String? capacityUnit;
  String? model;
  String? registrationNo;
  String? status;
  String? vehicleType;
  String? weightCapacityUnit;
  double? weightCapacity;

  AssignVehicleAdd({
    this.id,
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.driverUsername,
    this.driverFullname,
    this.driverEmail,
    this.driverMobile,
    this.brand,
    this.capacity,
    this.capacityUnit,
    this.model,
    this.registrationNo,
    this.status,
    this.vehicleType,
    this.weightCapacity,
    this.weightCapacityUnit,
  });

  factory AssignVehicleAdd.fromJson(Map<String, dynamic> json) =>
      _$AssignVehicleAddFromJson(json);
  Map<String, dynamic> toJson() => _$AssignVehicleAddToJson(this);
}
