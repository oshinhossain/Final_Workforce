// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unload_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnloadMaterial _$UnloadMaterialFromJson(Map<String, dynamic> json) =>
    UnloadMaterial(
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemList.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicleInfo: json['vehicleInfo'] == null
          ? null
          : VehicleInfo.fromJson(json['vehicleInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnloadMaterialToJson(UnloadMaterial instance) =>
    <String, dynamic>{
      'itemList': instance.itemList,
      'vehicleInfo': instance.vehicleInfo,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      loadingId: json['loadingId'] as String?,
      lineNo: json['lineNo'] as num?,
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      productName: json['productName'] as String?,
      productDescription: json['productDescription'] as String?,
      productBrand: json['productBrand'] as String?,
      baseUom: json['baseUom'] as String?,
      baseUomQuantity: json['baseUomQuantity'] as num?,
      productColor: json['productColor'] as String?,
      productSize: json['productSize'] as String?,
      productSerial: json['productSerial'] as String?,
      weightKg: json['weightKg'] as num?,
      droppedAt: json['droppedAt'] as String?,
      droppedQuantity: (json['droppedQuantity'] as num?)?.toDouble(),
      loadedQuantity: (json['loadedQuantity'] as num?)?.toDouble(),
      dropped: json['dropped'] as bool?,
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
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
    };

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
      transporterAgencyCode: json['transporterAgencyCode'] as String?,
      transporterAgencyId: json['transporterAgencyId'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      receiverAgencyId: json['receiverAgencyId'] as String?,
      receiverAgencyCode: json['receiverAgencyCode'] as String?,
      sourceLocId: json['sourceLocId'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      sourceLatitude: json['sourceLatitude'] as num?,
      sourceLongitude: json['sourceLongitude'] as num?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: json['dropLatitude'] as num?,
      dropLongitude: json['dropLongitude'] as num?,
      dropPoint: json['dropPoint'] as num?,
      distanceKm: json['distanceKm'] as num?,
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
