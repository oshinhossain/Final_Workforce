// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_materials_vehicle_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadMaterialsVehicleItems _$LoadMaterialsVehicleItemsFromJson(
        Map<String, dynamic> json) =>
    LoadMaterialsVehicleItems(
      id: json['id'] as String?,
      registrationNo: json['registrationNo'] as String?,
      vehicleItems: json['vehicleItems'] == null
          ? null
          : LoadMaterialsVehicleItemsList.fromJson(
              json['vehicleItems'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoadMaterialsVehicleItemsToJson(
        LoadMaterialsVehicleItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registrationNo': instance.registrationNo,
      'vehicleItems': instance.vehicleItems,
    };
