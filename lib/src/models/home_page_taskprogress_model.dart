import 'package:json_annotation/json_annotation.dart';
part 'home_page_taskprogress_model.g.dart';

@JsonSerializable()
class DashbordTaskProgress {
  int? count;
  String? status;
  String? statusCode;

  DashbordTaskProgress({this.count, this.status, this.statusCode});

  factory DashbordTaskProgress.fromJson(Map<String, dynamic> json) =>
      _$DashbordTaskProgressFromJson(json);
  Map<String, dynamic> toJson() => _$DashbordTaskProgressToJson(this);
}
