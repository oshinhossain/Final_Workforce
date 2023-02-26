import 'package:json_annotation/json_annotation.dart';
part 'load_materials_to_vehicle.g.dart';

@JsonSerializable()
class LoadMaterialsTransportOrder {
  String? id;
  String? transportOrderNo;
  String? transportOrderDate;
  String? transporterAgencyName;
  String? sourceLocName;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;

  LoadMaterialsTransportOrder(
      {this.id,
      this.transporterAgencyName,
      this.transportOrderNo,
      this.transportOrderDate,
      this.inspectorAtLoadingPointFullname,
      this.sourceLocName,
      this.inspectorAtLoadingPointUsername});

  factory LoadMaterialsTransportOrder.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsTransportOrderFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsTransportOrderToJson(this);
}

//===========================================
// ********* Load Materials Vehicle *******
//===========================================

@JsonSerializable()
class LoadMaterialsVehicle {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  double? sourceLatitude;
  double? sourceLongitude;
  double? destinationLatitude;
  double? destinationLongitude;
  String? vehicleType;
  String? capacity;
  String? brand;
  String? model;
  String? registrationNo;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  bool? hasDriverAccepted;
  bool? singleDestinationLoc;
  bool? vehicleReady;
  bool? vehicleStarted;
  double? weightCapacity;
  String? weightCapacityUnit;

  LoadMaterialsVehicle({
    this.id,
    this.countryCode,
    this.countryName,
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.sourceLatitude,
    this.sourceLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.vehicleType,
    this.capacity,
    this.brand,
    this.model,
    this.registrationNo,
    this.driverFullname,
    this.driverUsername,
    this.driverEmail,
    this.driverMobile,
    this.hasDriverAccepted,
    this.singleDestinationLoc,
    this.vehicleReady,
    this.vehicleStarted,
    this.weightCapacity,
    this.weightCapacityUnit,
  });

  factory LoadMaterialsVehicle.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsVehicleFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsVehicleToJson(this);
}

//===========================================
// ******** Load Materials Item List *******
//===========================================
@JsonSerializable()
class LoadMaterialsItemList {
  String? id;
  String? productId;
  String? productCode;
  String? productName;
  double? weightKg;
  String? baseUom;
  double? baseUomQuantity;
  double? lineNo;
  String? productSerial;
  double? distanceKm;

  LoadMaterialsItemList({
    this.id,
    this.lineNo,
    this.productId,
    this.productCode,
    this.productName,
    this.baseUom,
    this.baseUomQuantity,
    this.weightKg,
    this.productSerial,
    this.distanceKm,
  });

  factory LoadMaterialsItemList.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsItemListFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsItemListToJson(this);
}

//===========================================
// ***** Load Materials Vehicle Evidence *****
//===========================================
@JsonSerializable()
class LoadMaterialsVehicleEvidence {
  String? id;
  String? registrationNo;
  String? imagePath;
  String? fileName;

  LoadMaterialsVehicleEvidence({
    this.id,
    this.registrationNo,
    this.imagePath,
    this.fileName,
  });

  factory LoadMaterialsVehicleEvidence.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsVehicleEvidenceFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsVehicleEvidenceToJson(this);
}
