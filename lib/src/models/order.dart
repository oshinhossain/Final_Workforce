import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Order {
  @HiveField(0)
  String? id;
  // -------------------
  @HiveField(1)
  String? title;
  // -------------------
  @HiveField(2)
  @JsonKey(name: 'my_quantity')
  int? quantity;

  Order({this.id, this.quantity, this.title});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
