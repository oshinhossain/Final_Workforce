import 'package:json_annotation/json_annotation.dart';
part 'pc_config_model.g.dart';

@JsonSerializable()
class PcConfigModel {
  @JsonKey(name: 'signaling_server')
  String? signalingServer;
  @JsonKey(name: 'ice_urls')
  List<String>? iceUrls;
  @JsonKey(name: 'ice_username')
  String? iceUsername;
  @JsonKey(name: 'ice_credential')
  String? iceCredential;

  PcConfigModel({
    this.signalingServer,
    this.iceUrls,
    this.iceUsername,
    this.iceCredential,
  });

  factory PcConfigModel.fromJson(Map<String, dynamic> json) =>
      _$PcConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$PcConfigModelToJson(this);
}
