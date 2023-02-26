// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_workbench_geography.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialWorkbenchGeography _$MaterialWorkbenchGeographyFromJson(
        Map<String, dynamic> json) =>
    MaterialWorkbenchGeography(
      boq: json['boq'] as num?,
      noOfProduct: json['noOfProduct'] as int?,
      geoLevel1Name: json['geoLevel1Name'] as String?,
      geoLevel2Name: json['geoLevel2Name'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      areaType: json['areaType'] as String?,
      areaLevel: json['areaLevel'] as String?,
      countryName: json['countryName'] as String?,
      etd: json['etd'] as String?,
    );

Map<String, dynamic> _$MaterialWorkbenchGeographyToJson(
        MaterialWorkbenchGeography instance) =>
    <String, dynamic>{
      'boq': instance.boq,
      'noOfProduct': instance.noOfProduct,
      'geoLevel1Name': instance.geoLevel1Name,
      'geoLevel2Name': instance.geoLevel2Name,
      'levelFullcode': instance.levelFullcode,
      'areaType': instance.areaType,
      'areaLevel': instance.areaLevel,
      'countryName': instance.countryName,
      'etd': instance.etd,
    };
