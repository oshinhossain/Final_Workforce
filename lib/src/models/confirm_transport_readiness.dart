import 'package:json_annotation/json_annotation.dart';
part 'confirm_transport_readiness.g.dart';

// @JsonSerializable()
// class ConfirmTransportReadiness {
//   List<ItemList>? itemList;

//   VehicleInfo? vehicleInfo;

//   ConfirmTransportReadiness({
//     this.itemList,
//     this.vehicleInfo,
//   });

//   factory ConfirmTransportReadiness.fromJson(Map<String, dynamic> json) =>
//       _$ConfirmTransportReadinessFromJson(json);
//   Map<String, dynamic> toJson() => _$ConfirmTransportReadinessToJson(this);
// }

@JsonSerializable()
class VehicleInfo {
  String? orderId;
  String? orderNo;
  String? orderDate;

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
  String? transporterAgencyId;
  String? receiverAgencyName;
  String? receiverAgencyId;
  String? sourceLocName;

  String? dropLocName;
  dynamic dropPoint;
  double? distanceKm;

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
    this.transporterAgencyId,
    this.receiverAgencyName,
    this.receiverAgencyId,
    this.sourceLocName,
    this.dropLocName,
    this.dropPoint,
    this.distanceKm,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleInfoToJson(this);
}

@JsonSerializable()
class ItemList {
  String? loadingId;

  dynamic productId;
  dynamic productName;
  String? productCode;
  dynamic baseUom;
  double? baseUomQuantity;
  dynamic productSerial;
  double? weightKg;
  double? droppedQuantity;
  double? weightCapacity;

  ItemList(
      {this.loadingId,
      this.productId,
      this.productCode,
      this.productName,
      this.baseUom,
      this.baseUomQuantity,
      this.productSerial,
      this.weightKg,
      this.droppedQuantity,
      this.weightCapacity});

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

//================================================================

@JsonSerializable()
class ConfirmTransportReadinessByDriver {
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? transporterPartyName;
  String? receivingPartyName;
  String? receivingPartyAcceptorFullname;
  String? sourceLocName;
  String? destinationLocName;
  String? vehicleId;
  String? vehicleType;
  String? capacity;
  String? brand;
  String? registrationNo;
  String? driverFullname;

  // List<TransportOrderLoadingModels>? transportOrderLoadingModels;

  ConfirmTransportReadinessByDriver({
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.transporterPartyName,
    this.receivingPartyName,
    this.receivingPartyAcceptorFullname,
    this.sourceLocName,
    this.destinationLocName,
    this.vehicleId,
    this.vehicleType,
    this.capacity,
    this.brand,
    this.registrationNo,
    this.driverFullname,
    // this.transportOrderLoadingModels,
  });

  factory ConfirmTransportReadinessByDriver.fromJson(
          Map<String, dynamic> json) =>
      _$ConfirmTransportReadinessByDriverFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ConfirmTransportReadinessByDriverToJson(this);
}

@JsonSerializable()
class TransportOrderLoadingModels {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? vehicleId;
  String? vehicleType;
  String? capacity;
  String? brand;
  String? model;
  String? registrationNo;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? startSerialNo;
  String? finishSerialNo;
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
  num? loadedQuantity;
  String? droppedAt;
  double? droppedQuantity;
  String? dropLocId;
  String? dropLocName;
  num? dropLatitude;
  num? dropLongitude;
  num? distanceKm;
  String? receiverReadyAt;
  String? receiverRemarkWhileReady;
  String? receivedAt;
  num? receivedQuantity;
  String? receiverRemarkWhileReceived;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  num? inspectorFoundQuantityAtDroppingPoint;
  String? inspectorRemarkAtDroppingPoint;
  String? inspectorFullnameAtDroppingPoint;
  String? inspectorUsernameAtDroppingPoint;
  String? inspectorEmailAtDroppingPoint;
  String? inspectorMobileAtDroppingPoint;
  String? digest;
  String? masterViewModel;
  bool? vehicleReady;
  bool? receiverReady;
  bool? vehicleStarted;
  bool? dropped;
  bool? foundItOkayAtDroppingPoint;
  bool? received;
  double? weightCapacity;

  TransportOrderLoadingModels(
      {this.id,
      this.countryCode,
      this.countryName,
      this.transportOrderId,
      this.transportOrderNo,
      this.transportOrderDate,
      this.vehicleId,
      this.vehicleType,
      this.capacity,
      this.brand,
      this.model,
      this.registrationNo,
      this.driverFullname,
      this.driverUsername,
      this.driverEmail,
      this.driverMobile,
      this.startSerialNo,
      this.finishSerialNo,
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
      this.loadedQuantity,
      this.droppedAt,
      this.droppedQuantity,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude,
      this.distanceKm,
      this.receiverReadyAt,
      this.receiverRemarkWhileReady,
      this.receivedAt,
      this.receivedQuantity,
      this.receiverRemarkWhileReceived,
      this.receiverFullname,
      this.receiverUsername,
      this.receiverEmail,
      this.receiverMobile,
      this.inspectorFoundQuantityAtDroppingPoint,
      this.inspectorRemarkAtDroppingPoint,
      this.inspectorFullnameAtDroppingPoint,
      this.inspectorUsernameAtDroppingPoint,
      this.inspectorEmailAtDroppingPoint,
      this.inspectorMobileAtDroppingPoint,
      this.digest,
      this.masterViewModel,
      this.vehicleReady,
      this.receiverReady,
      this.vehicleStarted,
      this.dropped,
      this.foundItOkayAtDroppingPoint,
      this.received,
      this.weightCapacity});

  factory TransportOrderLoadingModels.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderLoadingModelsFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderLoadingModelsToJson(this);
}

/////////////--------------------///////////////////
@JsonSerializable()
class UnloadModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? vehicleId;
  String? vehicleType;
  String? capacity;
  String? brand;
  String? model;
  String? registrationNo;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? startSerialNo;
  String? finishSerialNo;
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
  num? loadedQuantity;
  String? droppedAt;
  double? droppedQuantity;
  String? dropLocId;
  String? dropLocName;
  num? dropLatitude;
  num? dropLongitude;
  num? distanceKm;
  String? receiverReadyAt;
  String? receiverRemarkWhileReady;
  String? receivedAt;
  num? receivedQuantity;
  String? receiverRemarkWhileReceived;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  num? inspectorFoundQuantityAtDroppingPoint;
  String? inspectorRemarkAtDroppingPoint;
  String? inspectorFullnameAtDroppingPoint;
  String? inspectorUsernameAtDroppingPoint;
  String? inspectorEmailAtDroppingPoint;
  String? inspectorMobileAtDroppingPoint;

  bool? vehicleReady;
  bool? receiverReady;
  bool? vehicleStarted;
  bool? dropped;
  bool? foundItOkayAtDroppingPoint;
  bool? received;
  double? weightCapacity;

  UnloadModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.transportOrderId,
      this.transportOrderNo,
      this.transportOrderDate,
      this.vehicleId,
      this.vehicleType,
      this.capacity,
      this.brand,
      this.model,
      this.registrationNo,
      this.driverFullname,
      this.driverUsername,
      this.driverEmail,
      this.driverMobile,
      this.startSerialNo,
      this.finishSerialNo,
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
      this.loadedQuantity,
      this.droppedAt,
      this.droppedQuantity,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude,
      this.distanceKm,
      this.receiverReadyAt,
      this.receiverRemarkWhileReady,
      this.receivedAt,
      this.receivedQuantity,
      this.receiverRemarkWhileReceived,
      this.receiverFullname,
      this.receiverUsername,
      this.receiverEmail,
      this.receiverMobile,
      this.inspectorFoundQuantityAtDroppingPoint,
      this.inspectorRemarkAtDroppingPoint,
      this.inspectorFullnameAtDroppingPoint,
      this.inspectorUsernameAtDroppingPoint,
      this.inspectorEmailAtDroppingPoint,
      this.inspectorMobileAtDroppingPoint,
      this.vehicleReady,
      this.receiverReady,
      this.vehicleStarted,
      this.dropped,
      this.foundItOkayAtDroppingPoint,
      this.received,
      this.weightCapacity});

  factory UnloadModel.fromJson(Map<String, dynamic> json) =>
      _$UnloadModelFromJson(json);
  Map<String, dynamic> toJson() => _$UnloadModelToJson(this);
}
