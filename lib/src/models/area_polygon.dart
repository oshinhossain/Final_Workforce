import 'package:json_annotation/json_annotation.dart';
part 'area_polygon.g.dart';

@JsonSerializable()
class AreaPolygon {
  String? id;
  String? apiKey;
  String? areaId;
  String? areaFullCode;
  String? searchText;
  int? imageSeq;
  String? latitude;
  String? longitude;
  String? areaType;
  int? areaLevel;
  String? levelType;
  String? polygonFormat;
  String? continentName;
  String? countryTelcode;
  String? level0Id;
  String? level0Code;
  String? level0Name;
  String? level1Id;
  String? level1Code;
  String? level1Name;
  String? level2Id;
  String? level2Code;
  String? level2Name;
  String? level3Id;
  String? level3Code;
  String? level3Name;
  String? level4Id;
  String? level4Code;
  String? level4Name;
  String? level5Id;
  String? level5Code;
  String? level5Name;
  String? level6Id;
  String? level6Code;
  String? level6Name;
  String? level7Id;
  String? level7Code;
  String? level7Name;
  String? level8Id;
  String? level8Code;
  String? level8Name;
  String? level9Id;
  String? level9Code;
  String? level9Name;
  String? areaPolygonBinary;

  String? areaPointBinary;
  String? level0Type;
  String? level1Type;
  String? level2Type;
  String? level3Type;
  String? level4Type;
  String? level5Type;
  String? level6Type;
  String? level7Type;
  String? level8Type;
  String? level9Type;
  int? highestLevelImplemented;
  String? officePhone;
  String? officeEmail;
  String? officeWebsite;
  String? officeAddress;
  String? localLangName;
  String? officeIncharge;
  double? officeLatitude;
  int? areaSkm;
  double? officeLongitude;
  num? geographyPoint;
  int? totalPopulation;
  int? populationMale;
  int? populationFemale;
  int? youngBoys;
  int? youngGirls;
  int? transGender;
  int? employedMale;
  int? employedFemale;
  int? unemployedMale;
  int? unemployedFemale;
  int? educatedMale;
  int? educatedFemale;
  int? densityPerSkm;
  int? totalHouseholds;
  bool? polygonNeeded;
  bool? multiPolygonNeeded;
  bool? imageNeeded;
  int? imageNo;

  AreaPolygon(
      {this.id,
      this.apiKey,
      this.areaId,
      this.areaFullCode,
      this.searchText,
      this.imageSeq,
      this.latitude,
      this.longitude,
      this.areaType,
      this.areaLevel,
      this.levelType,
      this.polygonFormat,
      this.continentName,
      this.countryTelcode,
      this.level0Id,
      this.level0Code,
      this.level0Name,
      this.level1Id,
      this.level1Code,
      this.level1Name,
      this.level2Id,
      this.level2Code,
      this.level2Name,
      this.level3Id,
      this.level3Code,
      this.level3Name,
      this.level4Id,
      this.level4Code,
      this.level4Name,
      this.level5Id,
      this.level5Code,
      this.level5Name,
      this.level6Id,
      this.level6Code,
      this.level6Name,
      this.level7Id,
      this.level7Code,
      this.level7Name,
      this.level8Id,
      this.level8Code,
      this.level8Name,
      this.level9Id,
      this.level9Code,
      this.level9Name,
      this.areaPolygonBinary,
      this.areaPointBinary,
      this.level0Type,
      this.level1Type,
      this.level2Type,
      this.level3Type,
      this.level4Type,
      this.level5Type,
      this.level6Type,
      this.level7Type,
      this.level8Type,
      this.level9Type,
      this.highestLevelImplemented,
      this.officePhone,
      this.officeEmail,
      this.officeWebsite,
      this.officeAddress,
      this.localLangName,
      this.officeIncharge,
      this.officeLatitude,
      this.areaSkm,
      this.officeLongitude,
      this.geographyPoint,
      this.totalPopulation,
      this.populationMale,
      this.populationFemale,
      this.youngBoys,
      this.youngGirls,
      this.transGender,
      this.employedMale,
      this.employedFemale,
      this.unemployedMale,
      this.unemployedFemale,
      this.educatedMale,
      this.educatedFemale,
      this.densityPerSkm,
      this.totalHouseholds,
      this.polygonNeeded,
      this.multiPolygonNeeded,
      this.imageNeeded,
      this.imageNo});

  factory AreaPolygon.fromJson(Map<String, dynamic> json) => _$AreaPolygonFromJson(json);
  Map<String, dynamic> toJson() => _$AreaPolygonToJson(this);
}
