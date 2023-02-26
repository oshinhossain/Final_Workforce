import 'package:json_annotation/json_annotation.dart';

part 'expense_reimbursement_workbench.g.dart';

@JsonSerializable()
class ExpenseReimbursementSearchModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? expensePurposeType;
  String? claimRefno;
  String? claimDate;
  String? expenseDescription;
  String? createdAt;
  String? lastEditedAt;
  double? amount;
  String? currcy;
  String? paymentDate;
  String? paymentMethod;
  String? paymentRefno;
  String? paymentRemarks;
  int? attachmentCount;
  String? statusCode;
  String? status;
  int? approverCount;
  String? approvedby1Fullname;
  String? approvedby1Username;
  String? approvedby1Email;
  String? approvedby1Mobile;
//  Null? approved1On;
  String? approvedby1Remarks;
  String? approvedby2Fullname;
  String? approvedby2Username;
  String? approvedby2Email;
  String? approvedby2Mobile;
  // Null? approved2On;
  String? approvedby2Remarks;
  String? approvedby3Fullname;
  String? approvedby3Username;
  String? approvedby3Email;
  String? approvedby3Mobile;
  // Null? approved3On;
  String? approvedby3Remarks;
  // Null? digest;
//  Null? masterViewModel;
  bool? paid;
  bool? approver1Passed;
  bool? approver2Passed;
  bool? approver3Passed;

  ExpenseReimbursementSearchModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.fullname,
      this.username,
      this.email,
      this.mobile,
      this.expensePurposeType,
      this.claimRefno,
      this.claimDate,
      this.expenseDescription,
      this.createdAt,
      this.lastEditedAt,
      this.amount,
      this.currcy,
      this.paymentDate,
      this.paymentMethod,
      this.paymentRefno,
      this.paymentRemarks,
      this.attachmentCount,
      this.statusCode,
      this.status,
      this.approverCount,
      this.approvedby1Fullname,
      this.approvedby1Username,
      this.approvedby1Email,
      this.approvedby1Mobile,
      //  this.approved1On,
      this.approvedby1Remarks,
      this.approvedby2Fullname,
      this.approvedby2Username,
      this.approvedby2Email,
      this.approvedby2Mobile,
      // this.approved2On,
      this.approvedby2Remarks,
      this.approvedby3Fullname,
      this.approvedby3Username,
      this.approvedby3Email,
      this.approvedby3Mobile,
      //  this.approved3On,
      this.approvedby3Remarks,
      //  this.digest,
      //  this.masterViewModel,
      this.paid,
      this.approver1Passed,
      this.approver2Passed,
      this.approver3Passed});

  factory ExpenseReimbursementSearchModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseReimbursementSearchModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$ExpenseReimbursementSearchModelToJson(this);
}

@JsonSerializable()
class ExpenseReimbursementGetModel {
  String? id;
  String? countryCode;
  String? countryName;
  String? agencyId;
  String? agencyCode;
  String? agencyName;
  String? fullname;
  String? username;
  String? email;
  String? mobile;
  String? expensePurposeType;
  String? claimRefno;
  String? claimDate;
  String? expenseDescription;
  String? createdAt;
//  Null? lastEditedAt;
  double? amount;
  String? currcy;
  // Null? paymentDate;
  String? paymentMethod;
  String? paymentRefno;
  String? paymentRemarks;
  int? attachmentCount;
  String? statusCode;
  String? status;
  int? approverCount;
  String? approvedby1Fullname;
  String? approvedby1Username;
  String? approvedby1Email;
  String? approvedby1Mobile;
  // Null? approved1On;
  String? approvedby1Remarks;
  String? approvedby2Fullname;
  String? approvedby2Username;
  String? approvedby2Email;
  String? approvedby2Mobile;
  // Null? approved2On;
  String? approvedby2Remarks;
  String? approvedby3Fullname;
  String? approvedby3Username;
  String? approvedby3Email;
  String? approvedby3Mobile;
  // Null? approved3On;
  String? approvedby3Remarks;
  // Null? digest;
//  Null? masterViewModel;
  bool? paid;
  bool? approver1Passed;
  bool? approver2Passed;
  bool? approver3Passed;

  ExpenseReimbursementGetModel(
      {this.id,
      this.countryCode,
      this.countryName,
      this.agencyId,
      this.agencyCode,
      this.agencyName,
      this.fullname,
      this.username,
      this.email,
      this.mobile,
      this.expensePurposeType,
      this.claimRefno,
      this.claimDate,
      this.expenseDescription,
      this.createdAt,
      //   this.lastEditedAt,
      this.amount,
      this.currcy,
      //  this.paymentDate,
      this.paymentMethod,
      this.paymentRefno,
      this.paymentRemarks,
      this.attachmentCount,
      this.statusCode,
      this.status,
      this.approverCount,
      this.approvedby1Fullname,
      this.approvedby1Username,
      this.approvedby1Email,
      this.approvedby1Mobile,
      //  this.approved1On,
      this.approvedby1Remarks,
      this.approvedby2Fullname,
      this.approvedby2Username,
      this.approvedby2Email,
      this.approvedby2Mobile,
      //  this.approved2On,
      this.approvedby2Remarks,
      this.approvedby3Fullname,
      this.approvedby3Username,
      this.approvedby3Email,
      this.approvedby3Mobile,
      //  this.approved3On,
      this.approvedby3Remarks,
      //  this.digest,
      //  this.masterViewModel,
      this.paid,
      this.approver1Passed,
      this.approver2Passed,
      this.approver3Passed});

  factory ExpenseReimbursementGetModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseReimbursementGetModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExpenseReimbursementGetModelToJson(this);
}
