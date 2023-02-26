import 'package:json_annotation/json_annotation.dart';
part 'change_request_model.g.dart';

@JsonSerializable()
class ChangeRequest {
  String? id;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? pmFullname;
  String? pmUsername;
  String? pmEmail;
  String? pmMobile;
  String? requestTitle;
  String? requestRefno;
  String? requestedOn;
  String? requestedAt;
  int? priorityCode;
  String? priority;
  String? changeDescription;
  String? changeReason;
  String? changeImpact;
  String? fallbackPlan;
  String? assumptions;
  int? attachmentCount;
  String? statusCode;
  String? status;
  String? approvedOn;
  String? approvedAt;
  String? requesterFullname;
  String? requesterUsername;
  String? requesterEmail;
  String? requesterMobile;
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
  bool? isExpanded;

  ChangeRequest(
      {this.id,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.projectId,
      this.projectCode,
      this.projectName,
      this.pmFullname,
      this.pmUsername,
      this.pmEmail,
      this.pmMobile,
      this.requestTitle,
      this.requestRefno,
      this.requestedOn,
      this.requestedAt,
      this.priorityCode,
      this.priority,
      this.changeDescription,
      this.changeReason,
      this.changeImpact,
      this.fallbackPlan,
      this.assumptions,
      this.attachmentCount,
      this.statusCode,
      this.status,
      this.approvedOn,
      this.approvedAt,
      this.requesterFullname,
      this.requesterUsername,
      this.requesterEmail,
      this.requesterMobile,
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
      this.isExpanded});

  factory ChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangeRequestToJson(this);
}
