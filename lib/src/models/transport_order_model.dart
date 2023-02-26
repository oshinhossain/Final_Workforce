import 'package:json_annotation/json_annotation.dart';
part 'transport_order_model.g.dart';

@JsonSerializable()
class TransportOrderModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportationMode;
  String? transportType;
  String? ticketNo;
  String? orderingAgencyId;
  String? orderingAgencyCode;
  String? orderingAgencyName;
  String? transporterAgencyId;
  String? transporterAgencyCode;
  String? transporterAgencyName;
  String? receiverAgencyId;
  String? receiverAgencyCode;
  String? receiverAgencyName;
  String? transportOrderNo;
  String? transportOrderDate;
  num? baseAmount;
  num? vatAmount;
  double? grossAmount;
  String? cu;
  num? totalQuantity;
  String? driverNames;
  String? driverUsernames;
  String? driverMobiles;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;
  String? inspectorAtLoadingPointEmail;
  String? inspectorAtLoadingPointMobile;
  String? inspectorRemarkAtLoadingPoint;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  String? receivedOn;
  String? inspectorAtDropLocationFullname;
  String? inspectorAtDropLocationUsername;
  String? inspectorAtDropLocationEmail;
  String? inspectorAtDropLocationMobile;
  String? inspectorRemarkAtDropLocation;
  String? sourceLocId;
  String? sourceLocName;
  double? sourceLatitude;
  double? sourceLongitude;
  String? destinationLocId;
  String? destinationLocName;
  double? destinationLatitude;
  double? destinationLongitude;
  String? travelPathId;
  double? distanceKm;
  String? creatorFullname;
  String? creatorUsername;
  String? creatorEmail;
  String? creatorMobile;
  String? createdAt;
  String? editorFullname;
  String? editorUsername;
  String? editorEmail;
  String? editorMobile;
  String? lastEditedAt;
  num? orderApproverCount;
  String? approvedby1Fullname;
  String? approvedby1Username;
  String? approvedby1Email;
  String? approvedby1Mobile;
  String? approved1On;
  String? approvedby2Fullname;
  String? approvedby2Username;
  String? approvedby2Email;
  String? approvedby2Mobile;
  String? approved2On;
  String? approvedby3Fullname;
  String? approvedby3Username;
  String? approvedby3Email;
  String? approvedby3Mobile;
  String? approved3On;
  String? transporterAcceptorFullname;
  String? transporterAcceptorUsername;
  String? transporterAcceptorEmail;
  String? transporterAcceptorMobile;
  String? transporterAcceptorType;
  String? transporterAcceptedOn;
  String? receivingPartyAcceptorFullname;
  String? receivingPartyAcceptorUsername;
  String? receivingPartyAcceptorEmail;
  String? receivingPartyrAcceptorMobile;
  String? receivingPartyAcceptorType;
  String? receivingPartyAcceptedOn;
  String? status;
  String? digest;
  String? whManagerFullname;
  String? whManagerUsername;
  String? whManagerEmail;
  String? whManagerMobile;
  String? whCode;
  String? whName;
  String? whAddress;
  String? latestEtd;
  // List<Null>? transportOrderLines;
  String? masterViewModel;
  bool? singleDestinationLoc;
  bool? singleInspectorAtDropLocation;
  bool? singleReceiver;
  bool? acceptedByReceiver;
  bool? acceptedByTransporter;
  bool? acceptedByReceivingParty;
  bool? approver1Passed;
  bool? approver2Passed;
  bool? approver3Passed;

  TransportOrderModel({
    this.id,
    this.countryCode,
    this.countryName,
    this.transportationMode,
    this.transportType,
    this.ticketNo,
    this.orderingAgencyId,
    this.orderingAgencyCode,
    this.orderingAgencyName,
    this.transporterAgencyId,
    this.transporterAgencyCode,
    this.transporterAgencyName,
    this.receiverAgencyId,
    this.receiverAgencyCode,
    this.receiverAgencyName,
    this.transportOrderNo,
    this.transportOrderDate,
    this.baseAmount,
    this.vatAmount,
    this.grossAmount,
    this.cu,
    this.totalQuantity,
    this.driverNames,
    this.driverUsernames,
    this.driverMobiles,
    this.inspectorAtLoadingPointFullname,
    this.inspectorAtLoadingPointUsername,
    this.inspectorAtLoadingPointEmail,
    this.inspectorAtLoadingPointMobile,
    this.inspectorRemarkAtLoadingPoint,
    this.receiverFullname,
    this.receiverUsername,
    this.receiverEmail,
    this.receiverMobile,
    this.receivedOn,
    this.inspectorAtDropLocationFullname,
    this.inspectorAtDropLocationUsername,
    this.inspectorAtDropLocationEmail,
    this.inspectorAtDropLocationMobile,
    this.inspectorRemarkAtDropLocation,
    this.sourceLocId,
    this.sourceLocName,
    this.sourceLatitude,
    this.sourceLongitude,
    this.destinationLocId,
    this.destinationLocName,
    this.destinationLatitude,
    this.destinationLongitude,
    this.travelPathId,
    this.distanceKm,
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
    this.receivingPartyrAcceptorMobile,
    this.receivingPartyAcceptorType,
    this.receivingPartyAcceptedOn,
    this.status,
    this.digest,
    this.whManagerFullname,
    this.whManagerUsername,
    this.whManagerEmail,
    this.whManagerMobile,
    this.whCode,
    this.whName,
    this.whAddress,
    this.latestEtd,
    // this.transportOrderLines,
    this.masterViewModel,
    this.singleDestinationLoc,
    this.singleInspectorAtDropLocation,
    this.singleReceiver,
    this.acceptedByReceiver,
    this.acceptedByTransporter,
    this.acceptedByReceivingParty,
    this.approver1Passed,
    this.approver2Passed,
    this.approver3Passed,
  });
  factory TransportOrderModel.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderModelToJson(this);
}
