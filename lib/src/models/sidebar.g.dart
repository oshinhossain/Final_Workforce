// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sidebar _$SidebarFromJson(Map<String, dynamic> json) => Sidebar(
      title: json['title'] as String?,
      svgPath: json['svgPath'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => SidebarChildren.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SidebarToJson(Sidebar instance) => <String, dynamic>{
      'title': instance.title,
      'svgPath': instance.svgPath,
      'children': instance.children,
    };
