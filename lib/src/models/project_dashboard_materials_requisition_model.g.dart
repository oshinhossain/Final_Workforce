// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dashboard_materials_requisition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Projectdashboardmaterialsrequisition
    _$ProjectdashboardmaterialsrequisitionFromJson(Map<String, dynamic> json) =>
        Projectdashboardmaterialsrequisition(
          id: json['id'] as String?,
          project: json['project'] as String?,
          date: json['date'] as String?,
          requsitionNo: json['requsitionNo'] as String?,
          deliveryLocation: json['deliveryLocation'] as String?,
          status: json['status'] as String?,
          product: json['product'] as String?,
          noOfMaterialsRequested:
              (json['noOfMaterialsRequested'] as num?)?.toDouble(),
          noOfMaterialsApproved:
              (json['noOfMaterialsApproved'] as num?)?.toDouble(),
          noOfMaterialsReceived:
              (json['noOfMaterialsReceived'] as num?)?.toDouble(),
          remainingMaterials: (json['remainingMaterials'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$ProjectdashboardmaterialsrequisitionToJson(
        Projectdashboardmaterialsrequisition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project': instance.project,
      'date': instance.date,
      'requsitionNo': instance.requsitionNo,
      'deliveryLocation': instance.deliveryLocation,
      'status': instance.status,
      'product': instance.product,
      'noOfMaterialsRequested': instance.noOfMaterialsRequested,
      'noOfMaterialsApproved': instance.noOfMaterialsApproved,
      'noOfMaterialsReceived': instance.noOfMaterialsReceived,
      'remainingMaterials': instance.remainingMaterials,
    };
