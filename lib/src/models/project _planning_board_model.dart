import 'package:json_annotation/json_annotation.dart';
part 'project _planning_board_model.g.dart';

@JsonSerializable()
class ProjectPlanningBoard {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectCode;
  String? projectName;
  // String? projecType;
  // String? purpose;

  // Null? productCategoryId;
  // Null? productCategoryCode;
  // Null? productCategoryName;
  // Null? productSubcategoryId;
  // Null? productSubcategoryCode;
  // Null? productSubcategoryName;
  // Null? productGroupId;
  // Null? productGroupCode;
  // Null? productGroupName;
  // Null? productSubgroupId;
  // Null? productSubgroupCode;
  // Null? productSubgroupName;

  // String? agencyCollaborationType;
  // String? scheduledStartDate;
  String? scheduledEndDate;
  // num? scheduledDuration;
  // num? estimatedMandays;
  // String? actualStartDate;
  // String? actualEndDate;
  // num? actualDuration;
  // num? actualMandays;
  double? outputTarget;
  String? outputDescr;
  // num? outputTargetAssigned;
  double? outputAchieved;
  double? outputProgress;
  // String? areaType;
  // num? areaLevel;
  // num? areaCount;
  // num? areasAssigned;
  // String? projectSiteName;
  // num? projectSiteLatitude;
  // num? projectSiteLongitude;

//  Null? projectSitePonum;

  String? pmFullname;
  String? pmUsername;
  // String? pmEmail;
  String? pmMobile;
  // String? singleAccountableFullname;
  // String? singleAccountableUsername;
  // String? singleAccountableEmail;
  // String? singleAccountableMobile;
  int? countR;
  int? countA;
  int? countS;
  int? countC;
  int? countI;
  // num? progressR;
  // num? progressA;
  // num? progressS;
  // num? progressC;
  // num? progressI;
  // num? testTypeCount;
  // num? testCountTarget;
  // num? testCountCompleted;
  // num? testCountApproved;
  // String? customerType;
  // num? customerCount;
  // num? contractAmount;
  // num? billedAmount;
  // num? paidAmount;
  // num? contractorCount;
  // num? contractorAmount;
  // num? contractorBilledAmount;
  // num? contractorPaidAmount;
  // num? contractorQuantity;
  // num? contractorDelivered;
  // String? createdbyFullname;
  // String? createdbyUsername;
  // String? createdbyEmail;
  // String? createdbyMobile;
  // String? createdAt;

  // Null? updatedAt;

  // num? projectApproverCount;

  // Null? approvedby1Fullname;
  // Null? approvedby1Username;
  // Null? approvedby1Email;
  // Null? approvedby1Mobile;
  // Null? approved1On;

  // bool? isApprover2Passed;

  // Null? approvedby2Fullname;
  // Null? approvedby2Username;
  // Null? approvedby2Email;
  // Null? approvedby2Mobile;
  // Null? approved2On;
  // bool? isApprover3Passed;
  // Null? approvedby3Fullname;
  // Null? approvedby3Username;
  // Null? approvedby3Email;
  // Null? approvedby3Mobile;

  // Null? approved3On;

  String? status;

  // Null? digest;

  String? projectDescr;
  int? countRisk;
  int? countIssue;
  // num? progressRisk;
  // num? progressIssue;
  // bool? unableAsTemplate;
  // bool? geographyControlEnforced;
  // bool? onlyPmAccountable;
  // bool? otherSinglePersonAccountable;
  // bool? testApproversGeographyControlled;
  // bool? networkSiteSurveyAllowed;
  // bool? telecomSignalSurveyAllowed;
  // bool? equipmentSurveyAllowed;
  // bool? customerSurveyAllowed;
  // bool? vendorSurveyAllowed;
  // bool? channelSurveyAllowed;
  // bool? employeeSurveyAllowed;
  // bool? geologicalSurveyAllowed;
  // bool? environmentSurveyAllowed;
  // bool? populationSurveyAllowed;
  // bool? householdSurveyAllowed;
  // bool? industrySurveyAllowed;
  // bool? generalGurveyAllowed;
  // bool? approver1Passed;

  ProjectPlanningBoard({
    this.id,
    this.countryCode,
    this.countryName,
    this.agencyId,
    this.countIssue,
    this.countRisk,
    // this.progressRisk,
    // this.progressIssue,
    this.agencyCode,
    this.agencyName,
    this.projectCode,
    this.projectName,
    // this.projecType,
    // this.purpose,
    // this.productCategoryId,
    // this.productCategoryCode,
    // this.productCategoryName,
    // this.productSubcategoryId,
    // this.productSubcategoryCode,
    // this.productSubcategoryName,
    // this.productGroupId,
    // this.productGroupCode,
    // this.productGroupName,
    // this.productSubgroupId,
    // this.productSubgroupCode,
    // this.productSubgroupName,
    // this.agencyCollaborationType,
    // this.scheduledStartDate,
    this.scheduledEndDate,
    // this.scheduledDuration,
    // this.estimatedMandays,
    // this.actualStartDate,
    // this.actualEndDate,
    // this.actualDuration,
    // this.actualMandays,
    this.outputTarget,
    this.outputDescr,
    //  this.outputTargetAssigned,
    this.outputAchieved,
    this.outputProgress,
    // this.areaType,
    // this.areaLevel,
    // this.areaCount,
    // this.areasAssigned,
    // this.projectSiteName,
    // this.projectSiteLatitude,
    // this.projectSiteLongitude,
    // this.projectSitePonum,
    this.pmFullname,
    this.pmUsername,
    // this.pmEmail,
    this.pmMobile,
    // this.singleAccountableFullname,
    // this.singleAccountableUsername,
    // this.singleAccountableEmail,
    // this.singleAccountableMobile,
    this.countR,
    this.countA,
    this.countS,
    this.countC,
    this.countI,
    // this.progressR,
    // this.progressA,
    // this.progressS,
    // this.progressC,
    // this.progressI,
    // this.testTypeCount,
    // this.testCountTarget,
    // this.testCountCompleted,
    // this.testCountApproved,
    // this.customerType,
    // this.customerCount,
    // this.contractAmount,
    // this.billedAmount,
    // this.paidAmount,
    // this.contractorCount,
    // this.contractorAmount,
    // this.contractorBilledAmount,
    // this.contractorPaidAmount,
    // this.contractorQuantity,
    // this.contractorDelivered,
    // this.createdbyFullname,
    // this.createdbyUsername,
    // this.createdbyEmail,
    // this.createdbyMobile,
    // this.createdAt,
    // this.updatedAt,
    //  this.projectApproverCount,
    // this.approvedby1Fullname,
    // this.approvedby1Username,
    // this.approvedby1Email,
    // this.approvedby1Mobile,
    // this.approved1On,
    //  this.isApprover2Passed,
    // this.approvedby2Fullname,
    // this.approvedby2Username,
    // this.approvedby2Email,
    // this.approvedby2Mobile,
    // this.approved2On,
    // this.isApprover3Passed,
    // this.approvedby3Fullname,
    // this.approvedby3Username,
    // this.approvedby3Email,
    // this.approvedby3Mobile,
    // this.approved3On,
    this.status,
    // this.digest,
    this.projectDescr,
    // this.approver1Passed,
    // this.unableAsTemplate,
    // this.geographyControlEnforced,
    // this.onlyPmAccountable,
    // this.otherSinglePersonAccountable,
    // this.testApproversGeographyControlled,
    // this.networkSiteSurveyAllowed,
    // this.telecomSignalSurveyAllowed,
    // this.equipmentSurveyAllowed,
    // this.customerSurveyAllowed,
    // this.vendorSurveyAllowed,
    // this.channelSurveyAllowed,
    // this.employeeSurveyAllowed,
    // this.geologicalSurveyAllowed,
    // this.environmentSurveyAllowed,
    // this.populationSurveyAllowed,
    // this.householdSurveyAllowed,
    // this.industrySurveyAllowed,
    // this.generalGurveyAllowed
  });

  factory ProjectPlanningBoard.fromJson(Map<String, dynamic> json) =>
      _$ProjectPlanningBoardFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectPlanningBoardToJson(this);
}

@JsonSerializable()
class ProjectCountGroup {
  String? tasks;
  String? milesstones;
  String? activities;
  String? buckets;
  String? groups;

  ProjectCountGroup(
      {this.tasks,
      this.milesstones,
      this.activities,
      this.buckets,
      this.groups});

  factory ProjectCountGroup.fromJson(Map<String, dynamic> json) =>
      _$ProjectCountGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectCountGroupToJson(this);
}
