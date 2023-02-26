import 'package:json_annotation/json_annotation.dart';

import 'load_materials_vehicle_items_list.dart';
part 'load_materials_vehicle_items.g.dart';

@JsonSerializable()
class LoadMaterialsVehicleItems {
  String? id;
  String? registrationNo;
  LoadMaterialsVehicleItemsList? vehicleItems;

  LoadMaterialsVehicleItems({
    this.id,
    this.registrationNo,
    this.vehicleItems,
  });

  factory LoadMaterialsVehicleItems.fromJson(Map<String, dynamic> json) =>
      _$LoadMaterialsVehicleItemsFromJson(json);
  Map<String, dynamic> toJson() => _$LoadMaterialsVehicleItemsToJson(this);
}
