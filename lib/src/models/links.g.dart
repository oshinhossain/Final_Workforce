// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      id: json['id'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      projectId: json['projectId'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      linkCode: json['linkCode'] as String?,
      linkName: json['linkName'] as String?,
      linkType: json['linkType'] as String?,
      site1Code: json['site1Code'] as String?,
      site1Name: json['site1Name'] as String?,
      site1Latitude: (json['site1Latitude'] as num?)?.toDouble(),
      site1Longitude: (json['site1Longitude'] as num?)?.toDouble(),
      site1Address: json['site1Address'] as String?,
      site2Code: json['site2Code'] as String?,
      site2Name: json['site2Name'] as String?,
      site2Latitude: (json['site2Latitude'] as num?)?.toDouble(),
      site2Longitude: (json['site2Longitude'] as num?)?.toDouble(),
      site2Geometry: json['site2Geometry'] as String?,
      site2Address: json['site2Address'] as String?,
      linkGeometry: json['linkGeometry'] as String?,
      linkLengthKm: (json['linkLengthKm'] as num?)?.toDouble(),
      linkCondition: json['linkCondition'] as String?,
      workStartDate: json['workStartDate'] as String?,
      onairDate: json['onairDate'] as String?,
      lifeLengthYrs: json['lifeLengthYrs'] as num?,
      eol: json['eol'] as String?,
      mediaType: json['mediaType'] as String?,
      placementType: json['placementType'] as String?,
      ductNo: json['ductNo'] as String?,
      totalCapGbps: json['totalCapGbps'] as num?,
      usedCapGbps: json['usedCapGbps'] as num?,
      availableCapGbps: json['availableCapGbps'] as num?,
      totalOfcCores: json['totalOfcCores'] as num?,
      usedOfcCores: json['usedOfcCores'] as num?,
      freeOfcCores: json['freeOfcCores'] as num?,
      site1SnmpVersion: json['site1SnmpVersion'] as String?,
      site1SnmpIp: json['site1SnmpIp'] as String?,
      site1SnmpUdpPort: json['site1SnmpUdpPort'] as int?,
      site1SnmpCommunityString: json['site1SnmpCommunityString'] as String?,
      site1SnmpSecurityLevel: json['site1SnmpSecurityLevel'] as String?,
      site1SnmpAuth: json['site1SnmpAuth'] as String?,
      site1SnmpEncryption: json['site1SnmpEncryption'] as String?,
      site1SnmpUsername: json['site1SnmpUsername'] as String?,
      site1SnmpGroup: json['site1SnmpGroup'] as String?,
      site1SnmpPassword: json['site1SnmpPassword'] as String?,
      site1SnmpConnectStyle: json['site1SnmpConnectStyle'] as String?,
      site2SnmpVersion: json['site2SnmpVersion'] as String?,
      site2SnmpIp: json['site2SnmpIp'] as String?,
      site2SnmpUdpPort: json['site2SnmpUdpPort'] as num?,
      site2SnmpCommunityString: json['site2SnmpCommunityString'] as String?,
      site2SnmpSecurityLevel: json['site2SnmpSecurityLevel'] as String?,
      site2SnmpAuth: json['site2SnmpAuth'] as String?,
      site2SnmpEncryption: json['site2SnmpEncryption'] as String?,
      site2SnmpUsername: json['site2SnmpUsername'] as String?,
      site2SnmpGroup: json['site2SnmpGroup'] as String?,
      site2SnmpPassword: json['site2SnmpPassword'] as String?,
      site2SnmpConnectStyle: json['site2SnmpConnectStyle'] as String?,
      providerAgencyId: json['providerAgencyId'] as String?,
      providerAgencyCode: json['providerAgencyCode'] as String?,
      providerAgencyName: json['providerAgencyName'] as String?,
      monthlyRent: json['monthlyRent'] as num?,
      contactPerson: json['contactPerson'] as String?,
      contactNumbers: json['contactNumbers'] as String?,
      areaType: json['areaType'] as String?,
      areaLevel: json['areaLevel'] as num?,
      levelType: json['levelType'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      site1GeoLevel1Id: json['site1GeoLevel1Id'] as String?,
      site1GeoLevel1Code: json['site1GeoLevel1Code'] as String?,
      site1GeoLevel1Name: json['site1GeoLevel1Name'] as String?,
      site1GeoLevel2Id: json['site1GeoLevel2Id'] as String?,
      site1GeoLevel2Code: json['site1GeoLevel2Code'] as String?,
      site1GeoLevel2Name: json['site1GeoLevel2Name'] as String?,
      site1GeoLevel3Id: json['site1GeoLevel3Id'] as String?,
      site1GeoLevel3Code: json['site1GeoLevel3Code'] as String?,
      site1GeoLevel3Name: json['site1GeoLevel3Name'] as String?,
      site1GeoLevel4Id: json['site1GeoLevel4Id'] as String?,
      site1GeoLevel4Code: json['site1GeoLevel4Code'] as String?,
      site1GeoLevel4Name: json['site1GeoLevel4Name'] as String?,
      site1GeoLevel5Id: json['site1GeoLevel5Id'] as String?,
      site1GeoLevel5Code: json['site1GeoLevel5Code'] as String?,
      site1GeoLevel5Name: json['site1GeoLevel5Name'] as String?,
      site2GeoLevel1Id: json['site2GeoLevel1Id'] as String?,
      site2GeoLevel1Code: json['site2GeoLevel1Code'] as String?,
      site2GeoLevel1Name: json['site2GeoLevel1Name'] as String?,
      site2GeoLevel2Id: json['site2GeoLevel2Id'] as String?,
      site2GeoLevel2Code: json['site2GeoLevel2Code'] as String?,
      site2GeoLevel2Name: json['site2GeoLevel2Name'] as String?,
      site2GeoLevel3Id: json['site2GeoLevel3Id'] as String?,
      site2GeoLevel3Code: json['site2GeoLevel3Code'] as String?,
      site2GeoLevel3Name: json['site2GeoLevel3Name'] as String?,
      site2GeoLevel4Id: json['site2GeoLevel4Id'] as String?,
      site2GeoLevel4Code: json['site2GeoLevel4Code'] as String?,
      site2GeoLevel4Name: json['site2GeoLevel4Name'] as String?,
      site2GeoLevel5Id: json['site2GeoLevel5Id'] as String?,
      site2GeoLevel5Code: json['site2GeoLevel5Code'] as String?,
      site2GeoLevel5Name: json['site2GeoLevel5Name'] as String?,
      digest: json['digest'] as String?,
      verificationResult: json['verificationResult'] as String?,
      verifiedOn: json['verifiedOn'] as String?,
      verifiedAt: json['verifiedAt'] as String?,
      verifierUsername: json['verifierUsername'] as String?,
      verifierFullname: json['verifierFullname'] as String?,
      verifierMobile: json['verifierMobile'] as String?,
      verifierEmail: json['verifierEmail'] as String?,
      verifierComments: json['verifierComments'] as String?,
      workStatusCode: json['workStatusCode'] as String?,
      workStatus: json['workStatus'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
      inspectionCleared: json['inspectionCleared'] as bool?,
      linkPoints: (json['linkPoints'] as List<dynamic>?)
          ?.map((e) => LinkPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'id': instance.id,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'projectId': instance.projectId,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'linkCode': instance.linkCode,
      'linkName': instance.linkName,
      'linkType': instance.linkType,
      'site1Code': instance.site1Code,
      'site1Name': instance.site1Name,
      'site1Latitude': instance.site1Latitude,
      'site1Longitude': instance.site1Longitude,
      'site1Address': instance.site1Address,
      'site2Code': instance.site2Code,
      'site2Name': instance.site2Name,
      'site2Latitude': instance.site2Latitude,
      'site2Longitude': instance.site2Longitude,
      'site2Geometry': instance.site2Geometry,
      'site2Address': instance.site2Address,
      'linkGeometry': instance.linkGeometry,
      'linkLengthKm': instance.linkLengthKm,
      'linkCondition': instance.linkCondition,
      'workStartDate': instance.workStartDate,
      'onairDate': instance.onairDate,
      'lifeLengthYrs': instance.lifeLengthYrs,
      'eol': instance.eol,
      'mediaType': instance.mediaType,
      'placementType': instance.placementType,
      'ductNo': instance.ductNo,
      'totalCapGbps': instance.totalCapGbps,
      'usedCapGbps': instance.usedCapGbps,
      'availableCapGbps': instance.availableCapGbps,
      'totalOfcCores': instance.totalOfcCores,
      'usedOfcCores': instance.usedOfcCores,
      'freeOfcCores': instance.freeOfcCores,
      'site1SnmpVersion': instance.site1SnmpVersion,
      'site1SnmpIp': instance.site1SnmpIp,
      'site1SnmpUdpPort': instance.site1SnmpUdpPort,
      'site1SnmpCommunityString': instance.site1SnmpCommunityString,
      'site1SnmpSecurityLevel': instance.site1SnmpSecurityLevel,
      'site1SnmpAuth': instance.site1SnmpAuth,
      'site1SnmpEncryption': instance.site1SnmpEncryption,
      'site1SnmpUsername': instance.site1SnmpUsername,
      'site1SnmpGroup': instance.site1SnmpGroup,
      'site1SnmpPassword': instance.site1SnmpPassword,
      'site1SnmpConnectStyle': instance.site1SnmpConnectStyle,
      'site2SnmpVersion': instance.site2SnmpVersion,
      'site2SnmpIp': instance.site2SnmpIp,
      'site2SnmpUdpPort': instance.site2SnmpUdpPort,
      'site2SnmpCommunityString': instance.site2SnmpCommunityString,
      'site2SnmpSecurityLevel': instance.site2SnmpSecurityLevel,
      'site2SnmpAuth': instance.site2SnmpAuth,
      'site2SnmpEncryption': instance.site2SnmpEncryption,
      'site2SnmpUsername': instance.site2SnmpUsername,
      'site2SnmpGroup': instance.site2SnmpGroup,
      'site2SnmpPassword': instance.site2SnmpPassword,
      'site2SnmpConnectStyle': instance.site2SnmpConnectStyle,
      'providerAgencyId': instance.providerAgencyId,
      'providerAgencyCode': instance.providerAgencyCode,
      'providerAgencyName': instance.providerAgencyName,
      'monthlyRent': instance.monthlyRent,
      'contactPerson': instance.contactPerson,
      'contactNumbers': instance.contactNumbers,
      'areaType': instance.areaType,
      'areaLevel': instance.areaLevel,
      'levelType': instance.levelType,
      'levelFullcode': instance.levelFullcode,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'site1GeoLevel1Id': instance.site1GeoLevel1Id,
      'site1GeoLevel1Code': instance.site1GeoLevel1Code,
      'site1GeoLevel1Name': instance.site1GeoLevel1Name,
      'site1GeoLevel2Id': instance.site1GeoLevel2Id,
      'site1GeoLevel2Code': instance.site1GeoLevel2Code,
      'site1GeoLevel2Name': instance.site1GeoLevel2Name,
      'site1GeoLevel3Id': instance.site1GeoLevel3Id,
      'site1GeoLevel3Code': instance.site1GeoLevel3Code,
      'site1GeoLevel3Name': instance.site1GeoLevel3Name,
      'site1GeoLevel4Id': instance.site1GeoLevel4Id,
      'site1GeoLevel4Code': instance.site1GeoLevel4Code,
      'site1GeoLevel4Name': instance.site1GeoLevel4Name,
      'site1GeoLevel5Id': instance.site1GeoLevel5Id,
      'site1GeoLevel5Code': instance.site1GeoLevel5Code,
      'site1GeoLevel5Name': instance.site1GeoLevel5Name,
      'site2GeoLevel1Id': instance.site2GeoLevel1Id,
      'site2GeoLevel1Code': instance.site2GeoLevel1Code,
      'site2GeoLevel1Name': instance.site2GeoLevel1Name,
      'site2GeoLevel2Id': instance.site2GeoLevel2Id,
      'site2GeoLevel2Code': instance.site2GeoLevel2Code,
      'site2GeoLevel2Name': instance.site2GeoLevel2Name,
      'site2GeoLevel3Id': instance.site2GeoLevel3Id,
      'site2GeoLevel3Code': instance.site2GeoLevel3Code,
      'site2GeoLevel3Name': instance.site2GeoLevel3Name,
      'site2GeoLevel4Id': instance.site2GeoLevel4Id,
      'site2GeoLevel4Code': instance.site2GeoLevel4Code,
      'site2GeoLevel4Name': instance.site2GeoLevel4Name,
      'site2GeoLevel5Id': instance.site2GeoLevel5Id,
      'site2GeoLevel5Code': instance.site2GeoLevel5Code,
      'site2GeoLevel5Name': instance.site2GeoLevel5Name,
      'digest': instance.digest,
      'verificationResult': instance.verificationResult,
      'verifiedOn': instance.verifiedOn,
      'verifiedAt': instance.verifiedAt,
      'verifierUsername': instance.verifierUsername,
      'verifierFullname': instance.verifierFullname,
      'verifierMobile': instance.verifierMobile,
      'verifierEmail': instance.verifierEmail,
      'verifierComments': instance.verifierComments,
      'workStatusCode': instance.workStatusCode,
      'workStatus': instance.workStatus,
      'masterViewModel': instance.masterViewModel,
      'inspectionCleared': instance.inspectionCleared,
      'linkPoints': instance.linkPoints,
      'isChecked': instance.isChecked,
    };

LinkPoints _$LinkPointsFromJson(Map<String, dynamic> json) => LinkPoints(
      id: json['id'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyCode: json['agencyCode'] as String?,
      agencyName: json['agencyName'] as String?,
      projectId: json['projectId'] as String?,
      projectCode: json['projectCode'] as String?,
      projectName: json['projectName'] as String?,
      linkId: json['linkId'] as String?,
      linkCode: json['linkCode'] as String?,
      linkName: json['linkName'] as String?,
      linkType: json['linkType'] as String?,
      seqNo: json['seqNo'] as int?,
      siteCode: json['siteCode'] as String?,
      siteName: json['siteName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      wkbGeometry: json['wkbGeometry'] as String?,
      siteAddress: json['siteAddress'] as String?,
      equipmentDetails: json['equipmentDetails'] as String?,
      areaType: json['areaType'] as String?,
      areaLevel: json['areaLevel'] as int?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      geoLevel1Id: json['geoLevel1Id'] as String?,
      geoLevel1Code: json['geoLevel1Code'] as String?,
      geoLevel1Name: json['geoLevel1Name'] as String?,
      geoLevel2Id: json['geoLevel2Id'] as String?,
      geoLevel2Code: json['geoLevel2Code'] as String?,
      geoLevel2Name: json['geoLevel2Name'] as String?,
      geoLevel3Id: json['geoLevel3Id'] as String?,
      geoLevel3Code: json['geoLevel3Code'] as String?,
      geoLevel3Name: json['geoLevel3Name'] as String?,
      geoLevel4Id: json['geoLevel4Id'] as String?,
      geoLevel4Code: json['geoLevel4Code'] as String?,
      geoLevel4Name: json['geoLevel4Name'] as String?,
      geoLevel5Id: json['geoLevel5Id'] as String?,
      geoLevel5Code: json['geoLevel5Code'] as String?,
      geoLevel5Name: json['geoLevel5Name'] as String?,
      levelType: json['levelType'] as String?,
      levelFullcode: json['levelFullcode'] as String?,
      digest: json['digest'] as String?,
      masterViewModel: json['masterViewModel'] as String?,
    );

Map<String, dynamic> _$LinkPointsToJson(LinkPoints instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agencyId': instance.agencyId,
      'agencyCode': instance.agencyCode,
      'agencyName': instance.agencyName,
      'projectId': instance.projectId,
      'projectCode': instance.projectCode,
      'projectName': instance.projectName,
      'linkId': instance.linkId,
      'linkCode': instance.linkCode,
      'linkName': instance.linkName,
      'linkType': instance.linkType,
      'seqNo': instance.seqNo,
      'siteCode': instance.siteCode,
      'siteName': instance.siteName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'wkbGeometry': instance.wkbGeometry,
      'siteAddress': instance.siteAddress,
      'equipmentDetails': instance.equipmentDetails,
      'areaType': instance.areaType,
      'areaLevel': instance.areaLevel,
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'geoLevel1Id': instance.geoLevel1Id,
      'geoLevel1Code': instance.geoLevel1Code,
      'geoLevel1Name': instance.geoLevel1Name,
      'geoLevel2Id': instance.geoLevel2Id,
      'geoLevel2Code': instance.geoLevel2Code,
      'geoLevel2Name': instance.geoLevel2Name,
      'geoLevel3Id': instance.geoLevel3Id,
      'geoLevel3Code': instance.geoLevel3Code,
      'geoLevel3Name': instance.geoLevel3Name,
      'geoLevel4Id': instance.geoLevel4Id,
      'geoLevel4Code': instance.geoLevel4Code,
      'geoLevel4Name': instance.geoLevel4Name,
      'geoLevel5Id': instance.geoLevel5Id,
      'geoLevel5Code': instance.geoLevel5Code,
      'geoLevel5Name': instance.geoLevel5Name,
      'levelType': instance.levelType,
      'levelFullcode': instance.levelFullcode,
      'digest': instance.digest,
      'masterViewModel': instance.masterViewModel,
    };