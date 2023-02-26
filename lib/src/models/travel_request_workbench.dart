import 'package:json_annotation/json_annotation.dart';
part 'travel_request_workbench.g.dart';

@JsonSerializable()
class TravelRequestWorkbench {
  String? id;
  String? countryCode;
  dynamic countryName;
  dynamic agencyId;
  String? agencyCode;
  String? agencyName;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? travelType;
  String? requestRefno;
  String? requestDate;
  dynamic travelStartDate;
  dynamic travelEndDate;
  String? purpose;
  dynamic sourceLocId;
  String? sourceLocName;
  String? sourceDescription;
  num? sourceLatitude;
  num? sourceLongitude;
  dynamic sourcePoint;
  dynamic destinationLocId;
  String? destinationLocName;
  String? destinationDescription;
  num? destinationLatitude;
  num? destinationLongitude;
  dynamic destinationPoint;
  String? accommodationDetails;
  String? accommodationContacts;
  dynamic vehicelId;
  String? vehicleRegNo;
  String? vehicleType;
  String? driverFullname;
  String? driverUsername;
  String? driverEmail;
  String? driverMobile;
  String? ticketDetails;
  String? airlineContacts;
  num? estimatedCost;
  String? currcy;
  num? advanceAmount;
  num? attachmentCount;
  String? createdAt;
  dynamic lastEditedAt;
  String? statusCode;
  String? status;
  num? approverCount;
  String? approvedby1Fullname;
  String? approvedby1Username;
  String? approvedby1Email;
  String? approvedby1Mobile;
  dynamic approved1On;
  String? approvedby1Remarks;
  String? approvedby2Fullname;
  String? approvedby2Username;
  String? approvedby2Email;
  String? approvedby2Mobile;
  dynamic approved2On;
  String? approvedby2Remarks;
  String? approvedby3Fullname;
  String? approvedby3Username;
  String? approvedby3Email;
  String? approvedby3Mobile;
  dynamic approved3On;
  String? approvedby3Remarks;
  dynamic digest;
  dynamic masterViewModel;
  bool? accommodationSupportNeeded;
  bool? transportSupportNeeded;
  bool? airlineSupportNeeded;
  bool? advanceNeeded;
  bool? approver1Passed;
  bool? approver2Passed;
  bool? approver3Passed;

  TravelRequestWorkbench({
    this.id,
    this.countryCode,
    this.countryName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.fullname,
    this.username,
    this.email,
    this.mobile,
    this.travelType,
    this.requestRefno,
    this.requestDate,
    this.travelStartDate,
    this.travelEndDate,
    this.purpose,
    this.sourceLocId,
    this.sourceLocName,
    this.sourceDescription,
    this.sourceLatitude,
    this.sourceLongitude,
    this.sourcePoint,
    this.destinationLocId,
    this.destinationLocName,
    this.destinationDescription,
    this.destinationLatitude,
    this.destinationLongitude,
    this.destinationPoint,
    this.accommodationDetails,
    this.accommodationContacts,
    this.vehicelId,
    this.vehicleRegNo,
    this.vehicleType,
    this.driverFullname,
    this.driverUsername,
    this.driverEmail,
    this.driverMobile,
    this.ticketDetails,
    this.airlineContacts,
    this.estimatedCost,
    this.currcy,
    this.advanceAmount,
    this.attachmentCount,
    this.createdAt,
    this.lastEditedAt,
    this.statusCode,
    this.status,
    this.approverCount,
    this.approvedby1Fullname,
    this.approvedby1Username,
    this.approvedby1Email,
    this.approvedby1Mobile,
    this.approved1On,
    this.approvedby1Remarks,
    this.approvedby2Fullname,
    this.approvedby2Username,
    this.approvedby2Email,
    this.approvedby2Mobile,
    this.approved2On,
    this.approvedby2Remarks,
    this.approvedby3Fullname,
    this.approvedby3Username,
    this.approvedby3Email,
    this.approvedby3Mobile,
    this.approved3On,
    this.approvedby3Remarks,
    this.digest,
    this.masterViewModel,
    this.accommodationSupportNeeded,
    this.transportSupportNeeded,
    this.airlineSupportNeeded,
    this.advanceNeeded,
    this.approver1Passed,
    this.approver2Passed,
    this.approver3Passed,
  });

  factory TravelRequestWorkbench.fromJson(Map<String, dynamic> json) =>
      _$TravelRequestWorkbenchFromJson(json);
  Map<String, dynamic> toJson() => _$TravelRequestWorkbenchToJson(this);
}
