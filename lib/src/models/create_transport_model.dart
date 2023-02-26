import 'package:json_annotation/json_annotation.dart';
part 'create_transport_model.g.dart';

@JsonSerializable()
class CreateTransportModel {
  String? orderingAgencyId;
  String? orderingAgencyCode;
  String? orderingAgencyName;
  String? transporterAgencyId;
  String? transporterAgencyCode;
  String? transporterAgencyName;
  String? receiverAgencyId;
  String? receiverAgencyCode;
  String? receiverAgencyName;
  String? transportOrderDate;
  num? baseAmount;
  num? vatAmount;
  num? grossAmount;
  String? cu;
  num? totalQuantity;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;
  String? inspectorAtLoadingPointEmail;
  String? inspectorAtLoadingPointMobile;
  bool? singleReceiver;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  bool? singleInspectorAtDropLocation;
  String? inspectorAtDropLocationFullname;
  String? inspectorAtDropLocationUsername;
  String? inspectorAtDropLocationEmail;
  String? inspectorAtDropLocationMobile;
  String? sourceLocId;
  String? sourceLocName;
  num? sourceLatitude;
  num? sourceLongitude;
  bool? singleDestinationLoc;
  String? destinationLocId;
  String? destinationLocName;
  num? destinationLatitude;
  num? destinationLongitude;
  String? travelPathId;
  num? distanceKm;
  String? status;

  CreateTransportModel({
    this.orderingAgencyId,
    this.orderingAgencyCode,
    this.orderingAgencyName,
    this.transporterAgencyId,
    this.transporterAgencyCode,
    this.transporterAgencyName,
    this.receiverAgencyId,
    this.receiverAgencyCode,
    this.receiverAgencyName,
    this.transportOrderDate,
    this.baseAmount,
    this.vatAmount,
    this.grossAmount,
    this.cu,
    this.totalQuantity,
    this.inspectorAtLoadingPointFullname,
    this.inspectorAtLoadingPointUsername,
    this.inspectorAtLoadingPointEmail,
    this.inspectorAtLoadingPointMobile,
    this.singleReceiver,
    this.receiverFullname,
    this.receiverUsername,
    this.receiverEmail,
    this.receiverMobile,
    this.singleInspectorAtDropLocation,
    this.inspectorAtDropLocationFullname,
    this.inspectorAtDropLocationUsername,
    this.inspectorAtDropLocationEmail,
    this.inspectorAtDropLocationMobile,
    this.sourceLocId,
    this.sourceLocName,
    this.sourceLatitude,
    this.sourceLongitude,
    this.singleDestinationLoc,
    this.destinationLocId,
    this.destinationLocName,
    this.destinationLatitude,
    this.destinationLongitude,
    this.travelPathId,
    this.distanceKm,
    this.status,
  });

  factory CreateTransportModel.fromJson(Map<String, dynamic> json) =>
      _$CreateTransportModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTransportModelToJson(this);
}
