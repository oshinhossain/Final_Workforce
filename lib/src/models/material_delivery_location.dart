import 'package:json_annotation/json_annotation.dart';
part 'material_delivery_location.g.dart';

@JsonSerializable()
class MaterialDeliveryLoc {
  String? id;
  int? dropLocationCount;
  String? geoLevel4Name;
  String? levelFullcode;
  String? dropLocTitle;
  String? dropLocName;
  String? projectCode;

  MaterialDeliveryLoc({
    this.id,
    this.dropLocationCount,
    this.geoLevel4Name,
    this.levelFullcode,
    this.dropLocTitle,
    this.dropLocName,
    this.projectCode,
  });

  factory MaterialDeliveryLoc.fromJson(Map<String, dynamic> json) => _$MaterialDeliveryLocFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialDeliveryLocToJson(this);
}
