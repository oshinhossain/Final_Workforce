// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialItem _$MaterialItemFromJson(Map<String, dynamic> json) => MaterialItem(
      id: json['id'] as String?,
      areaLevel: json['areaLevel'] as int?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      geoLevel1Id: json['geoLevel1Id'] as String?,
      geoLevel1Code: json['geoLevel1Code'] as String?,
      geoLevel1Name: json['geoLevel1Name'] as String?,
      geoLevel2id: json['geoLevel2id'] as String?,
      geoLevel2Code: json['geoLevel2Code'] as String?,
      geoLevel2Name: json['geoLevel2Name'] as String?,
      geoLevel3Id: json['geoLevel3Id'] as String?,
      geoLevel3Code: json['geoLevel3Code'] as String?,
      geoLevel3Name: json['geoLevel3Name'] as String?,
      geoLevel4Id: json['geoLevel4Id'] as String?,
      geoLevel4Code: json['geoLevel4Code'] as String?,
      geoLevel4Name: json['geoLevel4Name'] as String?,
      productBrand: json['productBrand'] as String?,
      demandUom: json['demandUom'] as String?,
      productCode: json['productCode'] as String?,
      demandUomQuantity: (json['demandUomQuantity'] as num?)?.toDouble(),
      productDescription: json['productDescription'] as String?,
      productFullcode: json['productFullcode'] as String?,
      productName: json['productName'] as String?,
      poleCnt: json['poleCnt'] as int?,
      levelFullcode: json['levelFullcode'] as String?,
      dropLocTitle: json['dropLocTitle'] as String?,
      productId: json['productId'] as String?,
    )..productFullCode = json['productFullCode'] as String?;

Map<String, dynamic> _$MaterialItemToJson(MaterialItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'areaLevel': instance.areaLevel,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'geoLevel1Id': instance.geoLevel1Id,
      'geoLevel1Code': instance.geoLevel1Code,
      'geoLevel1Name': instance.geoLevel1Name,
      'geoLevel2id': instance.geoLevel2id,
      'geoLevel2Code': instance.geoLevel2Code,
      'geoLevel2Name': instance.geoLevel2Name,
      'geoLevel3Id': instance.geoLevel3Id,
      'geoLevel3Code': instance.geoLevel3Code,
      'geoLevel3Name': instance.geoLevel3Name,
      'geoLevel4Id': instance.geoLevel4Id,
      'geoLevel4Code': instance.geoLevel4Code,
      'geoLevel4Name': instance.geoLevel4Name,
      'productCode': instance.productCode,
      'productFullCode': instance.productFullCode,
      'productBrand': instance.productBrand,
      'demandUom': instance.demandUom,
      'demandUomQuantity': instance.demandUomQuantity,
      'productDescription': instance.productDescription,
      'productFullcode': instance.productFullcode,
      'productName': instance.productName,
      'poleCnt': instance.poleCnt,
      'levelFullcode': instance.levelFullcode,
      'dropLocTitle': instance.dropLocTitle,
      'productId': instance.productId,
    };
