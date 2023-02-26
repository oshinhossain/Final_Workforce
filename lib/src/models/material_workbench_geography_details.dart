import 'package:json_annotation/json_annotation.dart';
part 'material_workbench_geography_details.g.dart';

@JsonSerializable()
class MaterialWorkbenchGeoDetail {
  String? id;

  String? budgetId;
  String? tentativeEtd;
  double? quantity;
  String? productSubGroupCode;
  String? productSubGroupFullcode;
  String? productSubGroupName;

  String? productGroupId;
  String? productGroupCode;
  String? productGroupFullcode;
  String? productGroupName;
  String? productSubgroupId;

  String? levelFullcode;
  double? dropLatitude;
  double? dropLongitude;
  String? productId;

  String? projectName;
  num? baseUomQuantity;

  String? productFullcode;
  String? productName;
  String? baseUom;

  MaterialWorkbenchGeoDetail({
    this.id,
    this.budgetId,
    this.tentativeEtd,
    this.quantity,
    this.productSubGroupCode,
    this.productSubGroupFullcode,
    this.productSubGroupName,
    this.productGroupId,
    this.productGroupCode,
    this.productGroupFullcode,
    this.productGroupName,
    this.productSubgroupId,
    this.levelFullcode,
    this.dropLatitude,
    this.dropLongitude,
    this.productId,
    this.projectName,
    this.baseUomQuantity,
    this.productFullcode,
    this.productName,
    this.baseUom,
  });

  factory MaterialWorkbenchGeoDetail.fromJson(Map<String, dynamic> json) => _$MaterialWorkbenchGeoDetailFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialWorkbenchGeoDetailToJson(this);
}
