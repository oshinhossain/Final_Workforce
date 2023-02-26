import 'package:json_annotation/json_annotation.dart';
part 'project_dashboard_materials_requisition_model.g.dart';

@JsonSerializable()
class Projectdashboardmaterialsrequisition {
  String? id;
  String? project;
  String? date;
  String? requsitionNo;
  String? deliveryLocation;
  String? status;
  String? product;
  double? noOfMaterialsRequested;
  double? noOfMaterialsApproved;
  double? noOfMaterialsReceived;
  double? remainingMaterials;

  Projectdashboardmaterialsrequisition(
      {this.id,
      this.project,
      this.date,
      this.requsitionNo,
      this.deliveryLocation,
      this.status,
      this.product,
      this.noOfMaterialsRequested,
      this.noOfMaterialsApproved,
      this.noOfMaterialsReceived,
      this.remainingMaterials});

  factory Projectdashboardmaterialsrequisition.fromJson(
          Map<String, dynamic> json) =>
      _$ProjectdashboardmaterialsrequisitionFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ProjectdashboardmaterialsrequisitionToJson(this);
}
