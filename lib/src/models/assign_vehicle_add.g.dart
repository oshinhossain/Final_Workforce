// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_vehicle_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignVehicleAdd _$AssignVehicleAddFromJson(Map<String, dynamic> json) =>
    AssignVehicleAdd(
      id: json['id'] as String?,
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      brand: json['brand'] as String?,
      capacity: json['capacity'] as String?,
      capacityUnit: json['capacityUnit'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      status: json['status'] as String?,
      vehicleType: json['vehicleType'] as String?,
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      weightCapacityUnit: json['weightCapacityUnit'] as String?,
    );

Map<String, dynamic> _$AssignVehicleAddToJson(AssignVehicleAdd instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'driverUsername': instance.driverUsername,
      'driverFullname': instance.driverFullname,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'brand': instance.brand,
      'capacity': instance.capacity,
      'capacityUnit': instance.capacityUnit,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'status': instance.status,
      'vehicleType': instance.vehicleType,
      'weightCapacityUnit': instance.weightCapacityUnit,
      'weightCapacity': instance.weightCapacity,
    };
