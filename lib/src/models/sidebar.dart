import 'package:json_annotation/json_annotation.dart';
import 'package:workforce/src/models/sidebar_children.dart';
part 'sidebar.g.dart';

@JsonSerializable()
class Sidebar {
  String? title;
  String? svgPath;
  List<SidebarChildren>? children;

  Sidebar({this.title, this.svgPath, this.children});

  factory Sidebar.fromJson(Map<String, dynamic> json) =>
      _$SidebarFromJson(json);
  Map<String, dynamic> toJson() => _$SidebarToJson(this);
}
