// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_workbench_geography_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialWorkbenchGeoDetail _$MaterialWorkbenchGeoDetailFromJson(
        Map<String, dynamic> json) =>
    MaterialWorkbenchGeoDetail(
      id: json['id'] as String?,
      budgetId: json['budgetId'] as String?,
      tentativeEtd: json['tentativeEtd'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      productSubGroupCode: json['productSubGroupCode'] as String?,
      productSubGroupFullcode: json['productSubGroupFullcode'] as String?,
      productSubGroupName: json['productSubGroupName'] as String?,
      productGroupId: json['productGroupId'] as String?,
      productGroupCode: json['productGroupCode'] as String?,
      productGroupFullcode: json['productGroupFullcode'] as String?,
      productGroupName: json['productGroupName'] as String?,
      productSubgroupId: json['productSubgroupId'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      productId: json['productId'] as String?,
      projectName: json['projectName'] as String?,
      baseUomQuantity: json['baseUomQuantity'] as num?,
      productFullcode: json['productFullcode'] as String?,
      productName: json['productName'] as String?,
      baseUom: json['baseUom'] as String?,
    );

Map<String, dynamic> _$MaterialWorkbenchGeoDetailToJson(
        MaterialWorkbenchGeoDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'budgetId': instance.budgetId,
      'tentativeEtd': instance.tentativeEtd,
      'quantity': instance.quantity,
      'productSubGroupCode': instance.productSubGroupCode,
      'productSubGroupFullcode': instance.productSubGroupFullcode,
      'productSubGroupName': instance.productSubGroupName,
      'productGroupId': instance.productGroupId,
      'productGroupCode': instance.productGroupCode,
      'productGroupFullcode': instance.productGroupFullcode,
      'productGroupName': instance.productGroupName,
      'productSubgroupId': instance.productSubgroupId,
      'levelFullcode': instance.levelFullcode,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'productId': instance.productId,
      'projectName': instance.projectName,
      'baseUomQuantity': instance.baseUomQuantity,
      'productFullcode': instance.productFullcode,
      'productName': instance.productName,
      'baseUom': instance.baseUom,
    };
