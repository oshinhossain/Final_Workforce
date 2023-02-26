import 'package:json_annotation/json_annotation.dart';
part 'sidebar_children.g.dart';

@JsonSerializable()
class SidebarChildren {
  String? title;

  SidebarChildren({
    this.title,
  });

  factory SidebarChildren.fromJson(Map<String, dynamic> json) =>
      _$SidebarChildrenFromJson(json);
  Map<String, dynamic> toJson() => _$SidebarChildrenToJson(this);
}
