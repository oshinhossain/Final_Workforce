import 'package:json_annotation/json_annotation.dart';
part 'my_activity_dashboard_model.g.dart';

@JsonSerializable()
class MyActivitydashboardModel {
  String? id;
  String? ownerFullname;
  String? ownerEmail;
  String? supportNo;
  String? supportName;
  String? supportDescr;
  String? supportType;
  double? outputTarget;
  String? outputDescr;
  String? scheduledEndDate;

  MyActivitydashboardModel(
      {this.id,
      this.ownerFullname,
      this.ownerEmail,
      this.supportNo,
      this.supportName,
      this.supportDescr,
      this.supportType,
      this.outputTarget,
      this.outputDescr,
      this.scheduledEndDate});

  factory MyActivitydashboardModel.fromJson(Map<String, dynamic> json) =>
      _$MyActivitydashboardModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyActivitydashboardModelToJson(this);
}
