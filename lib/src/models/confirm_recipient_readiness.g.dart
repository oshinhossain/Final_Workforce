// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_recipient_readiness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleInfo _$VehicleInfoFromJson(Map<String, dynamic> json) => VehicleInfo(
      orderId: json['orderId'] as String?,
      orderNo: json['orderNo'] as String?,
      orderDate: json['orderDate'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      transporterAgencyId: json['transporterAgencyId'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      receiverAgencyId: json['receiverAgencyId'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropPoint: json['dropPoint'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VehicleInfoToJson(VehicleInfo instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderDate': instance.orderDate,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'brand': instance.brand,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'transporterAgencyName': instance.transporterAgencyName,
      'transporterAgencyId': instance.transporterAgencyId,
      'receiverAgencyName': instance.receiverAgencyName,
      'receiverAgencyId': instance.receiverAgencyId,
      'sourceLocName': instance.sourceLocName,
      'dropLocName': instance.dropLocName,
      'dropPoint': instance.dropPoint,
      'distanceKm': instance.distanceKm,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      loadingId: json['loadingId'] as String?,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      baseUom: json['baseUom'] as String?,
      baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
      productSerial: json['productSerial'] as String?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      droppedAt: json['droppedAt'] as String?,
      droppedQuantity: (json['droppedQuantity'] as num?)?.toDouble(),
      dropped: json['dropped'] as bool?,
    )..updateReceivedQuantity =
        (json['updateReceivedQuantity'] as num?)?.toDouble() ?? 0.0;

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'loadingId': instance.loadingId,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'baseUom': instance.baseUom,
      'baseUomQuantity': instance.baseUomQuantity,
      'productSerial': instance.productSerial,
      'weightKg': instance.weightKg,
      'weightCapacity': instance.weightCapacity,
      'droppedAt': instance.droppedAt,
      'droppedQuantity': instance.droppedQuantity,
      'dropped': instance.dropped,
      'updateReceivedQuantity': instance.updateReceivedQuantity,
    };

ConfirmRecipientReadiness _$ConfirmRecipientReadinessFromJson(
        Map<String, dynamic> json) =>
    ConfirmRecipientReadiness(
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      transporterPartyName: json['transporterPartyName'] as String?,
      receivingPartyName: json['receivingPartyName'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      destinationLocName: json['destinationLocName'] as String?,
      vehicleId: json['vehicleId'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
    )..updateReceivedQuantity =
        (json['updateReceivedQuantity'] as num?)?.toDouble() ?? 0.0;

Map<String, dynamic> _$ConfirmRecipientReadinessToJson(
        ConfirmRecipientReadiness instance) =>
    <String, dynamic>{
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'transporterPartyName': instance.transporterPartyName,
      'receivingPartyName': instance.receivingPartyName,
      'sourceLocName': instance.sourceLocName,
      'destinationLocName': instance.destinationLocName,
      'vehicleId': instance.vehicleId,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'brand': instance.brand,
      'registrationNo': instance.registrationNo,
      'driverFullname': instance.driverFullname,
      'updateReceivedQuantity': instance.updateReceivedQuantity,
    };

TransportOrderLoadingModels _$TransportOrderLoadingModelsFromJson(
        Map<String, dynamic> json) =>
    TransportOrderLoadingModels(
      id: json['id'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'],
      transportOrderId: json['transportOrderId'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      vehicleId: json['vehicleId'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      startSerialNo: json['startSerialNo'],
      finishSerialNo: json['finishSerialNo'],
      lineNo: json['lineNo'] as num?,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      productDescription: json['productDescription'] as String?,
      productBrand: json['productBrand'],
      baseUom: json['baseUom'],
      baseUomQuantity: json['baseUomQuantity'] as num?,
      productColor: json['productColor'] as String?,
      productSize: json['productSize'],
      productSerial: json['productSerial'],
      weightKg: json['weightKg'] as num?,
      weightCapacity: (json['weightCapacity'] as num?)?.toDouble(),
      loadedAt: json['loadedAt'] as String?,
      loadedQuantity: json['loadedQuantity'] as num?,
      droppedAt: json['droppedAt'],
      droppedQuantity: json['droppedQuantity'] as num?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      distanceKm: json['distanceKm'] as num?,
      receiverReadyAt: json['receiverReadyAt'],
      receiverRemarkWhileReady: json['receiverRemarkWhileReady'],
      receivedAt: json['receivedAt'],
      receivedQuantity: json['receivedQuantity'] as num?,
      receiverRemarkWhileReceived: json['receiverRemarkWhileReceived'],
      receiverFullname: json['receiverFullname'] as String?,
      receiverUsername: json['receiverUsername'] as String?,
      receiverEmail: json['receiverEmail'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      inspectorFoundQuantityAtDroppingPoint:
          json['inspectorFoundQuantityAtDroppingPoint'] as num?,
      inspectorRemarkAtDroppingPoint: json['inspectorRemarkAtDroppingPoint'],
      inspectorFullnameAtDroppingPoint:
          json['inspectorFullnameAtDroppingPoint'],
      inspectorUsernameAtDroppingPoint:
          json['inspectorUsernameAtDroppingPoint'],
      inspectorEmailAtDroppingPoint: json['inspectorEmailAtDroppingPoint'],
      inspectorMobileAtDroppingPoint: json['inspectorMobileAtDroppingPoint'],
      digest: json['digest'],
      masterViewModel: json['masterViewModel'],
      loaded: json['loaded'] as bool?,
      vehicleReady: json['vehicleReady'] as bool?,
      receiverReady: json['receiverReady'] as bool?,
      vehicleStarted: json['vehicleStarted'] as bool?,
      dropped: json['dropped'] as bool?,
      foundItOkayAtDroppingPoint: json['foundItOkayAtDroppingPoint'] as bool?,
      received: json['received'] as bool?,
      updateReceivedQuantity:
          (json['updateReceivedQuantity'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$TransportOrderLoadingModelsToJson(
        TransportOrderLoadingModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'transportOrderId': instance.transportOrderId,
      'transportOrderNo': instance.transportOrderNo,
      'transportOrderDate': instance.transportOrderDate,
      'vehicleId': instance.vehicleId,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'brand': instance.brand,
      'model': instance.model,
      'registrationNo': instance.registrationNo,
      'driverFullname': instance.driverFullname,
      'driverUsername': instance.driverUsername,
      'driverEmail': instance.driverEmail,
      'driverMobile': instance.driverMobile,
      'startSerialNo': instance.startSerialNo,
      'finishSerialNo': instance.finishSerialNo,
      'lineNo': instance.lineNo,
      'productId': instance.productId,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'productBrand': instance.productBrand,
      'baseUom': instance.baseUom,
      'baseUomQuantity': instance.baseUomQuantity,
      'productColor': instance.productColor,
      'productSize': instance.productSize,
      'productSerial': instance.productSerial,
      'weightKg': instance.weightKg,
      'weightCapacity': instance.weightCapacity,
      'loadedAt': instance.loadedAt,
      'loadedQuantity': instance.loadedQuantity,
      'droppedAt': instance.droppedAt,
      'droppedQuantity': instance.droppedQuantity,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'distanceKm': instance.distanceKm,
      'receiverReadyAt': instance.receiverReadyAt,
      'receiverRemarkWhileReady': instance.receiverRemarkWhileReady,
      'receivedAt': instance.receivedAt,
      'receivedQuantity': instance.receivedQuantity,
      'receiverRemarkWhileReceived': instance.receiverRemarkWhileReceived,
      'receiverFullname': instance.receiverFullname,
      'receiverUsername': instance.receiverUsername,
      'receiverEmail': instance.receiverEmail,
      'receiverMobile': instance.receiverMobile,
      'inspectorFoundQuantityAtDroppingPoint':
          instance.inspectorFoundQuantityAtDroppingPoint,
      'inspectorRemarkAtDroppingPoint': instance.inspectorRemarkAtDroppingPoint,
      'inspectorFullnameAtDroppingPoint':
          instance.inspectorFullnameAtDroppingPoint,
      'inspectorUsernameAtDroppingPoint':
          instance.inspectorUsernameAtDroppingPoint,
      'inspectorEmailAtDroppingPoint': instance.inspectorEmailAtDroppingPoint,
      'inspectorMobileAtDroppingPoint': instance.inspectorMobileAtDroppingPoint,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
      'loaded': instance.loaded,
      'vehicleReady': instance.vehicleReady,
      'receiverReady': instance.receiverReady,
      'vehicleStarted': instance.vehicleStarted,
      'dropped': instance.dropped,
      'foundItOkayAtDroppingPoint': instance.foundItOkayAtDroppingPoint,
      'received': instance.received,
      'updateReceivedQuantity': instance.updateReceivedQuantity,
    };