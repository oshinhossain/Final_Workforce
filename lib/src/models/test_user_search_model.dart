import 'package:json_annotation/json_annotation.dart';

part 'test_user_search_model.g.dart';

@JsonSerializable()
class TestSearchModel {
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
  String? testNo;
  String? testDate;
  String? testerAgencyId;
  String? testerAgencyCode;
  String? testerAgencyName;
  String? testerFullname;
  String? testerUsername;
  String? testerEmail;
  String? testerMobile;
  String? digest;
  dynamic masterViewModel;

  TestSearchModel(
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
      this.testNo,
      this.testDate,
      this.testerAgencyId,
      this.testerAgencyCode,
      this.testerAgencyName,
      this.testerFullname,
      this.testerUsername,
      this.testerEmail,
      this.testerMobile,
      this.digest,
      this.masterViewModel});


  factory TestSearchModel.fromJson(Map<String, dynamic> json) =>
      _$TestSearchModelFromJson(json);
  Map<String, dynamic> toJson() => _$TestSearchModelToJson(this);
}
