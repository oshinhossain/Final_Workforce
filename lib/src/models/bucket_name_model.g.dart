// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BucketDropdown _$BucketDropdownFromJson(Map<String, dynamic> json) =>
    BucketDropdown(
      id: json['id'] as String?,
      bucketCode: json['bucketCode'] as String?,
      bucketName: json['bucketName'] as String?,
      outputTarget: (json['outputTarget'] as num?)?.toDouble(),
      progressA: (json['progressA'] as num?)?.toDouble(),
      progressR: (json['progressR'] as num?)?.toDouble(),
      fullname: json['fullname'] as String?,
      outputDescr: json['outputDescr'] as String?,
      outputProgress: (json['outputProgress'] as num?)?.toDouble(),
      outputAchieved: (json['outputAchieved'] as num?)?.toDouble(),
      weightPct: (json['weightPct'] as num?)?.toDouble(),
      email: json['email'] as String?,
      mobile: json['mobile'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$BucketDropdownToJson(BucketDropdown instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bucketCode': instance.bucketCode,
      'bucketName': instance.bucketName,
      'outputTarget': instance.outputTarget,
      'progressA': instance.progressA,
      'progressR': instance.progressR,
      'fullname': instance.fullname,
      'outputDescr': instance.outputDescr,
      'outputProgress': instance.outputProgress,
      'outputAchieved': instance.outputAchieved,
      'weightPct': instance.weightPct,
      'email': instance.email,
      'mobile': instance.mobile,
      'username': instance.username,
    };
