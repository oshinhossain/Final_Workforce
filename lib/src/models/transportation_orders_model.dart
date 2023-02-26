import 'package:json_annotation/json_annotation.dart';
part 'transportation_orders_model.g.dart';

@JsonSerializable()
class TransportationOrderModel {
  String? orderingAgencyName;
  double? totalDelivered;
  double? deliveredToday;
  double? totalPending;
  double? orderedToday;
  double? totalOrdered;
  String? projectName;
  String? productName;
  String? baseUom;
  dynamic productFullcode;

  TransportationOrderModel({
    this.orderingAgencyName,
    this.totalDelivered,
    this.deliveredToday,
    this.totalPending,
    this.orderedToday,
    this.totalOrdered,
    this.projectName,
    this.productName,
    this.baseUom,
    this.productFullcode,
  });
  factory TransportationOrderModel.fromJson(Map<String, dynamic> json) =>
      _$TransportationOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransportationOrderModelToJson(this);
}
