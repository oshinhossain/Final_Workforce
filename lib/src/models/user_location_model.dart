import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_location_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class UserLocationModel {
  // @HiveField(0)
  // String? id;
  @HiveField(1)
  String? appCode;
  @HiveField(2)
  String? appName;
  @HiveField(3)
  String? empCode;
  @HiveField(4)
  String? empName;
  @HiveField(5)
  double? latitude;
  @HiveField(6)
  double? longitude;
  @HiveField(7)
  String? platform; // OS name, e.g., iOS, Android, Windows
  @HiveField(8)
  String? username;
  @HiveField(9)
  String? personName;
  @HiveField(10)
  String? visitDate;
  @HiveField(11)
  String? visitTime;
  @HiveField(12)
  String?
      wsIp; // user device IP. On the internet, it is the real-ip. In LAN, it is the private IP.
  @HiveField(13)
  String? wsName; // device name
  @HiveField(14)
  String? status; //Local, Server
  @HiveField(15)
  String? ip;
  @HiveField(16)
  String? mac;
  @HiveField(17)
  String? imei;
  @HiveField(18)
  String? frequency;
  @HiveField(19)
  double? signalStrengthWifi;
  @HiveField(20)
  double? signalStrengthMobile;
  @HiveField(21)
  String? networkCountryIso;
  @HiveField(22)
  String? networkOperator;
  @HiveField(23)
  String? networkType;
  @HiveField(24)
  String? networkOperatorName;
  @HiveField(25)
  String? simCountryIso;
  @HiveField(26)
  String? simOperatorName;
  @HiveField(27)
  String? simOperator;
  @HiveField(28)
  String? agencyCode;

  // String? agencyId;
  @HiveField(29)
  String? projectCode;
  @HiveField(30)
  String? assignId;
  @HiveField(31)
  String? areaLevelFullCode;
  @HiveField(32)
  String? areaType;
  @HiveField(33)
  int? areaLevel;
  @HiveField(34)
  String? refNumber;
  @HiveField(35)
  dynamic broadcastEnabled;

  UserLocationModel({
    this.appCode,
    this.appName,
    this.empCode,
    this.empName,
    this.latitude,
    this.longitude,
    this.platform,
    this.username,
    this.personName,
    this.visitDate,
    this.visitTime,
    this.wsIp,
    this.wsName,
    this.status,
    this.ip,
    this.mac,
    this.imei,
    this.frequency,
    this.signalStrengthWifi,
    this.signalStrengthMobile,
    this.networkCountryIso,
    this.networkOperator,
    this.networkType,
    this.networkOperatorName,
    this.simCountryIso,
    this.simOperatorName,
    this.simOperator,
    this.agencyCode,
    this.projectCode,
    this.assignId,
    this.areaLevelFullCode,
    this.areaType,
    this.areaLevel,
    this.refNumber,
    this.broadcastEnabled,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationModelToJson(this);
}
