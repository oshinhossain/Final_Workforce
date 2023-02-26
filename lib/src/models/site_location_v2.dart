import 'package:json_annotation/json_annotation.dart';

part 'site_location_v2.g.dart';

@JsonSerializable()
class SiteLocationV2 {
  List<ProjectSites>? projectSites;
  List<PillarTypes>? pillarTypes;
  List<FunctionTypesPillarTypesMap>? functionTypesPillarTypesMap;
  CommonFields? commonFields;
  List<PillarTypes>? functionTypes;

  SiteLocationV2({this.projectSites, this.pillarTypes, this.functionTypesPillarTypesMap, this.commonFields, this.functionTypes});

  factory SiteLocationV2.fromJson(Map<String, dynamic> json) => _$SiteLocationV2FromJson(json);
  Map<String, dynamic> toJson() => _$SiteLocationV2ToJson(this);
}

@JsonSerializable()
class ProjectSites {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? areaType;
  int? areaLevel;
  String? countryCode;
  String? countryName;
  String? geoLevel1Id;
  String? geoLevel1Code;
  String? geoLevel1Name;
  String? geoLevel2id;
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
  String? siteType;
  String? siteCode;
  String? siteName;
  String? workStatus;
  String? workStartedOn;
  String? workCompleted;

  String? siteAddress;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? wkbGeometry;
  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;
  String? pillarType;
  String? functionType;
  String? placeType;
  String? powerSource;
  num? distanceFromBorderKm;
  num? distanceFromAirportKm;
  String? custodianUsername;
  String? custodianFullname;
  String? custodianMobile;
  String? custodianEmail;
  String? custodianNid;
  num? custodianMonthlyRent;
  String? custodianAddress;
  String? verificationResult;
  String? verifiedOn;
  String? verifiedAt;
  String? verifierUsername;
  String? verifierFullname;
  String? verifierMobile;
  String? verifierEmail;
  String? verifierComments;
  String? relocRequestStatus;
  String? relocRequestedOn;
  String? relocApprovedOn;
  num? oldLatitude;
  num? oldLongitude;
  num? oldAltitudeMtr;
  String? relocReason;
  String? relocApproverUsername;
  String? relocApproverFullname;
  String? relocApproverMobile;
  String? relocApproverEmail;
  String? createMethod;
  String? createdOn;
  String? createdAt;
  String? creatorUsername;
  String? creatorFullname;
  String? creatorMobile;
  String? creatorEmail;
  String? creatorComments;
  String? digest;
  String? productId;
  String? productCode;
  String? productName;
  String? productDescription;
  String? productBrand;
  String? demandUom;
  num? demandUomQuantity;
  String? productFullcode;
  String? workedOn;
  String? workedAt;
  String? workedByUsername;
  String? workedByFullname;
  String? workedByMobile;
  String? workedByEmail;
  String? workedByComments;
  String? workStatusCode;
  String? masterViewModel;
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;
  @JsonKey(defaultValue: false)
  bool? isChecked;

  ProjectSites(
      {this.id,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.areaType,
      this.areaLevel,
      this.countryCode,
      this.countryName,
      this.geoLevel1Id,
      this.geoLevel1Code,
      this.geoLevel1Name,
      this.geoLevel2id,
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
      this.siteType,
      this.siteCode,
      this.siteName,
      this.workStatus,
      this.workStartedOn,
      this.workCompleted,
      this.siteAddress,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.wkbGeometry,
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
      this.pillarType,
      this.functionType,
      this.placeType,
      this.powerSource,
      this.distanceFromBorderKm,
      this.distanceFromAirportKm,
      this.custodianUsername,
      this.custodianFullname,
      this.custodianMobile,
      this.custodianEmail,
      this.custodianNid,
      this.custodianMonthlyRent,
      this.custodianAddress,
      this.verificationResult,
      this.verifiedOn,
      this.verifiedAt,
      this.verifierUsername,
      this.verifierFullname,
      this.verifierMobile,
      this.verifierEmail,
      this.verifierComments,
      this.relocRequestStatus,
      this.relocRequestedOn,
      this.relocApprovedOn,
      this.oldLatitude,
      this.oldLongitude,
      this.oldAltitudeMtr,
      this.relocReason,
      this.relocApproverUsername,
      this.relocApproverFullname,
      this.relocApproverMobile,
      this.relocApproverEmail,
      this.createMethod,
      this.createdOn,
      this.createdAt,
      this.creatorUsername,
      this.creatorFullname,
      this.creatorMobile,
      this.creatorEmail,
      this.creatorComments,
      this.digest,
      this.productId,
      this.productCode,
      this.productName,
      this.productDescription,
      this.productBrand,
      this.demandUom,
      this.demandUomQuantity,
      this.productFullcode,
      this.workedOn,
      this.workedAt,
      this.workedByUsername,
      this.workedByFullname,
      this.workedByMobile,
      this.workedByEmail,
      this.workedByComments,
      this.workStatusCode,
      this.masterViewModel,
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea,
      this.isChecked});

  factory ProjectSites.fromJson(Map<String, dynamic> json) => _$ProjectSitesFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectSitesToJson(this);
}

@JsonSerializable()
class PillarTypes {
  int? count;
  String? type;

  PillarTypes({this.count, this.type});

  factory PillarTypes.fromJson(Map<String, dynamic> json) => _$PillarTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PillarTypesToJson(this);
}

@JsonSerializable()
class FunctionTypesPillarTypesMap {
  String? pillarType;
  String? functionType;
  int? count;

  FunctionTypesPillarTypesMap({this.pillarType, this.functionType, this.count});

  factory FunctionTypesPillarTypesMap.fromJson(Map<String, dynamic> json) => _$FunctionTypesPillarTypesMapFromJson(json);
  Map<String, dynamic> toJson() => _$FunctionTypesPillarTypesMapToJson(this);
}

@JsonSerializable()
class CommonFields {
  String? level2name;
  String? level3name;
  String? countryCode;
  String? areaType;
  String? lavel1Name;
  String? countryName;
  String? level4name;

  CommonFields(
      {this.level2name, this.level3name, this.countryCode, this.areaType, this.lavel1Name, this.countryName, this.level4name});

  factory CommonFields.fromJson(Map<String, dynamic> json) => _$CommonFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$CommonFieldsToJson(this);
}
