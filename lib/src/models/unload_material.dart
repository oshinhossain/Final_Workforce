import 'package:json_annotation/json_annotation.dart';
part 'unload_material.g.dart';

@JsonSerializable()
class UnloadMaterial {
  // @JsonKey(name: 'item_list')
  List<ItemList>? itemList;
  // @JsonKey(name: 'vehicle_info')
  VehicleInfo? vehicleInfo;

  UnloadMaterial({
    this.itemList,
    this.vehicleInfo,
  });

  factory UnloadMaterial.fromJson(Map<String, dynamic> json) =>
      _$UnloadMaterialFromJson(json);
  Map<String, dynamic> toJson() => _$UnloadMaterialToJson(this);
}

@JsonSerializable()
class ItemList {
  String? loadingId;
  num? lineNo;
  String? productId;
  String? productCode;
  String? productName;
  String? productDescription;
  String? productBrand;
  String? baseUom;
  num? baseUomQuantity;
  String? productColor;
  String? productSize;
  String? productSerial;
  num? weightKg;
  String? droppedAt;
  double? droppedQuantity;
  double? loadedQuantity;
  bool? dropped;

  // double? updateDroppedQuantity;

  ItemList({
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
    // this.updateDroppedQuantity,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

@JsonSerializable()
class VehicleInfo {
  String? orderId;
  String? orderNo;
  String? orderDate;
  String? vehicleType;
  String? capacity;
  String? brand;
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
  num? sourceLatitude;
  num? sourceLongitude;
  String? dropLocId;
  String? dropLocName;
  num? dropLatitude;
  num? dropLongitude;
  num? dropPoint;
  num? distanceKm;

  VehicleInfo(
      {this.orderId,
      this.orderNo,
      this.orderDate,
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
      this.distanceKm});

  factory VehicleInfo.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleInfoToJson(this);
}
