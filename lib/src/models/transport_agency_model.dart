import 'package:json_annotation/json_annotation.dart';

part 'transport_agency_model.g.dart';

@JsonSerializable()
class TransportAgencyModel {
  String? createdByUsername;
  String? createdByFullname;
  String? createdByEmail;
  String? createdByMobile;
  String? createdOn;
  String? createdAt;
  String? updatedByUsername;
  String? updatedByFullname;
  String? updatedByEmail;
  dynamic updatedByMobile;
  dynamic updatedOn;
  dynamic updatedAt;
  String? approvedByUsername;
  String? approvedByFullname;
  String? approvedByEmail;
  String? approvedByMobile;
  String? approvedOn;
  String? approvedAt;
  String? id;
  String? countryId;
  String? countryCode;
  String? countryName;
  String? countryTelcode;
  String? agencyCode;
  String? agencyName;
  String? agencyType;
  String? legalType;
  String? agencyOwnerName;
  String? industrySector;
  String? businessNature;
  String? currency;
  double? officeLatitude;
  double? officeLongitude;
  dynamic geographyPoint;
  dynamic geographyPolygon;
  String? officeAddress;
  String? geographyType;
  bool? useGoogleMaps;
  String? googleMapsApiKey;
  bool? useOsmMaps;
  dynamic osmMapsApiKey;
  String? phone;
  String? website;
  String? email;
  dynamic linkedinPage;
  dynamic facebookPage;
  dynamic twitterPage;
  dynamic adminUsername;
  dynamic adminFullname;
  dynamic adminMobile;
  dynamic adminEmail;
  dynamic licenseAuthority;
  dynamic licenseNo;
  String? licenseIssueDate;
  String? licenseExpiredDate;
  dynamic licenseType;
  dynamic licenseDocVerifiedDate;
  dynamic licenseDocVerificationResponse;
  dynamic taxAuthority;
  dynamic taxNo;
  String? taxRegDate;
  dynamic taxZone;
  dynamic taxCircle;
  dynamic taxDocVerifiedDate;
  dynamic taxDocVerificationResponse;
  dynamic vatAuthority;
  dynamic vatNo;
  String? vatRegDate;
  dynamic vatZone;
  dynamic vatCircle;
  dynamic vatDocVerifiedDate;
  dynamic vatDocVerificationResponse;
  num? ctrendsRevenueSharePct;
  dynamic upstreamAgencyId;
  dynamic upstreamAgencyCode;
  dynamic upstreamAgencyName;
  num? upstreamAgencyGroupLevel;
  dynamic upstreamAgencyGroup;
  num? agencyGroupLevel;
  String? agencyGroup;
  String? controllerUsername;
  String? controllerFullname;
  String? controllerEmail;
  String? controllerMobile;
  String? areaType;
  num? areaLevel;
  dynamic contractNo;
  dynamic contractDate;
  dynamic contractExpiryDate;
  dynamic extSysUrl;
  dynamic shiftStartTime;
  dynamic shiftEndTime;
  dynamic partnerApproverId;
  dynamic partnerApproverFullname;
  dynamic partnerApproverEmail;
  dynamic partnerApproverMobile;
  dynamic partnerApprovedAt;
  dynamic partnerApprovedOn;
  dynamic partnerApproverUsername;
  dynamic masterViewModel;
  dynamic partnerAreas;
  bool? geoRoutingEnabled;
  bool? ctrendsPartner;
  bool? partnerApproved;
  bool? taxDocUploaded;
  bool? licenseDocUploaded;
  bool? licenseNoVerified;
  bool? taxNoVerified;
  bool? vatDocUploaded;
  bool? vatNoVerified;
  bool? outOfContract;
  bool? externalSystemEnabled;
  bool? shiftEnabled;
  bool? approved;

  TransportAgencyModel(
      {this.createdByUsername,
      this.createdByFullname,
      this.createdByEmail,
      this.createdByMobile,
      this.createdOn,
      this.createdAt,
      this.updatedByUsername,
      this.updatedByFullname,
      this.updatedByEmail,
      this.updatedByMobile,
      this.updatedOn,
      this.updatedAt,
      this.approvedByUsername,
      this.approvedByFullname,
      this.approvedByEmail,
      this.approvedByMobile,
      this.approvedOn,
      this.approvedAt,
      this.id,
      this.countryId,
      this.countryCode,
      this.countryName,
      this.countryTelcode,
      this.agencyCode,
      this.agencyName,
      this.agencyType,
      this.legalType,
      this.agencyOwnerName,
      this.industrySector,
      this.businessNature,
      this.currency,
      this.officeLatitude,
      this.officeLongitude,
      this.geographyPoint,
      this.geographyPolygon,
      this.officeAddress,
      this.geographyType,
      this.useGoogleMaps,
      this.googleMapsApiKey,
      this.useOsmMaps,
      this.osmMapsApiKey,
      this.phone,
      this.website,
      this.email,
      this.linkedinPage,
      this.facebookPage,
      this.twitterPage,
      this.adminUsername,
      this.adminFullname,
      this.adminMobile,
      this.adminEmail,
      this.licenseAuthority,
      this.licenseNo,
      this.licenseIssueDate,
      this.licenseExpiredDate,
      this.licenseType,
      this.licenseDocVerifiedDate,
      this.licenseDocVerificationResponse,
      this.taxAuthority,
      this.taxNo,
      this.taxRegDate,
      this.taxZone,
      this.taxCircle,
      this.taxDocVerifiedDate,
      this.taxDocVerificationResponse,
      this.vatAuthority,
      this.vatNo,
      this.vatRegDate,
      this.vatZone,
      this.vatCircle,
      this.vatDocVerifiedDate,
      this.vatDocVerificationResponse,
      this.ctrendsRevenueSharePct,
      this.upstreamAgencyId,
      this.upstreamAgencyCode,
      this.upstreamAgencyName,
      this.upstreamAgencyGroupLevel,
      this.upstreamAgencyGroup,
      this.agencyGroupLevel,
      this.agencyGroup,
      this.controllerUsername,
      this.controllerFullname,
      this.controllerEmail,
      this.controllerMobile,
      this.areaType,
      this.areaLevel,
      this.contractNo,
      this.contractDate,
      this.contractExpiryDate,
      this.extSysUrl,
      this.shiftStartTime,
      this.shiftEndTime,
      this.partnerApproverId,
      this.partnerApproverFullname,
      this.partnerApproverEmail,
      this.partnerApproverMobile,
      this.partnerApprovedAt,
      this.partnerApprovedOn,
      this.partnerApproverUsername,
      this.masterViewModel,
      this.partnerAreas,
      this.geoRoutingEnabled,
      this.ctrendsPartner,
      this.partnerApproved,
      this.taxDocUploaded,
      this.licenseDocUploaded,
      this.licenseNoVerified,
      this.taxNoVerified,
      this.vatDocUploaded,
      this.vatNoVerified,
      this.outOfContract,
      this.externalSystemEnabled,
      this.shiftEnabled,
      this.approved});

  factory TransportAgencyModel.fromJson(Map<String, dynamic> json) =>
      _$TransportAgencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransportAgencyModelToJson(this);
}
