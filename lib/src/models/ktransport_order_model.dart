import 'package:json_annotation/json_annotation.dart';

part 'ktransport_order_model.g.dart';

@JsonSerializable()
class KTransportOrderModel {
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
  String? action;
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
  String? projectName;

  @JsonKey(defaultValue: false)
  bool isLoading;

  @JsonKey(name: 'transportOrderLines')
  List<OrderLinesModel>? orderlines;

  KTransportOrderModel(
      {this.id,
      this.countryCode,
      this.orderlines,
      required this.isLoading,
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
      this.action,
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
      this.projectName});

  factory KTransportOrderModel.fromJson(Map<String, dynamic> json) =>
      _$KTransportOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$KTransportOrderModelToJson(this);
}

@JsonSerializable()
class OrderLinesModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? productCategoryId;
  String? productCategoryCode;
  String? productCategoryName;
  String? productSubcategoryId;
  String? productSubcategoryCode;
  String? productSubcategoryFullcode;
  String? productSubcategoryName;
  String? productGroupId;
  String? productGroupCode;
  String? productGroupFullcode;
  String? productGroupName;
  String? productSubgroupId;
  String? productSubgroupCode;
  String? productSubgroupFullcode;
  String? productSubgroupName;
  num? lineNo;
  String? productId;
  String? productCode;
  String? productFullcode;
  String? productName;
  String? productDescription;
  String? productBrand;
  String? baseUom;
  num? baseUomQuantity;
  String? productColor;
  String? productSize;
  dynamic productSerial;
  String? orderSource;
  String? bizOrderId;
  String? bizOrderRefno;
  String? bizOrderDate;
  num? weightKg;
  double? basePrice;
  double? vatAmount;
  num? grossAmount;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;
  String? inspectorAtLoadingPointEmail;
  String? inspectorAtLoadingPointMobile;
  num? inspectorFoundQuantityAtLoadingPoint;
  dynamic inspectorRemarkAtLoadingPoint;
  String? dropLocType;
  String? dropLocId;
  dynamic dropLocName;
  num? dropLatitude;
  num? dropLongitude;
  num? distanceKm;
  String? dropWhId;
  String? dropWhCode;
  String? dropWhName;
  String? dropWhAddress;
  String? dropWhManagerFullname;
  String? dropWhManagerUsername;
  String? dropWhManagerEmail;
  String? dropWhManagerMobile;
  num? droppedQuantity;
  dynamic etd;
  dynamic receiverFullname;
  dynamic receiverUsername;
  dynamic receiverEmail;
  dynamic receiverMobile;
  dynamic receivedOn;
  dynamic receiverReadyAt;
  dynamic receiverRemarkWhileReady;
  num? receivedQuantity;
  dynamic receivedAt;
  dynamic receiverRemarkWhileReceived;
  dynamic inspectorRemarkAtDroppingPoint;
  dynamic inspectorAtDroppingPointFullname;
  dynamic inspectorAtDroppingPointUsername;
  dynamic inspectorAtDroppingPointEmail;
  dynamic inspectorAtDroppingPointMobile;
  dynamic status;
  dynamic digest;
  dynamic masterViewModel;
  bool? received;
  bool? foundItOkayAtLoadingPoint;
  bool? receiverReady;
  bool? foundItOkayAtDroppingPoint;

  OrderLinesModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.transportOrderId,
      this.transportOrderNo,
      this.transportOrderDate,
      this.productCategoryId,
      this.productCategoryCode,
      this.productCategoryName,
      this.productSubcategoryId,
      this.productSubcategoryCode,
      this.productSubcategoryFullcode,
      this.productSubcategoryName,
      this.productGroupId,
      this.productGroupCode,
      this.productGroupFullcode,
      this.productGroupName,
      this.productSubgroupId,
      this.productSubgroupCode,
      this.productSubgroupFullcode,
      this.productSubgroupName,
      this.lineNo,
      this.productId,
      this.productCode,
      this.productFullcode,
      this.productName,
      this.productDescription,
      this.productBrand,
      this.baseUom,
      this.baseUomQuantity,
      this.productColor,
      this.productSize,
      this.productSerial,
      this.orderSource,
      this.bizOrderId,
      this.bizOrderRefno,
      this.bizOrderDate,
      this.weightKg,
      this.basePrice,
      this.vatAmount,
      this.grossAmount,
      this.inspectorAtLoadingPointFullname,
      this.inspectorAtLoadingPointUsername,
      this.inspectorAtLoadingPointEmail,
      this.inspectorAtLoadingPointMobile,
      this.inspectorFoundQuantityAtLoadingPoint,
      this.inspectorRemarkAtLoadingPoint,
      this.dropLocType,
      this.dropLocId,
      this.dropLocName,
      this.dropLatitude,
      this.dropLongitude,
      this.distanceKm,
      this.dropWhId,
      this.dropWhCode,
      this.dropWhName,
      this.dropWhAddress,
      this.dropWhManagerFullname,
      this.dropWhManagerUsername,
      this.dropWhManagerEmail,
      this.dropWhManagerMobile,
      this.droppedQuantity,
      this.etd,
      this.receiverFullname,
      this.receiverUsername,
      this.receiverEmail,
      this.receiverMobile,
      this.receivedOn,
      this.receiverReadyAt,
      this.receiverRemarkWhileReady,
      this.receivedQuantity,
      this.receivedAt,
      this.receiverRemarkWhileReceived,
      this.inspectorRemarkAtDroppingPoint,
      this.inspectorAtDroppingPointFullname,
      this.inspectorAtDroppingPointUsername,
      this.inspectorAtDroppingPointEmail,
      this.inspectorAtDroppingPointMobile,
      this.status,
      this.digest,
      this.masterViewModel,
      this.received,
      this.foundItOkayAtLoadingPoint,
      this.receiverReady,
      this.foundItOkayAtDroppingPoint});

  factory OrderLinesModel.fromJson(Map<String, dynamic> json) =>
      _$OrderLinesModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLinesModelToJson(this);
}
