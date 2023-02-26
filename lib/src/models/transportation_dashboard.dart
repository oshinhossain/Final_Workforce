import 'package:json_annotation/json_annotation.dart';
part 'transportation_dashboard.g.dart';

//=========================================================
// Operational Dashboard for Transport Orderer
//=========================================================

@JsonSerializable()
class DashboardTransportOrder {
  String? id;
  String? transportOrderDate;
  String? transporterAgencyName;
  String? sourceLocName;
  String? transportOrderNo;
  String? latestEtd;
  String? remarks;
  String? receiverAgencyName;
  String? destinationLocName;
  String? status;
  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardTransportOrder({
    this.id,
    this.transportOrderDate,
    this.transporterAgencyName,
    this.sourceLocName,
    this.transportOrderNo,
    this.latestEtd,
    this.remarks,
    this.receiverAgencyName,
    this.destinationLocName,
    this.status,
    this.isExpanded,
  });

  factory DashboardTransportOrder.fromJson(Map<String, dynamic> json) =>
      _$DashboardTransportOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardTransportOrderToJson(this);
}
//=========================================================
// Operational Dashboard for Transport Agency
//=========================================================

//My Vehicles
@JsonSerializable()
class DashboardAgencyMyVehicles {
  num? total;
  num? functional;
  num? inAcative;
  num? onDuty;
  num? requestForService;

  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardAgencyMyVehicles({
    this.total,
    this.functional,
    this.inAcative,
    this.onDuty,
    this.requestForService,
    this.isExpanded,
  });

  factory DashboardAgencyMyVehicles.fromJson(Map<String, dynamic> json) =>
      _$DashboardAgencyMyVehiclesFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardAgencyMyVehiclesToJson(this);
}

//=========================================================
// **** Get transport dashboard (Driver) Order ****
//=========================================================
@JsonSerializable()
class DashboardDriverOrder {
  String? id;
  String? transportOrderNo;
  String? ets;
  String? etd;
  String? vehicleNo;
  String? source;
  String? destination;
  String? reamark;
  String? receivingParty;
  String? reamarkFromTransportAgencey;
  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardDriverOrder({
    this.id,
    this.transportOrderNo,
    this.ets,
    this.etd,
    this.vehicleNo,
    this.source,
    this.destination,
    this.reamark,
    this.receivingParty,
    this.reamarkFromTransportAgencey,
    this.isExpanded,
  });

  factory DashboardDriverOrder.fromJson(Map<String, dynamic> json) =>
      _$DashboardDriverOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDriverOrderToJson(this);
}
//=========================================================
// Operational Dashboard for Inspector
//=========================================================

//My Preloading Inspection Orders
@JsonSerializable()
class InspectionPreloading {
  String? id;
  String? transportOrderNo;
  String? ets;
  String? vehicleNo;
  double? numberOfItems;
  double? totalWeight;
  String? sourceLocName;
  String? status;
  String? remarksFromAgency;
  String? remarksFromInspector;

  @JsonKey(defaultValue: false)
  bool? isExpanded;

  InspectionPreloading({
    this.id,
    this.transportOrderNo,
    this.ets,
    this.vehicleNo,
    this.numberOfItems,
    this.totalWeight,
    this.sourceLocName,
    this.status,
    this.remarksFromAgency,
    this.remarksFromInspector,
    this.isExpanded,
  });

  factory InspectionPreloading.fromJson(Map<String, dynamic> json) =>
      _$InspectionPreloadingFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionPreloadingToJson(this);
}

//My Post Delivery Inspection Orders
@JsonSerializable()
class InspectionPostloading {
  String? id;
  String? transportOrderNo;
  String? etd;
  String? vehicleNo;
  double? numberOfItems;
  double? totalWeight;
  String? destination;
  String? status;
  String? remarks;
  @JsonKey(defaultValue: false)
  bool? isExpanded;

  InspectionPostloading({
    this.id,
    this.transportOrderNo,
    this.etd,
    this.vehicleNo,
    this.numberOfItems,
    this.totalWeight,
    this.destination,
    this.status,
    this.remarks,
    this.isExpanded,
  });

  factory InspectionPostloading.fromJson(Map<String, dynamic> json) =>
      _$InspectionPostloadingFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionPostloadingToJson(this);
}

//=========================================================
// Operational Dashboard for WH Manager
//=========================================================

//Transport Orders for Loading to Vehicle
@JsonSerializable()
class DashboardLoadingVehicle {
  String? id;
  String? transportOrderNo;
  String? etd;
  String? vehicleNo;
  int? numberOfItem;
  int? weight;
  String? source;
  String? status;
  String? remarksFromTransportAgencey;

  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardLoadingVehicle({
    this.id,
    this.transportOrderNo,
    this.etd,
    this.vehicleNo,
    this.numberOfItem,
    this.weight,
    this.source,
    this.status,
    this.remarksFromTransportAgencey,
    this.isExpanded,
  });

  factory DashboardLoadingVehicle.fromJson(Map<String, dynamic> json) =>
      _$DashboardLoadingVehicleFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardLoadingVehicleToJson(this);
}

//Transport Orders to Unload From Vehicle

@JsonSerializable()
class DashboardUnloadVehicle {
  String? id;
  String? transportOrderNo;
  String? etd;
  String? vehicleNo;
  num? numberOfItem;
  num? weight;
  String? source;
  String? status;
  String? remarksFromTransportAgencey;
  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardUnloadVehicle({
    this.id,
    this.transportOrderNo,
    this.etd,
    this.vehicleNo,
    this.numberOfItem,
    this.weight,
    this.source,
    this.status,
    this.remarksFromTransportAgencey,
    this.isExpanded,
  });

  factory DashboardUnloadVehicle.fromJson(Map<String, dynamic> json) =>
      _$DashboardUnloadVehicleFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardUnloadVehicleToJson(this);
}

//=========================================================
// **** Get transport dashboard (Receiver) Order ****
//=========================================================
@JsonSerializable()
class DashboardReceiverOrder {
  String? id;
  String? transportOrderNo;
  String? etd;
  String? vehicleNo;
  double? numberOfItems;
  double? totalWeight;
  String? source;
  String? destination;
  String? status;
  String? remarksFromAgency;
  String? remarksDriver;
  String? remarksFromWarehouseManager;
  @JsonKey(defaultValue: false)
  bool? isExpanded;

  DashboardReceiverOrder({
    this.id,
    this.transportOrderNo,
    this.etd,
    this.vehicleNo,
    this.numberOfItems,
    this.totalWeight,
    this.source,
    this.destination,
    this.status,
    this.remarksFromAgency,
    this.remarksDriver,
    this.remarksFromWarehouseManager,
    this.isExpanded,
  });

  factory DashboardReceiverOrder.fromJson(Map<String, dynamic> json) =>
      _$DashboardReceiverOrderFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardReceiverOrderToJson(this);
}
