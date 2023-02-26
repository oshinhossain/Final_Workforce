import 'package:json_annotation/json_annotation.dart';
part 'bucket_name_model.g.dart';

@JsonSerializable()
class BucketDropdown {
  String? id;
  String? bucketCode;
  String? bucketName;
  double? outputTarget;
  double? progressA;
  double? progressR;
  String? fullname;
  String? outputDescr;
  double? outputProgress;
  double? outputAchieved;
  double? weightPct;
  String? email;
  String? mobile;
  String? username;

  BucketDropdown({
    this.id,
    this.bucketCode,
    this.bucketName,
    this.outputTarget,
    this.progressA,
    this.progressR,
    this.fullname,
    this.outputDescr,
    this.outputProgress,
    this.outputAchieved,
    this.weightPct,
    this.email,
    this.mobile,
    this.username,
  });

  factory BucketDropdown.fromJson(Map<String, dynamic> json) =>
      _$BucketDropdownFromJson(json);
  Map<String, dynamic> toJson() => _$BucketDropdownToJson(this);
}
