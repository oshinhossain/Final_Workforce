import 'package:json_annotation/json_annotation.dart';
part 'inspect_materials_drop_location.g.dart';

@JsonSerializable()
class VehicleInfo {
  String? orderId;
  String? orderNo;
  String? orderDate;
  dynamic travelPathId;
  String? vehicleType;
  String? capacity;
  dynamic brand;
  String? model;
  String? registrationNo;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? transporterAgencyName;
  String? transporterAgencyCode;
  String? transporterAgencyId;
  String? receiverAgencyName;
  String? receiverAgencyId;
  String? receiverAgencyCode;
  String? sourceLocId;
  String? sourceLocName;
  double? sourceLatitude;
  double? sourceLongitude;
  String? dropLocId;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;
  dynamic dropPoint;
  double? distanceKm;

  VehicleInfo({
    this.orderId,
    this.orderNo,
    this.orderDate,
    this.travelPathId,
    this.vehicleType,
    this.capacity,
    this.brand,
    this.model,
    this.registrationNo,
    this.driverFullname,
    this.driverUsername,
    this.driverEmail,
    this.driverMobile,
    this.transporterAgencyName,
    this.transporterAgencyCode,
    this.transporterAgencyId,
    this.receiverAgencyName,
    this.receiverAgencyId,
    this.receiverAgencyCode,
    this.sourceLocId,
    this.sourceLocName,
    this.sourceLatitude,
    this.sourceLongitude,
    this.dropLocId,
    this.dropLocName,
    this.dropLatitude,
    this.dropLongitude,
    this.dropPoint,
    this.distanceKm,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleInfoToJson(this);
}

@JsonSerializable()
class ItemList {
  String? id;
  String? loadingId;
  int? lineNo;
  dynamic productId;
  String? productCode;
  dynamic productName;
  dynamic productDescription;
  dynamic productBrand;
  dynamic baseUom;
  double? baseUomQuantity;
  dynamic productColor;
  dynamic productSize;
  dynamic productSerial;
  double? weightKg;
  String? droppedAt;
  double? droppedQuantity;
  double? loadedQuantity;
  bool? dropped;

  @JsonKey(defaultValue: 0.0)
  double? inspectorFoundQuantityAtDroppingPoint;

  @JsonKey(defaultValue: false)
  bool? foundItOkayAtDroppingPoint;

  @JsonKey(defaultValue: '')
  String? inspectorRemarkAtDroppingPoint;

  ItemList({
    this.id,
    this.loadingId,
    this.lineNo,
    this.productId,
    this.productCode,
    this.productName,
    this.productDescription,
    this.productBrand,
    this.baseUom,
    this.baseUomQuantity,
    this.productColor,
    this.productSize,
    this.productSerial,
    this.weightKg,
    this.droppedAt,
    this.droppedQuantity,
    this.loadedQuantity,
    this.dropped,
    this.inspectorFoundQuantityAtDroppingPoint,
    this.foundItOkayAtDroppingPoint,
    this.inspectorRemarkAtDroppingPoint,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}
