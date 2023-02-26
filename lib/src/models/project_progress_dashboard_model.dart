import 'package:json_annotation/json_annotation.dart';
import 'package:workforce/src/models/activity_name_model.dart';

part 'project_progress_dashboard_model.g.dart';

@JsonSerializable()
class ProgressDashboardModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectCode;
  String? projectName;
  String? projecType;
  String? purpose;
  dynamic productCategoryId;
  dynamic productCategoryCode;
  dynamic productCategoryName;
  dynamic productSubcategoryId;
  dynamic productSubcategoryCode;
  dynamic productSubcategoryName;
  dynamic productGroupId;
  dynamic productGroupCode;
  dynamic productGroupName;
  dynamic productSubgroupId;
  dynamic productSubgroupCode;
  dynamic productSubgroupName;
  String? agencyCollaborationType;
  String? scheduledStartDate;
  String? scheduledEndDate;
  double? scheduledDuration;
  double? estimatedMandays;
  String? actualStartDate;
  String? actualEndDate;
  String? actualDuration;
  double? actualMandays;
  double? outputTarget;
  String? outputDescr;
  double? outputTargetAssigned;
  double? outputAchieved;
  double? outputProgress;
  String? areaType;
  int? areaLevel;
  int? areaCount;
  int? areasAssigned;
  String? projectSiteName;
  double? projectSiteLatitude;
  double? projectSiteLongitude;
  dynamic projectSitePoint;
  String? pmFullname;
  String? pmUsername;
  String? pmEmail;
  String? pmMobile;
  String? singleAccountableFullname;
  String? singleAccountableUsername;
  String? singleAccountableEmail;
  String? singleAccountableMobile;
  int? countR;
  int? countA;
  int? countS;
  int? countC;
  int? countI;
  double? progressR;
  double? progressA;
  double? progressS;
  double? progressC;
  double? progressI;
  double? testTypeCount;
  double? testCountTarget;
  double? testCountCompleted;
  double? testCountApproved;
  String? customerType;
  int? customerCount;
  double? contractAmount;
  double? billedAmount;
  double? paidAmount;
  double? contractorCount;
  double? contractorAmount;
  double? contractorBilledAmount;
  double? contractorPaidAmount;
  double? contractorQuantity;
  double? contractorDelivered;
  dynamic createdbyFullname;
  dynamic createdbyUsername;
  dynamic createdbyEmail;
  dynamic createdbyMobile;
  dynamic createdAt;
  dynamic updatedAt;
  int? projectApproverCount;
  dynamic approvedby1Fullname;
  dynamic approvedby1Username;
  dynamic approvedby1Email;
  dynamic approvedby1Mobile;
  dynamic approved1On;
  bool? isApprover2Passed;
  dynamic approvedby2Fullname;
  dynamic approvedby2Username;
  dynamic approvedby2Email;
  dynamic approvedby2Mobile;
  dynamic approved2On;
  bool? isApprover3Passed;
  dynamic approvedby3Fullname;
  dynamic approvedby3Username;
  dynamic approvedby3Email;
  dynamic approvedby3Mobile;
  dynamic approved3On;
  dynamic status;
  dynamic digest;
  String? projectDescr;

  dynamic masterViewModel;
  bool? approver1Passed;
  bool? unableAsTemplate;
  bool? geographyControlEnforced;
  bool? onlyPmAccountable;
  bool? otherSinglePersonAccountable;
  bool? testApproversGeographyControlled;
  bool? networkSiteSurveyAllowed;
  bool? telecomSignalSurveyAllowed;
  bool? equipmentSurveyAllowed;
  bool? customerSurveyAllowed;
  bool? vendorSurveyAllowed;
  bool? channelSurveyAllowed;
  bool? employeeSurveyAllowed;
  bool? geologicalSurveyAllowed;
  bool? environmentSurveyAllowed;
  bool? populationSurveyAllowed;
  bool? householdSurveyAllowed;
  bool? industrySurveyAllowed;
  bool? generalGurveyAllowed;
  List<ScopeBuckets>? scopeBuckets;

  ProgressDashboardModel({
    this.id,
    this.countryCode,
    this.countryName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.projectCode,
    this.projectName,
    this.projecType,
    this.purpose,
    this.productCategoryId,
    this.productCategoryCode,
    this.productCategoryName,
    this.productSubcategoryId,
    this.productSubcategoryCode,
    this.productSubcategoryName,
    this.productGroupId,
    this.productGroupCode,
    this.productGroupName,
    this.productSubgroupId,
    this.productSubgroupCode,
    this.productSubgroupName,
    this.agencyCollaborationType,
    this.scheduledStartDate,
    this.scheduledEndDate,
    this.scheduledDuration,
    this.estimatedMandays,
    this.actualStartDate,
    this.actualEndDate,
    this.actualDuration,
    this.actualMandays,
    this.outputTarget,
    this.outputDescr,
    this.outputTargetAssigned,
    this.outputAchieved,
    this.outputProgress,
    this.areaType,
    this.areaLevel,
    this.areaCount,
    this.areasAssigned,
    this.projectSiteName,
    this.projectSiteLatitude,
    this.projectSiteLongitude,
    this.projectSitePoint,
    this.pmFullname,
    this.pmUsername,
    this.pmEmail,
    this.pmMobile,
    this.singleAccountableFullname,
    this.singleAccountableUsername,
    this.singleAccountableEmail,
    this.singleAccountableMobile,
    this.countR,
    this.countA,
    this.countS,
    this.countC,
    this.countI,
    this.progressR,
    this.progressA,
    this.progressS,
    this.progressC,
    this.progressI,
    this.testTypeCount,
    this.testCountTarget,
    this.testCountCompleted,
    this.testCountApproved,
    this.customerType,
    this.customerCount,
    this.contractAmount,
    this.billedAmount,
    this.paidAmount,
    this.contractorCount,
    this.contractorAmount,
    this.contractorBilledAmount,
    this.contractorPaidAmount,
    this.contractorQuantity,
    this.contractorDelivered,
    this.createdbyFullname,
    this.createdbyUsername,
    this.createdbyEmail,
    this.createdbyMobile,
    this.createdAt,
    this.updatedAt,
    this.projectApproverCount,
    this.approvedby1Fullname,
    this.approvedby1Username,
    this.approvedby1Email,
    this.approvedby1Mobile,
    this.approved1On,
    this.isApprover2Passed,
    this.approvedby2Fullname,
    this.approvedby2Username,
    this.approvedby2Email,
    this.approvedby2Mobile,
    this.approved2On,
    this.isApprover3Passed,
    this.approvedby3Fullname,
    this.approvedby3Username,
    this.approvedby3Email,
    this.approvedby3Mobile,
    this.approved3On,
    this.status,
    this.digest,
    this.projectDescr,
    this.masterViewModel,
    this.approver1Passed,
    this.unableAsTemplate,
    this.geographyControlEnforced,
    this.onlyPmAccountable,
    this.otherSinglePersonAccountable,
    this.testApproversGeographyControlled,
    this.networkSiteSurveyAllowed,
    this.telecomSignalSurveyAllowed,
    this.equipmentSurveyAllowed,
    this.customerSurveyAllowed,
    this.vendorSurveyAllowed,
    this.channelSurveyAllowed,
    this.employeeSurveyAllowed,
    this.geologicalSurveyAllowed,
    this.environmentSurveyAllowed,
    this.populationSurveyAllowed,
    this.householdSurveyAllowed,
    this.industrySurveyAllowed,
    this.generalGurveyAllowed,
    //  this.scopeBuckets,
  });

  factory ProgressDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressDashboardModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProgressDashboardModelToJson(this);
}

@JsonSerializable()
class ScopeBuckets {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? projectId;
  String? projectCode;
  String? projectName;
  String? bucketCode;
  String? bucketName;
  int? outputTarget;
  String? outputDescr;
  double? outputTargetAssigned;
  double? outputAchieved;
  double? outputProgress;
  int? countR;
  int? countA;
  int? countS;
  int? countC;
  int? countI;
  double? progressR;
  double? progressA;
  double? progressS;
  double? progressC;
  double? progressI;
  String? fullname;
  String? username;
  String? email;
  String? mobile;

  List<ActivityDropdown>? activityGroups;

  ScopeBuckets({
    this.id,
    this.countryCode,
    this.countryName,
    this.agencyId,
    this.agencyCode,
    this.agencyName,
    this.projectId,
    this.projectCode,
    this.projectName,
    this.bucketCode,
    this.bucketName,
    this.outputTarget,
    this.outputDescr,
    this.outputTargetAssigned,
    this.outputAchieved,
    this.outputProgress,
    this.countR,
    this.countA,
    this.countS,
    this.countC,
    this.countI,
    this.progressR,
    this.progressA,
    this.progressS,
    this.progressC,
    this.progressI,
    this.fullname,
    this.username,
    this.email,
    this.mobile,
    this.activityGroups,
  });

  factory ScopeBuckets.fromJson(Map<String, dynamic> json) =>
      _$ScopeBucketsFromJson(json);
  Map<String, dynamic> toJson() => _$ScopeBucketsToJson(this);
}
