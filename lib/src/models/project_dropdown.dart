import 'package:json_annotation/json_annotation.dart';
part 'project_dropdown.g.dart';

@JsonSerializable()
class ProjectDropdown {
  String? id;

  String? projectName;

  String? projectCode;
  String? pmFullname;
  String? pmUsername;
  String? pmEmail;
  String? pmMobile;

  ProjectDropdown({
    this.id,
    this.projectName,
    this.projectCode,
    this.pmFullname,
    this.pmUsername,
    this.pmEmail,
    this.pmMobile,
  });

  factory ProjectDropdown.fromJson(Map<String, dynamic> json) =>
      _$ProjectDropdownFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectDropdownToJson(this);
}
