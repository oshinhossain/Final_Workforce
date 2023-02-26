import 'package:json_annotation/json_annotation.dart';
part 'my_shift_plan_model.g.dart';

@JsonSerializable()
class MyShiftPlanModel {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? officeTimeCode;
  String? officeTimeName;
  bool? isSunOfficeDay;
  bool? isMonOfficeDay;
  bool? isTuesOfficeDay;
  bool? isWedOfficeDay;
  bool? isThursOfficeDay;
  bool? isFriOfficeDay;
  bool? isSatOfficeDay;
  String? sunStartTime;
  String? sunEndTime;
  String? monStartTime;
  String? monEndTime;
  String? tuesStartTime;
  String? tuesEndTime;
  String? wedStartTime;
  String? wedEndTime;
  String? thursStartTime;
  String? thursEndTime;
  String? friStartTime;
  String? friEndTime;
  String? satStartTime;
  String? satEndTime;
  double? lateTime;
  double? absentTime;
  double? lateMarks;
  double? absentMarks;
  bool? deductionLeaveLate;
  bool? deductionLeaveAbsent;
  double? otStartTime;
  int? defultShift;
  bool? tuesOfficeDay;
  bool? wedOfficeDay;
  bool? thursOfficeDay;
  bool? friOfficeDay;
  bool? satOfficeDay;
  bool? sunNextDay;
  bool? monNextDay;
  bool? tuesNextDay;
  bool? wedNextDay;
  bool? thursNextDay;
  bool? friNextDay;
  bool? satNextDay;
  bool? sunOfficeDay;
  bool? monOfficeDay;

  MyShiftPlanModel({
    this.id,
    this.agencyId,
  this. agencyCode,
  this. agencyName,
  this. officeTimeCode,
  this. officeTimeName,
this.isSunOfficeDay,
this.isMonOfficeDay,
this.isTuesOfficeDay,
this.isWedOfficeDay,
this.isThursOfficeDay,
this.isFriOfficeDay,
this.isSatOfficeDay,
    this.sunStartTime,
    this.sunEndTime,
    this.monStartTime,
    this.monEndTime,
    this.tuesStartTime,
    this.tuesEndTime,
    this.wedStartTime,
    this.wedEndTime,
    this.thursStartTime,
    this.thursEndTime,
    this.friStartTime,
    this.friEndTime,
    this.satStartTime,
    this.satEndTime,
    this.lateTime,
    this.absentTime,
    this.lateMarks,
    this.absentMarks,
    this.deductionLeaveLate,
    this.deductionLeaveAbsent,
    this.otStartTime,
    this.defultShift,
    this.tuesOfficeDay,
    this.wedOfficeDay,
    this.thursOfficeDay,
    this.friOfficeDay,
    this.satOfficeDay,
    this.sunNextDay,
    this.monNextDay,
    this.tuesNextDay,
    this.wedNextDay,
    this.thursNextDay,
    this.friNextDay,
    this.satNextDay,
    this.sunOfficeDay,
    this.monOfficeDay,
  });

  factory MyShiftPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MyShiftPlanModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyShiftPlanModelToJson(this);
}
