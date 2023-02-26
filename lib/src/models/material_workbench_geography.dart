import 'package:json_annotation/json_annotation.dart';
part 'material_workbench_geography.g.dart';

@JsonSerializable()
class MaterialWorkbenchGeography {
  num? boq;
  int? noOfProduct;
  String? geoLevel1Name;
  String? geoLevel2Name;
  String? levelFullcode;
  String? areaType;
  String? areaLevel;
  String? countryName;
  String? etd;

  MaterialWorkbenchGeography(
      {this.boq,
      this.noOfProduct,
      this.geoLevel1Name,
      this.geoLevel2Name,
      this.levelFullcode,
      this.areaType,
      this.areaLevel,
      this.countryName,
      this.etd});

  factory MaterialWorkbenchGeography.fromJson(Map<String, dynamic> json) => _$MaterialWorkbenchGeographyFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialWorkbenchGeographyToJson(this);
}
