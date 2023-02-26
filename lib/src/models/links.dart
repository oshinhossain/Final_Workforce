import 'package:json_annotation/json_annotation.dart';
part 'links.g.dart';

@JsonSerializable()
class Links {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? linkCode;
  String? linkName;
  String? linkType;
  String? site1Code;
  String? site1Name;
  double? site1Latitude;
  double? site1Longitude;
  String? site1Address;
  String? site2Code;
  String? site2Name;
  double? site2Latitude;
  double? site2Longitude;
  String? site2Geometry;
  String? site2Address;
  String? linkGeometry;
  double? linkLengthKm;
  String? linkCondition;
  String? workStartDate;
  String? onairDate;
  num? lifeLengthYrs;
  String? eol;
  String? mediaType;
  String? placementType;
  String? ductNo;
  num? totalCapGbps;
  num? usedCapGbps;
  num? availableCapGbps;
  num? totalOfcCores;
  num? usedOfcCores;
  num? freeOfcCores;
  String? site1SnmpVersion;
  String? site1SnmpIp;
  int? site1SnmpUdpPort;
  String? site1SnmpCommunityString;
  String? site1SnmpSecurityLevel;
  String? site1SnmpAuth;
  String? site1SnmpEncryption;
  String? site1SnmpUsername;
  String? site1SnmpGroup;
  String? site1SnmpPassword;
  String? site1SnmpConnectStyle;
  String? site2SnmpVersion;
  String? site2SnmpIp;
  num? site2SnmpUdpPort;
  String? site2SnmpCommunityString;
  String? site2SnmpSecurityLevel;
  String? site2SnmpAuth;
  String? site2SnmpEncryption;
  String? site2SnmpUsername;
  String? site2SnmpGroup;
  String? site2SnmpPassword;
  String? site2SnmpConnectStyle;
  String? providerAgencyId;
  String? providerAgencyCode;
  String? providerAgencyName;
  num? monthlyRent;
  String? contactPerson;
  String? contactNumbers;
  String? areaType;
  num? areaLevel;
  String? levelType;
  String? levelFullcode;
  String? countryCode;
  String? countryName;
  String? site1GeoLevel1Id;
  String? site1GeoLevel1Code;
  String? site1GeoLevel1Name;
  String? site1GeoLevel2Id;
  String? site1GeoLevel2Code;
  String? site1GeoLevel2Name;
  String? site1GeoLevel3Id;
  String? site1GeoLevel3Code;
  String? site1GeoLevel3Name;
  String? site1GeoLevel4Id;
  String? site1GeoLevel4Code;
  String? site1GeoLevel4Name;
  String? site1GeoLevel5Id;
  String? site1GeoLevel5Code;
  String? site1GeoLevel5Name;
  String? site2GeoLevel1Id;
  String? site2GeoLevel1Code;
  String? site2GeoLevel1Name;
  String? site2GeoLevel2Id;
  String? site2GeoLevel2Code;
  String? site2GeoLevel2Name;
  String? site2GeoLevel3Id;
  String? site2GeoLevel3Code;
  String? site2GeoLevel3Name;
  String? site2GeoLevel4Id;
  String? site2GeoLevel4Code;
  String? site2GeoLevel4Name;
  String? site2GeoLevel5Id;
  String? site2GeoLevel5Code;
  String? site2GeoLevel5Name;
  String? digest;
  String? verificationResult;
  String? verifiedOn;
  String? verifiedAt;
  String? verifierUsername;
  String? verifierFullname;
  String? verifierMobile;
  String? verifierEmail;
  String? verifierComments;
  String? workStatusCode;
  String? workStatus;
  String? masterViewModel;

  bool? inspectionCleared;
  List<LinkPoints>? linkPoints;
  @JsonKey(defaultValue: false)
  bool? isChecked;
  Links({
    this.id,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.projectId,
    this.projectCode,
    this.projectName,
    this.linkCode,
    this.linkName,
    this.linkType,
    this.site1Code,
    this.site1Name,
    this.site1Latitude,
    this.site1Longitude,
    this.site1Address,
    this.site2Code,
    this.site2Name,
    this.site2Latitude,
    this.site2Longitude,
    this.site2Geometry,
    this.site2Address,
    this.linkGeometry,
    this.linkLengthKm,
    this.linkCondition,
    this.workStartDate,
    this.onairDate,
    this.lifeLengthYrs,
    this.eol,
    this.mediaType,
    this.placementType,
    this.ductNo,
    this.totalCapGbps,
    this.usedCapGbps,
    this.availableCapGbps,
    this.totalOfcCores,
    this.usedOfcCores,
    this.freeOfcCores,
    this.site1SnmpVersion,
    this.site1SnmpIp,
    this.site1SnmpUdpPort,
    this.site1SnmpCommunityString,
    this.site1SnmpSecurityLevel,
    this.site1SnmpAuth,
    this.site1SnmpEncryption,
    this.site1SnmpUsername,
    this.site1SnmpGroup,
    this.site1SnmpPassword,
    this.site1SnmpConnectStyle,
    this.site2SnmpVersion,
    this.site2SnmpIp,
    this.site2SnmpUdpPort,
    this.site2SnmpCommunityString,
    this.site2SnmpSecurityLevel,
    this.site2SnmpAuth,
    this.site2SnmpEncryption,
    this.site2SnmpUsername,
    this.site2SnmpGroup,
    this.site2SnmpPassword,
    this.site2SnmpConnectStyle,
    this.providerAgencyId,
    this.providerAgencyCode,
    this.providerAgencyName,
    this.monthlyRent,
    this.contactPerson,
    this.contactNumbers,
    this.areaType,
    this.areaLevel,
    this.levelType,
    this.levelFullcode,
    this.countryCode,
    this.countryName,
    this.site1GeoLevel1Id,
    this.site1GeoLevel1Code,
    this.site1GeoLevel1Name,
    this.site1GeoLevel2Id,
    this.site1GeoLevel2Code,
    this.site1GeoLevel2Name,
    this.site1GeoLevel3Id,
    this.site1GeoLevel3Code,
    this.site1GeoLevel3Name,
    this.site1GeoLevel4Id,
    this.site1GeoLevel4Code,
    this.site1GeoLevel4Name,
    this.site1GeoLevel5Id,
    this.site1GeoLevel5Code,
    this.site1GeoLevel5Name,
    this.site2GeoLevel1Id,
    this.site2GeoLevel1Code,
    this.site2GeoLevel1Name,
    this.site2GeoLevel2Id,
    this.site2GeoLevel2Code,
    this.site2GeoLevel2Name,
    this.site2GeoLevel3Id,
    this.site2GeoLevel3Code,
    this.site2GeoLevel3Name,
    this.site2GeoLevel4Id,
    this.site2GeoLevel4Code,
    this.site2GeoLevel4Name,
    this.site2GeoLevel5Id,
    this.site2GeoLevel5Code,
    this.site2GeoLevel5Name,
    this.digest,
    this.verificationResult,
    this.verifiedOn,
    this.verifiedAt,
    this.verifierUsername,
    this.verifierFullname,
    this.verifierMobile,
    this.verifierEmail,
    this.verifierComments,
    this.workStatusCode,
    this.workStatus,
    this.masterViewModel,
    this.inspectionCleared,
    this.linkPoints,
    this.isChecked,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class LinkPoints {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? linkId;
  String? linkCode;
  String? linkName;
  String? linkType;
  int? seqNo;
  String? siteCode;
  String? siteName;
  double? latitude;
  double? longitude;
  String? wkbGeometry;
  String? siteAddress;
  String? equipmentDetails;
  String? areaType;
  int? areaLevel;
  String? countryCode;
  String? countryName;
  String? geoLevel1Id;
  String? geoLevel1Code;
  String? geoLevel1Name;
  String? geoLevel2Id;
  String? geoLevel2Code;
  String? geoLevel2Name;
  String? geoLevel3Id;
  String? geoLevel3Code;
  String? geoLevel3Name;
  String? geoLevel4Id;
  String? geoLevel4Code;
  String? geoLevel4Name;
  String? geoLevel5Id;
  String? geoLevel5Code;
  String? geoLevel5Name;
  String? levelType;
  String? levelFullcode;
  String? digest;
  String? masterViewModel;

  LinkPoints(
      {this.id,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.linkId,
      this.linkCode,
      this.linkName,
      this.linkType,
      this.seqNo,
      this.siteCode,
      this.siteName,
      this.latitude,
      this.longitude,
      this.wkbGeometry,
      this.siteAddress,
      this.equipmentDetails,
      this.areaType,
      this.areaLevel,
      this.countryCode,
      this.countryName,
      this.geoLevel1Id,
      this.geoLevel1Code,
      this.geoLevel1Name,
      this.geoLevel2Id,
      this.geoLevel2Code,
      this.geoLevel2Name,
      this.geoLevel3Id,
      this.geoLevel3Code,
      this.geoLevel3Name,
      this.geoLevel4Id,
      this.geoLevel4Code,
      this.geoLevel4Name,
      this.geoLevel5Id,
      this.geoLevel5Code,
      this.geoLevel5Name,
      this.levelType,
      this.levelFullcode,
      this.digest,
      this.masterViewModel});

  factory LinkPoints.fromJson(Map<String, dynamic> json) => _$LinkPointsFromJson(json);
  Map<String, dynamic> toJson() => _$LinkPointsToJson(this);
}
