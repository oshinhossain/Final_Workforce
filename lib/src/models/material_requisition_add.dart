import 'package:json_annotation/json_annotation.dart';
part 'material_requisition_add.g.dart';

@JsonSerializable()
class MaterialRequsitionAdd {
  MasterViewModel? masterViewModel;
  String? countryCode;
  String? countryName;
  String? requisitionDate;
  String? etdDate;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? dropLocId;
  String? dropLocName;
  String? dropLatitude;
  String? dropLongitude;
  String? ordererPartyType;
  String? ordererFullname;
  String? ordererUsername;
  String? ordererEmail;
  String? ordererMobile;
  String? orderingAgencyId;
  String? orderingAgencyCode;
  String? orderingAgencyName;
  String? supplierPartyType;
  String? supplierFullname;
  String? supplierUsername;
  String? supplierEmail;
  String? supplierMobile;
  String? supplyingAgencyId;
  String? supplyingAgencyCode;
  String? supplyingAgencyName;
  String? overallRemarks;
  List<String>? areaIds;
  List<MaterialRequisitionLines>? materialRequisitionLines;

  MaterialRequsitionAdd({
    this.masterViewModel,
    this.countryCode,
    this.countryName,
    this.requisitionDate,
    this.etdDate,
    this.projectId,
    this.projectCode,
    this.projectName,
    this.dropLocId,
    this.dropLocName,
    this.dropLatitude,
    this.dropLongitude,
    this.ordererPartyType,
    this.ordererFullname,
    this.ordererUsername,
    this.ordererEmail,
    this.ordererMobile,
    this.orderingAgencyId,
    this.orderingAgencyCode,
    this.orderingAgencyName,
    this.supplierPartyType,
    this.supplierFullname,
    this.supplierUsername,
    this.supplierEmail,
    this.supplierMobile,
    this.supplyingAgencyId,
    this.supplyingAgencyCode,
    this.supplyingAgencyName,
    this.overallRemarks,
    this.materialRequisitionLines,
  });

  factory MaterialRequsitionAdd.fromJson(Map<String, dynamic> json) => _$MaterialRequsitionAddFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialRequsitionAddToJson(this);
}

@JsonSerializable()
class MaterialRequisitionLines {
  String? productId;
  String? productCode;
  String? baseUomQuantity;
  String? dropLocId;
  String? dropLocName;
  String? dropLatitude;
  String? dropLongitude;

  MaterialRequisitionLines(
      {this.productId,
      this.productCode,
      this.baseUomQuantity,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude});

  factory MaterialRequisitionLines.fromJson(Map<String, dynamic> json) => _$MaterialRequisitionLinesFromJson(json);
  Map<String, dynamic> toJson() => _$MaterialRequisitionLinesToJson(this);
}

@JsonSerializable()
class MasterViewModel {
  String? apiKey;
  String? appCode;
  String? username;
  List<String>? agencyIds;

  MasterViewModel({this.apiKey, this.appCode, this.username, this.agencyIds});

  factory MasterViewModel.fromJson(Map<String, dynamic> json) => _$MasterViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$MasterViewModelToJson(this);
}
