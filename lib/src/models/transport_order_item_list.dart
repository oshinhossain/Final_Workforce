import 'package:json_annotation/json_annotation.dart';
part 'transport_order_item_list.g.dart';

@JsonSerializable()
class TransportOrderItemList {
  String? id;
  String? countryCode;
  String? countryName;
  String? transportOrderId;
  String? transportOrderNo;
  String? transportOrderDate;
  String? productCategoryId;
  String? productCategoryCode;
  String? productCategoryName;
  String? productSubcategoryId;
  String? productSubcategoryCode;
  String? productSubcategoryName;
  String? productGroupId;
  String? productGroupCode;
  String? productGroupName;
  String? productSubgroupId;
  String? productSubgroupCode;
  String? productSubgroupName;
  int? lineNo;
  String? productId;
  String? productCode;
  String? productName;
  String? productDescription;
  String? productBrand;
  String? baseUom;
  double? baseUomQuantity;
  String? productColor;
  String? productSize;
  String? productSerial;
  String? orderSource;
  String? bizOrderId;
  String? bizOrderRefno;
  String? bizOrderDate;
  double? weightKg;
  double? basePrice;
  double? vatAmount;
  double? grossAmount;
  String? inspectorAtLoadingPointFullname;
  String? inspectorAtLoadingPointUsername;
  String? inspectorAtLoadingPointEmail;
  String? inspectorAtLoadingPointMobile;
  double? inspectorFoundQuantityAtLoadingPoint;
  String? dropLocId;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;
  double? distanceKm;
  num? orderedQuantity;
  double? droppedQuantity;
  String? receiverFullname;
  String? receiverUsername;
  String? receiverEmail;
  String? receiverMobile;
  double? receivedQuantity;
  bool? foundItOkayAtLoadingPoint;
  bool? receiverReady;
  bool? received;

  TransportOrderItemList({
    this.id,
    this.countryCode,
    this.countryName,
    this.transportOrderId,
    this.transportOrderNo,
    this.transportOrderDate,
    this.productCategoryId,
    this.productCategoryCode,
    this.productCategoryName,
    this.productSubcategoryId,
    this.productSubcategoryCode,
    this.productSubcategoryName,
    this.productGroupId,
    this.productGroupCode,
    this.productGroupName,
    this.productSubgroupId,
    this.productSubgroupCode,
    this.productSubgroupName,
    this.lineNo,
    this.productId,
    this.productCode,
    this.productName,
    this.productDescription,
    this.productBrand,
    this.baseUom,
    this.baseUomQuantity,
    this.productColor,
    this.productSize,
    this.productSerial,
    this.orderSource,
    this.bizOrderId,
    this.bizOrderRefno,
    this.bizOrderDate,
    this.weightKg,
    this.basePrice,
    this.vatAmount,
    this.grossAmount,
    this.inspectorAtLoadingPointFullname,
    this.inspectorAtLoadingPointUsername,
    this.inspectorAtLoadingPointEmail,
    this.inspectorAtLoadingPointMobile,
    this.inspectorFoundQuantityAtLoadingPoint,
    this.dropLocId,
    this.dropLocName,
    this.dropLatitude,
    this.dropLongitude,
    this.distanceKm,
    this.orderedQuantity,
    this.droppedQuantity,
    this.receiverFullname,
    this.receiverUsername,
    this.receiverEmail,
    this.receiverMobile,
    this.receivedQuantity,
    this.foundItOkayAtLoadingPoint,
    this.receiverReady,
    this.received,
  });

  factory TransportOrderItemList.fromJson(Map<String, dynamic> json) =>
      _$TransportOrderItemListFromJson(json);
  Map<String, dynamic> toJson() => _$TransportOrderItemListToJson(this);
}
