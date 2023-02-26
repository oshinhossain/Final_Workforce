import 'package:json_annotation/json_annotation.dart';

import 'geography.dart';
part 'material_location_planning.g.dart';

@JsonSerializable()
class MaterialLocationPlanning {
  String? id;
  // int? geographyNo;
  // String? deliveryLocation;
  // String? areaName;

  int? dropLocationCount;
  String? geoLevel4Name;
  String? levelFullcode;
  String? dropLocTitle;
  String? dropLocName;
  String? projectCode;

  List<Geograpphy>? geograpphy;

  MaterialLocationPlanning({
    this.id,
    // this.geographyNo,
    // this.deliveryLocation,
    // this.areaName,

    this.dropLocationCount,
    this.geoLevel4Name,
    this.levelFullcode,
    this.dropLocTitle,
    this.dropLocName,
    this.projectCode,
    this.geograpphy,
  });

  factory MaterialLocationPlanning.fromJson(Map<String, dynamic> json) => _$MaterialLocationPlanningFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialLocationPlanningToJson(this);
}
