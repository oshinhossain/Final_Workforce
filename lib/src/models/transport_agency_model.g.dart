// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_agency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportAgencyModel _$TransportAgencyModelFromJson(
        Map<String, dynamic> json) =>
    TransportAgencyModel(
      createdByUsername: json['createdByUsername'] as String?,
      createdByFullname: json['createdByFullname'] as String?,
      createdByEmail: json['createdByEmail'] as String?,
      createdByMobile: json['createdByMobile'] as String?,
      createdOn: json['createdOn'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedByUsername: json['updatedByUsername'] as String?,
      updatedByFullname: json['updatedByFullname'] as String?,
      updatedByEmail: json['updatedByEmail'] as String?,
      updatedByMobile: json['updatedByMobile'],
      updatedOn: json['updatedOn'],
      updatedAt: json['updatedAt'],
      approvedByUsername: json['approvedByUsername'] as String?,
      approvedByFullname: json['approvedByFullname'] as String?,
      approvedByEmail: json['approvedByEmail'] as String?,
      approvedByMobile: json['approvedByMobile'] as String?,
      approvedOn: json['approvedOn'] as String?,
      approvedAt: json['approvedAt'] as String?,
      id: json['id'] as String?,
      countryId: json['countryId'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      countryTelcode: json['countryTelcode'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      agencyType: json['agencyType'] as String?,
      legalType: json['legalType'] as String?,
      agencyOwnerName: json['agencyOwnerName'] as String?,
      industrySector: json['industrySector'] as String?,
      businessNature: json['businessNature'] as String?,
      currency: json['currency'] as String?,
      officeLatitude: (json['officeLatitude'] as num?)?.toDouble(),
      officeLongitude: (json['officeLongitude'] as num?)?.toDouble(),
      geographyPoint: json['geographyPoint'],
      geographyPolygon: json['geographyPolygon'],
      officeAddress: json['officeAddress'] as String?,
      geographyType: json['geographyType'] as String?,
      useGoogleMaps: json['useGoogleMaps'] as bool?,
      googleMapsApiKey: json['googleMapsApiKey'] as String?,
      useOsmMaps: json['useOsmMaps'] as bool?,
      osmMapsApiKey: json['osmMapsApiKey'],
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      linkedinPage: json['linkedinPage'],
      facebookPage: json['facebookPage'],
      twitterPage: json['twitterPage'],
      adminUsername: json['adminUsername'],
      adminFullname: json['adminFullname'],
      adminMobile: json['adminMobile'],
      adminEmail: json['adminEmail'],
      licenseAuthority: json['licenseAuthority'],
      licenseNo: json['licenseNo'],
      licenseIssueDate: json['licenseIssueDate'] as String?,
      licenseExpiredDate: json['licenseExpiredDate'] as String?,
      licenseType: json['licenseType'],
      licenseDocVerifiedDate: json['licenseDocVerifiedDate'],
      licenseDocVerificationResponse: json['licenseDocVerificationResponse'],
      taxAuthority: json['taxAuthority'],
      taxNo: json['taxNo'],
      taxRegDate: json['taxRegDate'] as String?,
      taxZone: json['taxZone'],
      taxCircle: json['taxCircle'],
      taxDocVerifiedDate: json['taxDocVerifiedDate'],
      taxDocVerificationResponse: json['taxDocVerificationResponse'],
      vatAuthority: json['vatAuthority'],
      vatNo: json['vatNo'],
      vatRegDate: json['vatRegDate'] as String?,
      vatZone: json['vatZone'],
      vatCircle: json['vatCircle'],
      vatDocVerifiedDate: json['vatDocVerifiedDate'],
      vatDocVerificationResponse: json['vatDocVerificationResponse'],
      ctrendsRevenueSharePct: json['ctrendsRevenueSharePct'] as num?,
      upstreamAgencyId: json['upstreamAgencyId'],
      upstreamAgencyCode: json['upstreamAgencyCode'],
      upstreamAgencyName: json['upstreamAgencyName'],
      upstreamAgencyGroupLevel: json['upstreamAgencyGroupLevel'] as num?,
      upstreamAgencyGroup: json['upstreamAgencyGroup'],
      agencyGroupLevel: json['agencyGroupLevel'] as num?,
      agencyGroup: json['agencyGroup'] as String?,
      controllerUsername: json['controllerUsername'] as String?,
      controllerFullname: json['controllerFullname'] as String?,
      controllerEmail: json['controllerEmail'] as String?,
      controllerMobile: json['controllerMobile'] as String?,
      areaType: json['areaType'] as String?,
      areaLevel: json['areaLevel'] as num?,
      contractNo: json['contractNo'],
      contractDate: json['contractDate'],
      contractExpiryDate: json['contractExpiryDate'],
      extSysUrl: json['extSysUrl'],
      shiftStartTime: json['shiftStartTime'],
      shiftEndTime: json['shiftEndTime'],
      partnerApproverId: json['partnerApproverId'],
      partnerApproverFullname: json['partnerApproverFullname'],
      partnerApproverEmail: json['partnerApproverEmail'],
      partnerApproverMobile: json['partnerApproverMobile'],
      partnerApprovedAt: json['partnerApprovedAt'],
      partnerApprovedOn: json['partnerApprovedOn'],
      partnerApproverUsername: json['partnerApproverUsername'],
      masterViewModel: json['masterViewModel'],
      partnerAreas: json['partnerAreas'],
      geoRoutingEnabled: json['geoRoutingEnabled'] as bool?,
      ctrendsPartner: json['ctrendsPartner'] as bool?,
      partnerApproved: json['partnerApproved'] as bool?,
      taxDocUploaded: json['taxDocUploaded'] as bool?,
      licenseDocUploaded: json['licenseDocUploaded'] as bool?,
      licenseNoVerified: json['licenseNoVerified'] as bool?,
      taxNoVerified: json['taxNoVerified'] as bool?,
      vatDocUploaded: json['vatDocUploaded'] as bool?,
      vatNoVerified: json['vatNoVerified'] as bool?,
      outOfContract: json['outOfContract'] as bool?,
      externalSystemEnabled: json['externalSystemEnabled'] as bool?,
      shiftEnabled: json['shiftEnabled'] as bool?,
      approved: json['approved'] as bool?,
    );

Map<String, dynamic> _$TransportAgencyModelToJson(
        TransportAgencyModel instance) =>
    <String, dynamic>{
      'createdByUsername': instance.createdByUsername,
      'createdByFullname': instance.createdByFullname,
      'createdByEmail': instance.createdByEmail,
      'createdByMobile': instance.createdByMobile,
      'createdOn': instance.createdOn,
      'createdAt': instance.createdAt,
      'updatedByUsername': instance.updatedByUsername,
      'updatedByFullname': instance.updatedByFullname,
      'updatedByEmail': instance.updatedByEmail,
      'updatedByMobile': instance.updatedByMobile,
      'updatedOn': instance.updatedOn,
      'updatedAt': instance.updatedAt,
      'approvedByUsername': instance.approvedByUsername,
      'approvedByFullname': instance.approvedByFullname,
      'approvedByEmail': instance.approvedByEmail,
      'approvedByMobile': instance.approvedByMobile,
      'approvedOn': instance.approvedOn,
      'approvedAt': instance.approvedAt,
      'id': instance.id,
      'countryId': instance.countryId,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'countryTelcode': instance.countryTelcode,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'agencyType': instance.agencyType,
      'legalType': instance.legalType,
      'agencyOwnerName': instance.agencyOwnerName,
      'industrySector': instance.industrySector,
      'businessNature': instance.businessNature,
      'currency': instance.currency,
      'officeLatitude': instance.officeLatitude,
      'officeLongitude': instance.officeLongitude,
      'geographyPoint': instance.geographyPoint,
      'geographyPolygon': instance.geographyPolygon,
      'officeAddress': instance.officeAddress,
      'geographyType': instance.geographyType,
      'useGoogleMaps': instance.useGoogleMaps,
      'googleMapsApiKey': instance.googleMapsApiKey,
      'useOsmMaps': instance.useOsmMaps,
      'osmMapsApiKey': instance.osmMapsApiKey,
      'phone': instance.phone,
      'website': instance.website,
      'email': instance.email,
      'linkedinPage': instance.linkedinPage,
      'facebookPage': instance.facebookPage,
      'twitterPage': instance.twitterPage,
      'adminUsername': instance.adminUsername,
      'adminFullname': instance.adminFullname,
      'adminMobile': instance.adminMobile,
      'adminEmail': instance.adminEmail,
      'licenseAuthority': instance.licenseAuthority,
      'licenseNo': instance.licenseNo,
      'licenseIssueDate': instance.licenseIssueDate,
      'licenseExpiredDate': instance.licenseExpiredDate,
      'licenseType': instance.licenseType,
      'licenseDocVerifiedDate': instance.licenseDocVerifiedDate,
      'licenseDocVerificationResponse': instance.licenseDocVerificationResponse,
      'taxAuthority': instance.taxAuthority,
      'taxNo': instance.taxNo,
      'taxRegDate': instance.taxRegDate,
      'taxZone': instance.taxZone,
      'taxCircle': instance.taxCircle,
      'taxDocVerifiedDate': instance.taxDocVerifiedDate,
      'taxDocVerificationResponse': instance.taxDocVerificationResponse,
      'vatAuthority': instance.vatAuthority,
      'vatNo': instance.vatNo,
      'vatRegDate': instance.vatRegDate,
      'vatZone': instance.vatZone,
      'vatCircle': instance.vatCircle,
      'vatDocVerifiedDate': instance.vatDocVerifiedDate,
      'vatDocVerificationResponse': instance.vatDocVerificationResponse,
      'ctrendsRevenueSharePct': instance.ctrendsRevenueSharePct,
      'upstreamAgencyId': instance.upstreamAgencyId,
      'upstreamAgencyCode': instance.upstreamAgencyCode,
      'upstreamAgencyName': instance.upstreamAgencyName,
      'upstreamAgencyGroupLevel': instance.upstreamAgencyGroupLevel,
      'upstreamAgencyGroup': instance.upstreamAgencyGroup,
      'agencyGroupLevel': instance.agencyGroupLevel,
      'agencyGroup': instance.agencyGroup,
      'controllerUsername': instance.controllerUsername,
      'controllerFullname': instance.controllerFullname,
      'controllerEmail': instance.controllerEmail,
      'controllerMobile': instance.controllerMobile,
      'areaType': instance.areaType,
      'areaLevel': instance.areaLevel,
      'contractNo': instance.contractNo,
      'contractDate': instance.contractDate,
      'contractExpiryDate': instance.contractExpiryDate,
      'extSysUrl': instance.extSysUrl,
      'shiftStartTime': instance.shiftStartTime,
      'shiftEndTime': instance.shiftEndTime,
      'partnerApproverId': instance.partnerApproverId,
      'partnerApproverFullname': instance.partnerApproverFullname,
      'partnerApproverEmail': instance.partnerApproverEmail,
      'partnerApproverMobile': instance.partnerApproverMobile,
      'partnerApprovedAt': instance.partnerApprovedAt,
      'partnerApprovedOn': instance.partnerApprovedOn,
      'partnerApproverUsername': instance.partnerApproverUsername,
      'masterViewModel': instance.masterViewModel,
      'partnerAreas': instance.partnerAreas,
      'geoRoutingEnabled': instance.geoRoutingEnabled,
      'ctrendsPartner': instance.ctrendsPartner,
      'partnerApproved': instance.partnerApproved,
      'taxDocUploaded': instance.taxDocUploaded,
      'licenseDocUploaded': instance.licenseDocUploaded,
      'licenseNoVerified': instance.licenseNoVerified,
      'taxNoVerified': instance.taxNoVerified,
      'vatDocUploaded': instance.vatDocUploaded,
      'vatNoVerified': instance.vatNoVerified,
      'outOfContract': instance.outOfContract,
      'externalSystemEnabled': instance.externalSystemEnabled,
      'shiftEnabled': instance.shiftEnabled,
      'approved': instance.approved,
    };
