import 'package:json_annotation/json_annotation.dart';
part 'maintain_test_type_mode.g.dart';

@JsonSerializable()
class MaintainTest {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? testTypeCode;
  String? testTypeName;
  String? digest;

  MaintainTest(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.testTypeCode,
      this.testTypeName,
      this.digest});

  factory MaintainTest.fromJson(Map<String, dynamic> json) =>
      _$MaintainTestFromJson(json);
  Map<String, dynamic> toJson() => _$MaintainTestToJson(this);
}
