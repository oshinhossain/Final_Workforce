import 'package:json_annotation/json_annotation.dart';
part 'project_area_get_model.g.dart';

@JsonSerializable()
class ProjectAreaGet {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? verifierFullname;
  String? verifierUsername;
  String? verifierEmail;
  String? verifierMobile;
  String? assignedAgencyId;
  String? assignedAgencyCode;
  String? assignedAgencyName;
  String? assignedFullname;
  String? assignedUsername;
  String? assignedEmail;
  String? assignedMobile;
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
  String? testApproverUsername;
  String? testApproverFullname;
  String? testApproverEmail;
  String? testApproverMobile;
  String? siteInstallerUsername;
  String? siteInstallerFullname;
  String? siteInstallerEmail;
  String? siteInstallerMobile;
  String? siteInstallerWorkStartDate;
  String? siteInstallerWorkCompleteDate;
  String? siteInstallerStatusCode;
  String? siteInstallerStatus;
  String? siteInspectorUsername;
  String? siteInspectorFullname;
  String? siteInspectorEmail;
  String? siteInspectorMobile;
  String? siteInspectorWorkStartDate;
  String? siteInspectorWorkCompleteDate;
  String? siteInspectorStatusCode;
  String? siteInspectorStatus;
  String? networkInstallerUsername;
  String? networkInstallerFullname;
  String? networkInstallerEmail;
  String? networkInstallerMobile;
  String? networkInstallerWorkStartDate;
  String? networkInstallerWorkCompleteDate;
  String? networkInstallerStatusCode;
  String? networkInstallerStatus;
  String? networkInspectorUsername;
  String? networkInspectorFullname;
  String? networkInspectorEmail;
  String? networkInspectorMobile;
  String? networkInspectorWorkStartDate;
  String? networkInspectorWorkCompleteDate;
  String? networkInspectorStatusCode;
  String? networkInspectorStatus;
  String? equipmentInstallerUsername;
  String? equipmentInstallerFullname;
  String? equipmentInstallerEmail;
  String? equipmentInstallerMobile;
  String? equipmentInstallerWorkStartDate;
  String? equipmentInstallerWorkCompleteDate;
  String? equipmentInstallerStatusCode;
  String? equipmentInstallerStatus;
  String? equipmentInspectorUsername;
  String? equipmentInspectorFullname;
  String? equipmentInspectorEmail;
  String? equipmentInspectorMobile;
  String? equipmentInspectorWorkStartDate;
  String? equipmentInspectorWorkCompleteDate;
  String? equipmentInspectorStatusCode;
  String? equipmentInspectorStatus;
  String? siteInstallerSupportName;
  String? siteInstallerSupportNo;
  String? siteInspectorSupportId;
  String? siteInspectorSupportName;
  String? siteInspectorSupportNo;
  String? networkInstallerSupportId;
  String? networkInstallerSupportName;
  String? networkInstallerSupportNo;
  String? networkInspectorSupportId;
  String? networkInspectorSupportName;
  String? networkInspectorSupportNo;
  String? equipmentInstallerSupportId;
  String? equipmentInstallerSupportName;
  String? equipmentInstallerSupportNo;
  String? equipmentInspectorSupportId;
  String? equipmentInspectorSupportName;
  String? equipmentInspectorSupportNo;
  String? masterViewModel;

  ProjectAreaGet({
    this.id,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.projectId,
    this.projectCode,
    this.projectName,
    this.verifierFullname,
    this.verifierUsername,
    this.verifierEmail,
    this.verifierMobile,
    this.assignedAgencyId,
    this.assignedAgencyCode,
    this.assignedAgencyName,
    this.assignedFullname,
    this.assignedUsername,
    this.assignedEmail,
    this.assignedMobile,
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
    this.testApproverUsername,
    this.testApproverFullname,
    this.testApproverEmail,
    this.testApproverMobile,
    this.siteInstallerUsername,
    this.siteInstallerFullname,
    this.siteInstallerEmail,
    this.siteInstallerMobile,
    this.siteInstallerWorkStartDate,
    this.siteInstallerWorkCompleteDate,
    this.siteInstallerStatusCode,
    this.siteInstallerStatus,
    this.siteInspectorUsername,
    this.siteInspectorFullname,
    this.siteInspectorEmail,
    this.siteInspectorMobile,
    this.siteInspectorWorkStartDate,
    this.siteInspectorWorkCompleteDate,
    this.siteInspectorStatusCode,
    this.siteInspectorStatus,
    this.networkInstallerUsername,
    this.networkInstallerFullname,
    this.networkInstallerEmail,
    this.networkInstallerMobile,
    this.networkInstallerWorkStartDate,
    this.networkInstallerWorkCompleteDate,
    this.networkInstallerStatusCode,
    this.networkInstallerStatus,
    this.networkInspectorUsername,
    this.networkInspectorFullname,
    this.networkInspectorEmail,
    this.networkInspectorMobile,
    this.networkInspectorWorkStartDate,
    this.networkInspectorWorkCompleteDate,
    this.networkInspectorStatusCode,
    this.networkInspectorStatus,
    this.equipmentInstallerUsername,
    this.equipmentInstallerFullname,
    this.equipmentInstallerEmail,
    this.equipmentInstallerMobile,
    this.equipmentInstallerWorkStartDate,
    this.equipmentInstallerWorkCompleteDate,
    this.equipmentInstallerStatusCode,
    this.equipmentInstallerStatus,
    this.equipmentInspectorUsername,
    this.equipmentInspectorFullname,
    this.equipmentInspectorEmail,
    this.equipmentInspectorMobile,
    this.equipmentInspectorWorkStartDate,
    this.equipmentInspectorWorkCompleteDate,
    this.equipmentInspectorStatusCode,
    this.equipmentInspectorStatus,
    this.siteInstallerSupportName,
    this.siteInstallerSupportNo,
    this.siteInspectorSupportId,
    this.siteInspectorSupportName,
    this.siteInspectorSupportNo,
    this.networkInstallerSupportId,
    this.networkInstallerSupportName,
    this.networkInstallerSupportNo,
    this.networkInspectorSupportId,
    this.networkInspectorSupportName,
    this.networkInspectorSupportNo,
    this.equipmentInstallerSupportId,
    this.equipmentInstallerSupportName,
    this.equipmentInstallerSupportNo,
    this.equipmentInspectorSupportId,
    this.equipmentInspectorSupportName,
    this.equipmentInspectorSupportNo,
    this.masterViewModel,
  });

  factory ProjectAreaGet.fromJson(Map<String, dynamic> json) =>
      _$ProjectAreaGetFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectAreaGetToJson(this);
}
