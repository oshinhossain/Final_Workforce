import 'package:json_annotation/json_annotation.dart';

part 'site_location.g.dart';

@JsonSerializable()
class SiteLocation {
  PillarTypes? pillarTypes;
  Header? header;

  SiteLocation({this.header, this.pillarTypes});

  factory SiteLocation.fromJson(Map<String, dynamic> json) => _$SiteLocationFromJson(json);
  Map<String, dynamic> toJson() => _$SiteLocationToJson(this);
}

@JsonSerializable()
class Header {
  String? level2name;
  String? level3name;
  String? lavel1Name;
  String? countryName;
  String? level4name;
  double? latitude;
  double? longitude;
  Header({this.level2name, this.level3name, this.lavel1Name, this.countryName, this.level4name, this.latitude, this.longitude});

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
  Map<String, dynamic> toJson() => _$HeaderToJson(this);
}

@JsonSerializable()
class PillarTypes {
  List<NewPole>? newPole;
  List<OnBuilding>? onBuilding;
  List<ElectricityPole>? electricityPole;
  List<LightPost>? lightPost;
  List<NoPole>? noPole;

  PillarTypes({this.newPole, this.onBuilding, this.electricityPole, this.lightPost, this.noPole});

  factory PillarTypes.fromJson(Map<String, dynamic> json) => _$PillarTypesFromJson(json);
  Map<String, dynamic> toJson() => _$PillarTypesToJson(this);
}

@JsonSerializable()
class NewPole {
  String? id;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? pillarType;

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

  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;

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
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;

  NewPole(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.pillarType,
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
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
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
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea});

  factory NewPole.fromJson(Map<String, dynamic> json) => _$NewPoleFromJson(json);
  Map<String, dynamic> toJson() => _$NewPoleToJson(this);
}

@JsonSerializable()
class ElectricityPole {
  String? id;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? pillarType;

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

  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;

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
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;

  ElectricityPole(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.pillarType,
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
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
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
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea});

  factory ElectricityPole.fromJson(Map<String, dynamic> json) => _$ElectricityPoleFromJson(json);
  Map<String, dynamic> toJson() => _$ElectricityPoleToJson(this);
}

@JsonSerializable()
class OnBuilding {
  String? id;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? pillarType;

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

  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;

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
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;

  OnBuilding(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.pillarType,
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
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
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
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea});

  factory OnBuilding.fromJson(Map<String, dynamic> json) => _$OnBuildingFromJson(json);
  Map<String, dynamic> toJson() => _$OnBuildingToJson(this);
}

@JsonSerializable()
class LightPost {
  String? id;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? pillarType;

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

  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;

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
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;

  LightPost(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.pillarType,
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
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
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
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea});

  factory LightPost.fromJson(Map<String, dynamic> json) => _$LightPostFromJson(json);
  Map<String, dynamic> toJson() => _$LightPostToJson(this);
}

@JsonSerializable()
class NoPole {
  String? id;
  double? latitude;
  double? longitude;
  num? altitudeMtr;
  String? pillarType;

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

  int? priority;
  String? priorityName;
  num? potentialBeneficiaryCount;

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
  bool? borderSite;
  bool? airportSite;
  bool? tallSite;
  bool? restrictedArea;

  NoPole(
      {this.id,
      this.latitude,
      this.longitude,
      this.altitudeMtr,
      this.pillarType,
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
      this.priority,
      this.priorityName,
      this.potentialBeneficiaryCount,
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
      this.borderSite,
      this.airportSite,
      this.tallSite,
      this.restrictedArea});

  factory NoPole.fromJson(Map<String, dynamic> json) => _$NoPoleFromJson(json);
  Map<String, dynamic> toJson() => _$NoPoleToJson(this);
}
