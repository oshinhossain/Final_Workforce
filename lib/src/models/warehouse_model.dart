import 'package:json_annotation/json_annotation.dart';
part 'warehouse_model.g.dart';

@JsonSerializable()
class WareHouseModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? managerFullname;
  String? managerUsername;
  String? managerEmail;
  String? managerMobile;
  String? whCode;
  String? whName;
  String? whAddress;
  num? latitude;
  num? longitude;
  String? ownerFullname;
  String? ownerUsername;
  String? ownerEmail;
  String? ownerMobile;
  dynamic digest;
  dynamic masterViewModel;

  WareHouseModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.managerFullname,
      this.managerUsername,
      this.managerEmail,
      this.managerMobile,
      this.whCode,
      this.whName,
      this.whAddress,
      this.latitude,
      this.longitude,
      this.ownerFullname,
      this.ownerUsername,
      this.ownerEmail,
      this.ownerMobile,
      this.digest,
      this.masterViewModel});

  factory WareHouseModel.fromJson(Map<String, dynamic> json) =>
      _$WareHouseModelFromJson(json);
  Map<String, dynamic> toJson() => _$WareHouseModelToJson(this);
}
