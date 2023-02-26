// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_materials_to_vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadMaterialsTransportOrder _$LoadMaterialsTransportOrderFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsTransportOrder(
      id: json['id'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      inspectorAtLoadingPointFullname:
          json['inspectorAtLoadingPointFullname'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      inspectorAtLoadingPointUsername:
          json['inspectorAtLoadingPointUsername'] as String?,
    );

Map<String, dynamic> _$LoadMaterialsTransportOrderToJson(
        LoadMaterialsTransportOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'transporterAgencyName': instance.transporterAgencyName,
      'sourceLocName': instance.sourceLocName,
      'inspectorAtLoadingPointFullname':
          instance.inspectorAtLoadingPointFullname,
      'inspectorAtLoadingPointUsername':
          instance.inspectorAtLoadingPointUsername,
    };

LoadMaterialsVehicle _$LoadMaterialsVehicleFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsVehicle(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      sourceLatitude: (json['sourceLatitude'] as num?)?.toDouble(),
      sourceLongitude: (json['sourceLongitude'] as num?)?.toDouble(),
      destinationLatitude: (json['destinationLatitude'] as num?)?.toDouble(),
      destinationLongitude: (json['destinationLongitude'] as num?)?.toDouble(),
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      hasDriverAccepted: json['hasDriverAccepted'] as bool?,
      singleDestinationLoc: json['singleDestinationLoc'] as bool?,
      vehicleReady: json['vehicleReady'] as bool?,
      vehicleStarted: json['vehicleStarted'] as bool?,
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      weightCapacityUnit: json['weightCapacityUnit'] as String?,
    );

Map<String, dynamic> _$LoadMaterialsVehicleToJson(
        LoadMaterialsVehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'sourceLatitude': instance.sourceLatitude,
      'sourceLongitude': instance.sourceLongitude,
      'destinationLatitude': instance.destinationLatitude,
      'destinationLongitude': instance.destinationLongitude,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'brand': instance.brand,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'hasDriverAccepted': instance.hasDriverAccepted,
      'singleDestinationLoc': instance.singleDestinationLoc,
      'vehicleReady': instance.vehicleReady,
      'vehicleStarted': instance.vehicleStarted,
      'weightCapacity': instance.weightCapacity,
      'weightCapacityUnit': instance.weightCapacityUnit,
    };

LoadMaterialsItemList _$LoadMaterialsItemListFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsItemList(
      id: json['id'] as String?,
      lineNo: (json['lineNo'] as num?)?.toDouble(),
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      baseUom: json['baseUom'] as String?,
      baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      productSerial: json['productSerial'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LoadMaterialsItemListToJson(
        LoadMaterialsItemList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'weightKg': instance.weightKg,
      'baseUom': instance.baseUom,
      'baseUomQuantity': instance.baseUomQuantity,
      'lineNo': instance.lineNo,
      'productSerial': instance.productSerial,
      'distanceKm': instance.distanceKm,
    };

LoadMaterialsVehicleEvidence _$LoadMaterialsVehicleEvidenceFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsVehicleEvidence(
      id: json['id'] as String?,
      registrationNo: json['registrationNo'] as String?,
      imagePath: json['imagePath'] as String?,
      fileName: json['fileName'] as String?,
    );

Map<String, dynamic> _$LoadMaterialsVehicleEvidenceToJson(
        LoadMaterialsVehicleEvidence instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registrationNo': instance.registrationNo,
      'imagePath': instance.imagePath,
      'fileName': instance.fileName,
    };
