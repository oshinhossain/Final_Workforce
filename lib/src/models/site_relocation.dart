import 'package:json_annotation/json_annotation.dart';
part 'site_relocation.g.dart';

@JsonSerializable()
class SiteRelocation {
  String? siteId;

  double? newLat;

  double? newLong;

  SiteRelocation({
    this.siteId,
    this.newLat,
    this.newLong,
  });

  factory SiteRelocation.fromJson(Map<String, dynamic> json) => _$SiteRelocationFromJson(json);
  Map<String, dynamic> toJson() => _$SiteRelocationToJson(this);
}
