import 'package:json_annotation/json_annotation.dart';
part 'define_selected_value_get_model.g.dart';

@JsonSerializable()
class SelectGroupName {
  String? id;
  String? groupName;

  SelectGroupName({
    this.id,
    this.groupName,
  });

  factory SelectGroupName.fromJson(Map<String, dynamic> json) =>
      _$SelectGroupNameFromJson(json);
  Map<String, dynamic> toJson() => _$SelectGroupNameToJson(this);
}
