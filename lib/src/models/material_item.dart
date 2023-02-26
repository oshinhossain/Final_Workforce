import 'package:json_annotation/json_annotation.dart';
part 'material_item.g.dart';

@JsonSerializable()
class MaterialItem {
  String? id;
  int? areaLevel;
  String? countryCode;
  String? countryName;
  String? geoLevel1Id;
  String? geoLevel1Code;
  String? geoLevel1Name;
  String? geoLevel2id;
  String? geoLevel2Code;
  String? geoLevel2Name;
  String? geoLevel3Id;
  String? geoLevel3Code;
  String? geoLevel3Name;
  String? geoLevel4Id;
  String? geoLevel4Code;
  String? geoLevel4Name;

  String? productCode;

  String? productFullCode;

  String? productBrand;
  String? demandUom;
  double? demandUomQuantity;

  String? productDescription;
  String? productFullcode;
  String? productName;
  int? poleCnt;
  String? levelFullcode;
  String? dropLocTitle;
  String? productId;

  MaterialItem({
    this.id,
    this.areaLevel,
    this.countryCode,
    this.countryName,
    this.geoLevel1Id,
    this.geoLevel1Code,
    this.geoLevel1Name,
    this.geoLevel2id,
    this.geoLevel2Code,
    this.geoLevel2Name,
    this.geoLevel3Id,
    this.geoLevel3Code,
    this.geoLevel3Name,
    this.geoLevel4Id,
    this.geoLevel4Code,
    this.geoLevel4Name,
    this.productBrand,
    this.demandUom,
    this.productCode,
    this.demandUomQuantity,
    this.productDescription,
    this.productFullcode,
    this.productName,
    this.poleCnt,
    this.levelFullcode,
    this.dropLocTitle,
    this.productId,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) => _$MaterialItemFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialItemToJson(this);
}
