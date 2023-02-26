import 'package:json_annotation/json_annotation.dart';
part 'geography.g.dart';

@JsonSerializable()
class Geograpphy {
  String? id;
  String? countryCode;
  String? countryName;
  String? areaType;
  int? areaLevel;
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
  String? levelType;
  String? levelFullcode;

  Geograpphy({
    this.id,
    this.countryCode,
    this.countryName,
    this.areaType,
    this.areaLevel,
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
    this.levelType,
    this.levelFullcode,
  });

  factory Geograpphy.fromJson(Map<String, dynamic> json) => _$GeograpphyFromJson(json);
  Map<String, dynamic> toJson() => _$GeograpphyToJson(this);
}
