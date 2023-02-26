import 'package:json_annotation/json_annotation.dart';

part 'load_materials_vehicle_items_list.g.dart';

@JsonSerializable()
class LoadMaterialsVehicleItemsList {
  String? id;
  String? orderId;
  String? orderNo;
  String? orderDate;
  String? vehicleId;
  String? vehicleType;
  String? capacity;
  String? model;
  String? brand;
  String? registrationNo;
  String? typeOfFuel;
  String? driverUsername;
  String? driverFullname;
  String? driverMobile;
  String? driverEmail;
  String? productName;
  String? productCode;
  String? productSerial;
  double? lineNo;
  String? baseUom;
  String? productId;
  double? weightKg;
  bool? loaded;
  String? loadedAt;
  double? loadedQuantity;
  double? distanceKm;

  LoadMaterialsVehicleItemsList({
    this.id,
    this.orderId,
    this.orderNo,
    this.orderDate,
    this.vehicleId,
    this.vehicleType,
    this.capacity,
    this.model,
    this.brand,
    this.registrationNo,
    this.typeOfFuel,
    this.driverUsername,
    this.driverFullname,
    this.driverMobile,
    this.driverEmail,
    this.productName,
    this.productCode,
    this.productSerial,
    this.lineNo,
    this.baseUom,
    this.productId,
    this.weightKg,
    this.loaded,
    this.loadedAt,
    this.loadedQuantity,
    this.distanceKm,
  });

  factory LoadMaterialsVehicleItemsList.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsVehicleItemsListFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsVehicleItemsListToJson(this);
}
