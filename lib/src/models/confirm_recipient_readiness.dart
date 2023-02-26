import 'package:json_annotation/json_annotation.dart';
part 'confirm_recipient_readiness.g.dart';

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
  String? transporterAgencyId;
  String? receiverAgencyName;
  String? receiverAgencyId;
  String? sourceLocName;

  String? dropLocName;
  String? dropPoint;
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
  String? productId;
  String? productCode;
  String? productName;
  String? baseUom;
  double? baseUomQuantity;
  String? productSerial;
  double? weightKg;
  double? weightCapacity;
  String? droppedAt;
  double? droppedQuantity;
  bool? dropped;
  @JsonKey(defaultValue: 0.0)
  double? updateReceivedQuantity;

  ItemList({
    this.loadingId,
    this.productId,
    this.productCode,
    this.productName,
    this.baseUom,
    this.baseUomQuantity,
    this.productSerial,
    this.weightKg,
    this.weightCapacity,
    this.droppedAt,
    this.droppedQuantity,
    this.dropped,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}

//====================================================================

//confirm_recipient_readiness

@JsonSerializable()
class ConfirmRecipientReadiness {
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? transporterPartyName;
  String? receivingPartyName;
  String? sourceLocName;
  String? destinationLocName;
  String? vehicleId;
  String? vehicleType;
  String? capacity;
  String? brand;
  String? registrationNo;
  String? driverFullname;
  @JsonKey(defaultValue: 0.0)
  double? updateReceivedQuantity;

  ConfirmRecipientReadiness({
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.transporterPartyName,
    this.receivingPartyName,
    this.sourceLocName,
    this.destinationLocName,
    this.vehicleId,
    this.vehicleType,
    this.capacity,
    this.brand,
    this.registrationNo,
    this.driverFullname,
  });

  factory ConfirmRecipientReadiness.fromJson(Map<String, dynamic> json) =>
      _$ConfirmRecipientReadinessFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmRecipientReadinessToJson(this);
}

@JsonSerializable()
class TransportOrderLoadingModels {
  String? id;
  String? countryCode;
  dynamic countryName;
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
  dynamic startSerialNo;
  dynamic finishSerialNo;
  num? lineNo;
  String? productId;
  String? productCode;
  String? productName;
  String? productDescription;
  dynamic productBrand;
  dynamic baseUom;
  num? baseUomQuantity;
  String? productColor;
  dynamic productSize;
  dynamic productSerial;
  num? weightKg;
  double? weightCapacity;
  String? loadedAt;
  num? loadedQuantity;
  dynamic droppedAt;
  num? droppedQuantity;
  String? dropLocId;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;
  num? distanceKm;
  dynamic receiverReadyAt;
  dynamic receiverRemarkWhileReady;
  dynamic receivedAt;
  num? receivedQuantity;
  dynamic receiverRemarkWhileReceived;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  num? inspectorFoundQuantityAtDroppingPoint;
  dynamic inspectorRemarkAtDroppingPoint;
  dynamic inspectorFullnameAtDroppingPoint;
  dynamic inspectorUsernameAtDroppingPoint;
  dynamic inspectorEmailAtDroppingPoint;
  dynamic inspectorMobileAtDroppingPoint;
  dynamic digest;
  dynamic masterViewModel;
  bool? loaded;
  bool? vehicleReady;
  bool? receiverReady;
  bool? vehicleStarted;
  bool? dropped;
  bool? foundItOkayAtDroppingPoint;
  bool? received;
  @JsonKey(defaultValue: 0.0)
  double? updateReceivedQuantity;

  TransportOrderLoadingModels({
    this.id,
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
    this.weightCapacity,
    this.loadedAt,
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
    this.loaded,
    this.vehicleReady,
    this.receiverReady,
    this.vehicleStarted,
    this.dropped,
    this.foundItOkayAtDroppingPoint,
    this.received,
    this.updateReceivedQuantity,
  });

  factory TransportOrderLoadingModels.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderLoadingModelsFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderLoadingModelsToJson(this);
}
