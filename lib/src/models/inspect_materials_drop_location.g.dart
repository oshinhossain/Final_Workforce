// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspect_materials_drop_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleInfo _$VehicleInfoFromJson(Map<String, dynamic> json) => VehicleInfo(
      orderId: json['orderId'] as String?,
      orderNo: json['orderNo'] as String?,
      orderDate: json['orderDate'] as String?,
      travelPathId: json['travelPathId'],
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      brand: json['brand'],
      model: json['model'] as String?,
      registrationNo: json['registrationNo'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverEmail: json['driverEmail'] as String?,
      driverMobile: json['driverMobile'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      transporterAgencyCode: json['transporterAgencyCode'] as String?,
      transporterAgencyId: json['transporterAgencyId'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      receiverAgencyId: json['receiverAgencyId'] as String?,
      receiverAgencyCode: json['receiverAgencyCode'] as String?,
      sourceLocId: json['sourceLocId'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      sourceLatitude: (json['sourceLatitude'] as num?)?.toDouble(),
      sourceLongitude: (json['sourceLongitude'] as num?)?.toDouble(),
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      dropPoint: json['dropPoint'],
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VehicleInfoToJson(VehicleInfo instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderDate': instance.orderDate,
      'travelPathId': instance.travelPathId,
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
      'transporterAgencyCode': instance.transporterAgencyCode,
      'transporterAgencyId': instance.transporterAgencyId,
      'receiverAgencyName': instance.receiverAgencyName,
      'receiverAgencyId': instance.receiverAgencyId,
      'receiverAgencyCode': instance.receiverAgencyCode,
      'sourceLocId': instance.sourceLocId,
      'sourceLocName': instance.sourceLocName,
      'sourceLatitude': instance.sourceLatitude,
      'sourceLongitude': instance.sourceLongitude,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'dropPoint': instance.dropPoint,
      'distanceKm': instance.distanceKm,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      id: json['id'] as String?,
      loadingId: json['loadingId'] as String?,
      lineNo: json['lineNo'] as int?,
      productId: json['productId'],
      productCode: json['productCode'] as String?,
      productName: json['productName'],
      productDescription: json['productDescription'],
      productBrand: json['productBrand'],
      baseUom: json['baseUom'],
      baseUomQuantity: (json['baseUomQuantity'] as num?)?.toDouble(),
      productColor: json['productColor'],
      productSize: json['productSize'],
      productSerial: json['productSerial'],
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      droppedAt: json['droppedAt'] as String?,
      droppedQuantity: (json['droppedQuantity'] as num?)?.toDouble(),
      loadedQuantity: (json['loadedQuantity'] as num?)?.toDouble(),
      dropped: json['dropped'] as bool?,
      inspectorFoundQuantityAtDroppingPoint:
          (json['inspectorFoundQuantityAtDroppingPoint'] as num?)?.toDouble() ??
              0.0,
      foundItOkayAtDroppingPoint:
          json['foundItOkayAtDroppingPoint'] as bool? ?? false,
      inspectorRemarkAtDroppingPoint:
          json['inspectorRemarkAtDroppingPoint'] as String? ?? '',
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'id': instance.id,
      'loadingId': instance.loadingId,
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
      'droppedAt': instance.droppedAt,
      'droppedQuantity': instance.droppedQuantity,
      'loadedQuantity': instance.loadedQuantity,
      'dropped': instance.dropped,
      'inspectorFoundQuantityAtDroppingPoint':
          instance.inspectorFoundQuantityAtDroppingPoint,
      'foundItOkayAtDroppingPoint': instance.foundItOkayAtDroppingPoint,
      'inspectorRemarkAtDroppingPoint': instance.inspectorRemarkAtDroppingPoint,
    };
