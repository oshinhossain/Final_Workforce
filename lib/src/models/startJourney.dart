import 'package:json_annotation/json_annotation.dart';
part 'startJourney.g.dart';

@JsonSerializable()
class StartJourneyDriver {
  // @JsonKey(name: 'item_list')
  List<ItemList>? itemList;
  // @JsonKey(name: 'vehicle_info')
  VehicleInfo? vehicleInfo;

  StartJourneyDriver({
    this.itemList,
    this.vehicleInfo,
  });

  factory StartJourneyDriver.fromJson(Map<String, dynamic> json) =>
      _$StartJourneyDriverFromJson(json);
  Map<String, dynamic> toJson() => _$StartJourneyDriverToJson(this);
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
  num? droppedQuantity;
  bool? dropped;

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
    this.dropped,
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
  String? dropLocId;
  String? dropLocName;
  num? dropPoint;
  num? distanceKm;

  VehicleInfo({
    this.orderId,
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
    this.dropLocId,
    this.dropLocName,
    this.dropPoint,
    this.distanceKm,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleInfoToJson(this);
}
