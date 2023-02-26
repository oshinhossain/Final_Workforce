import 'package:json_annotation/json_annotation.dart';
part 'criteria_group_get_model.g.dart';

@JsonSerializable()
class CriteriaGroupGet {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? testTypeId;
  String? testTypeCode;
  String? testTypeName;
  String? groupCode;
  String? groupName;
  String? digest;
  String? masterViewModel;

  CriteriaGroupGet(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.testTypeId,
      this.testTypeCode,
      this.testTypeName,
      this.groupCode,
      this.groupName,
      this.digest,
      this.masterViewModel});

  factory CriteriaGroupGet.fromJson(Map<String, dynamic> json) =>
      _$CriteriaGroupGetFromJson(json);
  Map<String, dynamic> toJson() => _$CriteriaGroupGetToJson(this);
}
