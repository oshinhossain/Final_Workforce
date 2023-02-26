// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_vehicle_get_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgencyVehicleGetModel _$AgencyVehicleGetModelFromJson(
        Map<String, dynamic> json) =>
    AgencyVehicleGetModel(
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
      agencyShortName: json['agencyShortName'] as String?,
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      weightCapacityUnit: json['weightCapacityUnit'] as String?,
      volumeCapacity: (json['volumeCapacity'] as num?)?.toDouble(),
      volumeCapacityUnit: json['volumeCapacityUnit'] as String?,
      seatCapacity: json['seatCapacity'] as int?,
      seatCapacityUnit: json['seatCapacityUnit'] as String?,
      weightCapacityApplicable: json['weightCapacityApplicable'] as bool?,
      volumeCapacityApplicable: json['volumeCapacityApplicable'] as bool?,
      seatCapacityApplicable: json['seatCapacityApplicable'] as bool?,
    );

Map<String, dynamic> _$AgencyVehicleGetModelToJson(
        AgencyVehicleGetModel instance) =>
    <String, dynamic>{
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
      'agencyShortName': instance.agencyShortName,
      'weightCapacity': instance.weightCapacity,
      'weightCapacityUnit': instance.weightCapacityUnit,
      'volumeCapacity': instance.volumeCapacity,
      'volumeCapacityUnit': instance.volumeCapacityUnit,
      'seatCapacity': instance.seatCapacity,
      'seatCapacityUnit': instance.seatCapacityUnit,
      'weightCapacityApplicable': instance.weightCapacityApplicable,
      'volumeCapacityApplicable': instance.volumeCapacityApplicable,
      'seatCapacityApplicable': instance.seatCapacityApplicable,
    };
