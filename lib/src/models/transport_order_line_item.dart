import 'package:json_annotation/json_annotation.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/models/location_model.dart';
import 'package:workforce/src/models/user_model.dart';
import 'package:workforce/src/models/warehouse_model.dart';
part 'transport_order_line_item.g.dart';

@JsonSerializable()
class TransportOrderLineItem {
  String? id;
  String? productId;
  String? productName;
  bool? expended;
  String? productCode;
  String? productFullcode;
  String? productDescription;
  String? baseUom;

  // UserModel? goodsRecivier;
  // UserModel? goodsInspector;
  num? weight;
  num? quantity;
  num? distance;
  String? transportationFee;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;

  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;

  LocationModel? dropLocation;
  WareHouseModel? dropLocationWarehouse;
  UserModel? singleReciverPerson;
  LocationType? dropLocationType;
  TransportOrderLineItem({
    this.id,
    this.productId,
    this.transportationFee,
    this.productCode,
    this.productFullcode,
    this.productDescription,
    this.baseUom,
    this.expended,
    // this.goodsInspector,
    // this.goodsRecivier,
    this.quantity,
    this.productName,
    this.distance,
    this.weight,
    this.dropLatitude,
    this.dropLocName,
    this.dropLongitude,
    this.receiverEmail,
    this.receiverFullname,
    this.receiverMobile,
    this.receiverUsername,
    this.dropLocation,
    this.dropLocationType,
    this.dropLocationWarehouse,
    this.singleReciverPerson,
  });

  factory TransportOrderLineItem.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderLineItemFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderLineItemToJson(this);
}
