// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_requisition_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialRequsitionAdd _$MaterialRequsitionAddFromJson(
        Map<String, dynamic> json) =>
    MaterialRequsitionAdd(
      masterViewModel: json['masterViewModel'] == null
          ? null
          : MasterViewModel.fromJson(
              json['masterViewModel'] as Map<String, dynamic>),
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      requisitionDate: json['requisitionDate'] as String?,
      etdDate: json['etdDate'] as String?,
      projectId: json['projectId'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: json['dropLatitude'] as String?,
      dropLongitude: json['dropLongitude'] as String?,
      ordererPartyType: json['ordererPartyType'] as String?,
      ordererFullname: json['ordererFullname'] as String?,
      ordererUsername: json['ordererUsername'] as String?,
      ordererEmail: json['ordererEmail'] as String?,
      ordererMobile: json['ordererMobile'] as String?,
      orderingAgencyId: json['orderingAgencyId'] as String?,
      orderingAgencyCode: json['orderingAgencyCode'] as String?,
      orderingAgencyName: json['orderingAgencyName'] as String?,
      supplierPartyType: json['supplierPartyType'] as String?,
      supplierFullname: json['supplierFullname'] as String?,
      supplierUsername: json['supplierUsername'] as String?,
      supplierEmail: json['supplierEmail'] as String?,
      supplierMobile: json['supplierMobile'] as String?,
      supplyingAgencyId: json['supplyingAgencyId'] as String?,
      supplyingAgencyCode: json['supplyingAgencyCode'] as String?,
      supplyingAgencyName: json['supplyingAgencyName'] as String?,
      overallRemarks: json['overallRemarks'] as String?,
      materialRequisitionLines:
          (json['materialRequisitionLines'] as List<dynamic>?)
              ?.map((e) =>
                  MaterialRequisitionLines.fromJson(e as Map<String, dynamic>))
              .toList(),
    )..areaIds =
        (json['areaIds'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$MaterialRequsitionAddToJson(
        MaterialRequsitionAdd instance) =>
    <String, dynamic>{
      'masterViewModel': instance.masterViewModel,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'requisitionDate': instance.requisitionDate,
      'etdDate': instance.etdDate,
      'projectId': instance.projectId,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'ordererPartyType': instance.ordererPartyType,
      'ordererFullname': instance.ordererFullname,
      'ordererUsername': instance.ordererUsername,
      'ordererEmail': instance.ordererEmail,
      'ordererMobile': instance.ordererMobile,
      'orderingAgencyId': instance.orderingAgencyId,
      'orderingAgencyCode': instance.orderingAgencyCode,
      'orderingAgencyName': instance.orderingAgencyName,
      'supplierPartyType': instance.supplierPartyType,
      'supplierFullname': instance.supplierFullname,
      'supplierUsername': instance.supplierUsername,
      'supplierEmail': instance.supplierEmail,
      'supplierMobile': instance.supplierMobile,
      'supplyingAgencyId': instance.supplyingAgencyId,
      'supplyingAgencyCode': instance.supplyingAgencyCode,
      'supplyingAgencyName': instance.supplyingAgencyName,
      'overallRemarks': instance.overallRemarks,
      'areaIds': instance.areaIds,
      'materialRequisitionLines': instance.materialRequisitionLines,
    };

MaterialRequisitionLines _$MaterialRequisitionLinesFromJson(
        Map<String, dynamic> json) =>
    MaterialRequisitionLines(
      productId: json['productId'] as String?,
      productCode: json['productCode'] as String?,
      baseUomQuantity: json['baseUomQuantity'] as String?,
      dropLocId: json['dropLocId'] as String?,
      dropLocName: json['dropLocName'] as String?,
      dropLatitude: json['dropLatitude'] as String?,
      dropLongitude: json['dropLongitude'] as String?,
    );

Map<String, dynamic> _$MaterialRequisitionLinesToJson(
        MaterialRequisitionLines instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productCode': instance.productCode,
      'baseUomQuantity': instance.baseUomQuantity,
      'dropLocId': instance.dropLocId,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
    };

MasterViewModel _$MasterViewModelFromJson(Map<String, dynamic> json) =>
    MasterViewModel(
      apiKey: json['apiKey'] as String?,
      appCode: json['appCode'] as String?,
      username: json['username'] as String?,
      agencyIds: (json['agencyIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MasterViewModelToJson(MasterViewModel instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'appCode': instance.appCode,
      'username': instance.username,
      'agencyIds': instance.agencyIds,
    };
