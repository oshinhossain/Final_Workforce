import 'package:json_annotation/json_annotation.dart';
part 'select_vehicle_type_model.g.dart';

@JsonSerializable()
class SelectVehicleType {
  String? id;
  String? vehicleType;

  SelectVehicleType({
    this.id,
    this.vehicleType,
  });

  factory SelectVehicleType.fromJson(Map<String, dynamic> json) =>
      _$SelectVehicleTypeFromJson(json);
  Map<String, dynamic> toJson() => _$SelectVehicleTypeToJson(this);
}
