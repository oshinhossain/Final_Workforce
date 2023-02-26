import 'package:json_annotation/json_annotation.dart';
part 'test_criterias_model.g.dart';

@JsonSerializable()
class TestCriteriasGet {
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
  String? groupId;
  String? groupCode;
  String? groupName;
  String? criterionCode;
  String? criterionName;
  String? expectedResult;
  String? digest;
  String? masterViewModel;

  TestCriteriasGet(
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
      this.groupId,
      this.groupCode,
      this.groupName,
      this.criterionCode,
      this.criterionName,
      this.expectedResult,
      this.digest,
      this.masterViewModel});

  factory TestCriteriasGet.fromJson(Map<String, dynamic> json) =>
      _$TestCriteriasGetFromJson(json);
  Map<String, dynamic> toJson() => _$TestCriteriasGetToJson(this);
}
