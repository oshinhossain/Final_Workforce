// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      custodianFullname: json['custodianFullname'] as String?,
      custodianUsername: json['custodianUsername'] as String?,
      custodianEmail: json['custodianEmail'] as String?,
      custodianMobile: json['custodianMobile'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: (json['capacity'] as num?)?.toDouble(),
      capacityUnit: json['capacityUnit'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      primaryTypeOfFuel: json['primaryTypeOfFuel'] as String?,
      secondaryTypeOfFuel: json['secondaryTypeOfFuel'] as String?,
      invitedOn: json['invitedOn'] as String?,
      acceptedOn: json['acceptedOn'] as String?,
      status: json['status'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
      driverList: (json['driverList'] as List<dynamic>?)
              ?.map((e) => Driver.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      weightCapacityUnit: json['weightCapacityUnit'] as String?,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'custodianFullname': instance.custodianFullname,
      'custodianUsername': instance.custodianUsername,
      'custodianEmail': instance.custodianEmail,
      'custodianMobile': instance.custodianMobile,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'capacityUnit': instance.capacityUnit,
      'brand': instance.brand,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'primaryTypeOfFuel': instance.primaryTypeOfFuel,
      'secondaryTypeOfFuel': instance.secondaryTypeOfFuel,
      'invitedOn': instance.invitedOn,
      'acceptedOn': instance.acceptedOn,
      'status': instance.status,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
      'weightCapacity': instance.weightCapacity,
      'weightCapacityUnit': instance.weightCapacityUnit,
      'driverList': instance.driverList,
    };

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      inviterFullname: json['inviterFullname'] as String?,
      inviterUsername: json['inviterUsername'] as String?,
      inviterEmail: json['inviterEmail'] as String?,
      inviterMobile: json['inviterMobile'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      invitedOn: json['invitedOn'] as String?,
      acceptedOn: json['acceptedOn'] as String?,
      status: json['status'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'inviterFullname': instance.inviterFullname,
      'inviterUsername': instance.inviterUsername,
      'inviterEmail': instance.inviterEmail,
      'inviterMobile': instance.inviterMobile,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'invitedOn': instance.invitedOn,
      'acceptedOn': instance.acceptedOn,
      'status': instance.status,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };
