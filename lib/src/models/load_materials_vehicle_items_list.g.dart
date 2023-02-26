// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_materials_vehicle_items_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadMaterialsVehicleItemsList _$LoadMaterialsVehicleItemsListFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsVehicleItemsList(
      id: json['id'] as String?,
      orderId: json['orderId'] as String?,
      orderNo: json['orderNo'] as String?,
      orderDate: json['orderDate'] as String?,
      vehicleId: json['vehicleId'] as String?,
      vehicleType: json['vehicleType'] as String?,
      capacity: json['capacity'] as String?,
      model: json['model'] as String?,
      brand: json['brand'] as String?,
      registrationNo: json['registrationNo'] as String?,
      typeOfFuel: json['typeOfFuel'] as String?,
      driverUsername: json['driverUsername'] as String?,
      driverFullname: json['driverFullname'] as String?,
      driverMobile: json['driverMobile'] as String?,
      driverEmail: json['driverEmail'] as String?,
      productName: json['productName'] as String?,
      productCode: json['productCode'] as String?,
      productSerial: json['productSerial'] as String?,
      lineNo: (json['lineNo'] as num?)?.toDouble(),
      baseUom: json['baseUom'] as String?,
      productId: json['productId'] as String?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      loaded: json['loaded'] as bool?,
      loadedAt: json['loadedAt'] as String?,
      loadedQuantity: (json['loadedQuantity'] as num?)?.toDouble(),
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LoadMaterialsVehicleItemsListToJson(
        LoadMaterialsVehicleItemsList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderDate': instance.orderDate,
      'vehicleId': instance.vehicleId,
      'vehicleType': instance.vehicleType,
      'capacity': instance.capacity,
      'model': instance.model,
      'brand': instance.brand,
      'registrationNo': instance.registrationNo,
      'typeOfFuel': instance.typeOfFuel,
      'driverUsername': instance.driverUsername,
      'driverFullname': instance.driverFullname,
      'driverMobile': instance.driverMobile,
      'driverEmail': instance.driverEmail,
      'productName': instance.productName,
      'productCode': instance.productCode,
      'productSerial': instance.productSerial,
      'lineNo': instance.lineNo,
      'baseUom': instance.baseUom,
      'productId': instance.productId,
      'weightKg': instance.weightKg,
      'loaded': instance.loaded,
      'loadedAt': instance.loadedAt,
      'loadedQuantity': instance.loadedQuantity,
      'distanceKm': instance.distanceKm,
    };
