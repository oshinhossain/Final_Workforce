import 'package:json_annotation/json_annotation.dart';

part 'workbench_model.g.dart';

@JsonSerializable()
class WorkbenchModel {
  String? id;
  @JsonKey(defaultValue: false)
  bool? expended;
  String? countryCode;
  String? countryName;
  dynamic transportationMode;
  dynamic transportType;
  dynamic ticketNo;
  String? orderingAgencyId;
  String? orderingAgencyCode;
  String? orderingAgencyName;
  String? transporterPartyType;
  String? transporterAgencyId;
  String? transporterAgencyCode;
  String? transporterAgencyName;
  String? transporterFullname;
  dynamic transporterUsername;
  String? transporterEmail;
  String? transporterMobile;
  dynamic receiverPartyType;
  String? receiverAgencyId;
  String? receiverAgencyCode;
  String? receiverAgencyName;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  dynamic receivedOn;
  String? transportOrderNo;
  String? transportOrderDate;
  num? baseAmtount;
  num? vaAmount;
  double? grossAmount;
  String? cu;
  num? totalQuantity;
  dynamic bizOrderId;
  dynamic bizOrderRefno;
  dynamic bizOrderDate;
  dynamic driverNames;
  dynamic driverUsernames;
  dynamic driverMobiles;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;
  String? inspectorAtLoadingPointEmail;
  String? inspectorAtLoadingPointMobile;
  dynamic inspectorRemarkAtLoadingPoint;
  String? inspectorAtDropLocationFullname;
  String? inspectorAtDropLocationUsername;
  String? inspectorAtDropLocationEmail;
  String? inspectorAtDropLocationMobile;
  dynamic inspectorRemarkAtDropLocation;
  String? sourceLocType;
  String? sourceLocId;
  String? sourceLocName;
  double? sourceLatitude;
  double? sourceLongitude;
  String? sourceWhId;
  String? sourceWhCode;
  String? sourceWhName;
  String? sourceWhAddress;
  String? sourceWhManagerFullname;
  String? sourceWhManagerUsername;
  String? sourceWhManagerEmail;
  String? sourceWhManagerMobile;
  String? destinationLocId;
  String? destinationLocName;
  double? destinationLatitude;
  double? destinationLongitude;
  String? dropLocType;
  String? dropLocId;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;
  double? dropDistanceKm;
  String? dropWhId;
  String? dropWhCode;
  String? dropWhName;
  String? dropWhAddress;
  String? dropWhManagerFullname;
  String? dropWhManagerUsername;
  String? dropWhManagerEmail;
  String? dropWhManagerMobile;
  String? latestEtd;
  dynamic esDate;
  dynamic lsDate;
  String? travelPathId;
  String? travelPathCode;
  String? travelPathName;
  String? creatorFullname;
  String? creatorUsername;
  String? creatorEmail;
  String? creatorMobile;
  String? createdAt;
  dynamic editorFullname;
  dynamic editorUsername;
  dynamic editorEmail;
  dynamic editorMobile;
  dynamic lastEditedAt;
  num? orderApproverCount;
  dynamic approvedby1Fullname;
  dynamic approvedby1Username;
  dynamic approvedby1Email;
  dynamic approvedby1Mobile;
  dynamic approved1On;
  dynamic approvedby2Fullname;
  dynamic approvedby2Username;
  dynamic approvedby2Email;
  dynamic approvedby2Mobile;
  dynamic approved2On;
  dynamic approvedby3Fullname;
  dynamic approvedby3Username;
  dynamic approvedby3Email;
  dynamic approvedby3Mobile;
  dynamic approved3On;
  dynamic transporterAcceptorFullname;
  dynamic transporterAcceptorUsername;
  dynamic transporterAcceptorEmail;
  dynamic transporterAcceptorMobile;
  dynamic transporterAcceptorType;
  dynamic transporterAcceptedOn;
  dynamic receivingPartyAcceptorFullname;
  dynamic receivingPartyAcceptorUsername;
  dynamic receivingPartyAcceptorEmail;
  dynamic receivingPartyAcceptorMobile;
  dynamic receivingPartyAcceptorType;
  dynamic receivingPartyAcceptedOn;
  String? statusCode;
  String? status;
  dynamic digest;
  dynamic remarks;
  dynamic baseAmount;
  dynamic vatAmount;
  bool? isInspectorAtSourceEnforced;
  bool? isVehicleReadinessEnforced;
  bool? isRecipientReadinessEnforced;
  bool? isInspectorAtDestinationEnforced;
  bool? isReceivedByReceiverEnforced;
  bool? isTransportOrderOpen;
  dynamic masterViewModel;
  bool? singleDropLoc;
  bool? singleDestinationLoc;
  bool? approver2Passed;
  bool? approver3Passed;
  bool? approver1Passed;
  bool? acceptedByTransporter;
  bool? acceptedByReceivingParty;
  bool? singleReceiver;
  bool? acceptedByReceiver;
  bool? transportingSingleBizOrder;
  bool? singleInspectorAtDropLocation;
  String? registrationNo;
  String? projectName;
  // List<OrderLinesModel>? orderlines;

  // @JsonKey(name: 'transportOrderLines')
  List<WorkbebchLodingDTO>? workbebchLodingDTO;

  WorkbenchModel(
      {this.id,
      this.countryCode,
      this.workbebchLodingDTO,
      this.countryName,
      this.transportationMode,
      this.expended,
      this.transportType,
      this.ticketNo,
      this.orderingAgencyId,
      this.orderingAgencyCode,
      this.orderingAgencyName,
      this.transporterPartyType,
      this.transporterAgencyId,
      this.transporterAgencyCode,
      this.transporterAgencyName,
      this.transporterFullname,
      this.transporterUsername,
      this.transporterEmail,
      this.transporterMobile,
      this.receiverPartyType,
      this.receiverAgencyId,
      this.receiverAgencyCode,
      this.receiverAgencyName,
      this.receiverFullname,
      this.receiverUsername,
      this.receiverEmail,
      this.receiverMobile,
      this.receivedOn,
      this.transportOrderNo,
      this.transportOrderDate,
      this.baseAmount,
      this.vatAmount,
      this.grossAmount,
      this.cu,
      this.totalQuantity,
      this.bizOrderId,
      this.bizOrderRefno,
      this.bizOrderDate,
      this.driverNames,
      this.driverUsernames,
      this.driverMobiles,
      this.inspectorAtLoadingPointFullname,
      this.inspectorAtLoadingPointUsername,
      this.inspectorAtLoadingPointEmail,
      this.inspectorAtLoadingPointMobile,
      this.inspectorRemarkAtLoadingPoint,
      this.inspectorAtDropLocationFullname,
      this.inspectorAtDropLocationUsername,
      this.inspectorAtDropLocationEmail,
      this.inspectorAtDropLocationMobile,
      this.inspectorRemarkAtDropLocation,
      this.sourceLocType,
      this.sourceLocId,
      this.sourceLocName,
      this.sourceLatitude,
      this.sourceLongitude,
      this.sourceWhId,
      this.sourceWhCode,
      this.sourceWhName,
      this.sourceWhAddress,
      this.sourceWhManagerFullname,
      this.sourceWhManagerUsername,
      this.sourceWhManagerEmail,
      this.sourceWhManagerMobile,
      this.destinationLocId,
      this.destinationLocName,
      this.destinationLatitude,
      this.destinationLongitude,
      this.dropLocType,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude,
      this.dropDistanceKm,
      this.dropWhId,
      this.dropWhCode,
      this.dropWhName,
      this.dropWhAddress,
      this.dropWhManagerFullname,
      this.dropWhManagerUsername,
      this.dropWhManagerEmail,
      this.dropWhManagerMobile,
      this.latestEtd,
      this.esDate,
      this.lsDate,
      this.travelPathId,
      this.travelPathCode,
      this.travelPathName,
      this.creatorFullname,
      this.creatorUsername,
      this.creatorEmail,
      this.creatorMobile,
      this.createdAt,
      this.editorFullname,
      this.editorUsername,
      this.editorEmail,
      this.editorMobile,
      this.lastEditedAt,
      this.orderApproverCount,
      this.approvedby1Fullname,
      this.approvedby1Username,
      this.approvedby1Email,
      this.approvedby1Mobile,
      this.approved1On,
      this.approvedby2Fullname,
      this.approvedby2Username,
      this.approvedby2Email,
      this.approvedby2Mobile,
      this.approved2On,
      this.approvedby3Fullname,
      this.approvedby3Username,
      this.approvedby3Email,
      this.approvedby3Mobile,
      this.approved3On,
      this.transporterAcceptorFullname,
      this.transporterAcceptorUsername,
      this.transporterAcceptorEmail,
      this.transporterAcceptorMobile,
      this.transporterAcceptorType,
      this.transporterAcceptedOn,
      this.receivingPartyAcceptorFullname,
      this.receivingPartyAcceptorUsername,
      this.receivingPartyAcceptorEmail,
      this.receivingPartyAcceptorMobile,
      this.receivingPartyAcceptorType,
      this.receivingPartyAcceptedOn,
      this.statusCode,
      this.status,
      this.digest,
      this.remarks,
      this.isInspectorAtSourceEnforced,
      this.isVehicleReadinessEnforced,
      this.isRecipientReadinessEnforced,
      this.isInspectorAtDestinationEnforced,
      this.isReceivedByReceiverEnforced,
      this.isTransportOrderOpen,
      this.masterViewModel,
      this.singleDropLoc,
      this.singleDestinationLoc,
      this.approver2Passed,
      this.approver3Passed,
      this.approver1Passed,
      this.acceptedByTransporter,
      this.acceptedByReceivingParty,
      this.singleReceiver,
      this.acceptedByReceiver,
      this.transportingSingleBizOrder,
      this.singleInspectorAtDropLocation,
      this.baseAmtount,
      this.vaAmount,
      this.registrationNo,
      this.projectName});

  factory WorkbenchModel.fromJson(Map<String, dynamic> json) =>
      _$WorkbenchModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkbenchModelToJson(this);
}

@JsonSerializable()
class WorkbebchLodingDTO {
  String? id;
  String? dropLocId;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
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
  String? countryCode;
  dynamic countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  dynamic startSerialNo;
  dynamic finishSerialNo;
  int? lineNo;
  String? productId;
  String? productCode;
  String? productName;
  String? productDescription;
  String? productBrand;
  String? baseUom;
  double? baseUomQuantity;
  String? productColor;
  String? productSize;
  dynamic productSerial;
  double? weightKg;
  String? loadedAt;
  double? loadedQuantity;
  dynamic droppedAt;
  double? droppedQuantity;
  double? distanceKm;
  String? receiverReadyAt;
  String? receiverRemarkWhileReady;
  dynamic receivedAt;
  double? receivedQuantity;
  dynamic receiverRemarkWhileReceived;
  double? inspectorFoundQuantityAtDroppingPoint;
  dynamic inspectorRemarkAtDroppingPoint;
  String? inspectorFullnameAtDroppingPoint;
  String? inspectorUsernameAtDroppingPoint;
  String? inspectorEmailAtDroppingPoint;
  String? inspectorMobileAtDroppingPoint;
  dynamic digest;
  double? weightCapacity;
  dynamic weightCapacityUnit;
  bool? dropped;
  bool? foundItOkayAtDroppingPoint;
  bool? vehicleReady;
  bool? receiverReady;
  bool? vehicleStarted;
  bool? received;
  bool? loaded;

  WorkbebchLodingDTO(
      {this.id,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude,
      this.receiverFullname,
      this.receiverUsername,
      this.receiverEmail,
      this.receiverMobile,
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
      this.countryCode,
      this.countryName,
      this.transportOrderId,
      this.transportOrderNo,
      this.transportOrderDate,
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
      this.loadedAt,
      this.loadedQuantity,
      this.droppedAt,
      this.droppedQuantity,
      this.distanceKm,
      this.receiverReadyAt,
      this.receiverRemarkWhileReady,
      this.receivedAt,
      this.receivedQuantity,
      this.receiverRemarkWhileReceived,
      this.inspectorFoundQuantityAtDroppingPoint,
      this.inspectorRemarkAtDroppingPoint,
      this.inspectorFullnameAtDroppingPoint,
      this.inspectorUsernameAtDroppingPoint,
      this.inspectorEmailAtDroppingPoint,
      this.inspectorMobileAtDroppingPoint,
      this.digest,
      this.weightCapacity,
      this.weightCapacityUnit,
      this.dropped,
      this.foundItOkayAtDroppingPoint,
      this.vehicleReady,
      this.receiverReady,
      this.vehicleStarted,
      this.received,
      this.loaded});
  factory WorkbebchLodingDTO.fromJson(Map<String, dynamic> json) =>
      _$WorkbebchLodingDTOFromJson(json);
  Map<String, dynamic> toJson() => _$WorkbebchLodingDTOToJson(this);
}
