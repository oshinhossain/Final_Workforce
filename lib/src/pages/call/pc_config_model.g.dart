// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pc_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PcConfigModel _$PcConfigModelFromJson(Map<String, dynamic> json) =>
    PcConfigModel(
      signalingServer: json['signaling_server'] as String?,
      iceUrls: (json['ice_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      iceUsername: json['ice_username'] as String?,
      iceCredential: json['ice_credential'] as String?,
    );

Map<String, dynamic> _$PcConfigModelToJson(PcConfigModel instance) =>
    <String, dynamic>{
      'signaling_server': instance.signalingServer,
      'ice_urls': instance.iceUrls,
      'ice_username': instance.iceUsername,
      'ice_credential': instance.iceCredential,
    };
