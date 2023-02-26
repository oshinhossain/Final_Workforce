import 'package:json_annotation/json_annotation.dart';

part 'apply_for_loan.g.dart';

@JsonSerializable()
class ApplyForLoan {
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
  String? category;
  String? transactionType;
  String? applicationRefno;
  String? applicationDate;
  String? description;
  String? createdAt;
  String? lastEditedAt;
  num? amount;
  String? currcy;
  num? interestRate;
  num? interest;
  String? intCalcMethod;
  num? installment;
  String? disbursementDate;
  String? disbursementMethod;
  String? disbursementRefno;
  String? disbursementRemarks;
  String? dedStartDate;
  num? dedStartMon;
  num? attachmentCount;
  String? statusCode;
  String? status;
  num? approverCount;
  String? approvedby1Fullname;
  String? approvedby1Username;
  String? approvedby1Email;
  String? approvedby1Mobile;
  String? approved1On;
  String? approvedby1Remarks;
  String? approvedby2Fullname;
  String? approvedby2Username;
  String? approvedby2Email;
  String? approvedby2Mobile;
  String? approved2On;
  String? approvedby2Remarks;
  String? approvedby3Fullname;
  String? approvedby3Username;
  String? approvedby3Email;
  String? approvedby3Mobile;
  String? approved3On;
  String? approvedby3Remarks;
  String? digest;
  String? masterViewModel;
  bool? disbursed;
  bool? approver1Passed;
  bool? approver2Passed;
  bool? approver3Passed;

  ApplyForLoan(
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
      this.category,
      this.transactionType,
      this.applicationRefno,
      this.applicationDate,
      this.description,
      this.createdAt,
      this.lastEditedAt,
      this.amount,
      this.currcy,
      this.interestRate,
      this.interest,
      this.intCalcMethod,
      this.installment,
      this.disbursementDate,
      this.disbursementMethod,
      this.disbursementRefno,
      this.disbursementRemarks,
      this.dedStartDate,
      this.dedStartMon,
      this.attachmentCount,
      this.statusCode,
      this.status,
      this.approverCount,
      this.approvedby1Fullname,
      this.approvedby1Username,
      this.approvedby1Email,
      this.approvedby1Mobile,
      this.approved1On,
      this.approvedby1Remarks,
      this.approvedby2Fullname,
      this.approvedby2Username,
      this.approvedby2Email,
      this.approvedby2Mobile,
      this.approved2On,
      this.approvedby2Remarks,
      this.approvedby3Fullname,
      this.approvedby3Username,
      this.approvedby3Email,
      this.approvedby3Mobile,
      this.approved3On,
      this.approvedby3Remarks,
      this.digest,
      this.masterViewModel,
      this.disbursed,
      this.approver1Passed,
      this.approver2Passed,
      this.approver3Passed});

  factory ApplyForLoan.fromJson(Map<String, dynamic> json) => _$ApplyForLoanFromJson(json);
  Map<String, dynamic> toJson() => _$ApplyForLoanToJson(this);
}
