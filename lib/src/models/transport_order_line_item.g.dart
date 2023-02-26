// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport_order_line_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransportOrderLineItem _$TransportOrderLineItemFromJson(
        Map<String, dynamic> json) =>
    TransportOrderLineItem(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      transportationFee: json['transportationFee'] as String?,
      productCode: json['productCode'] as String?,
      productFullcode: json['productFullcode'] as String?,
      productDescription: json['productDescription'] as String?,
      baseUom: json['baseUom'] as String?,
      expended: json['expended'] as bool?,
      quantity: json['quantity'] as num?,
      productName: json['productName'] as String?,
      distance: json['distance'] as num?,
      weight: json['weight'] as num?,
      dropLatitude: (json['dropLatitude'] as num?)?.toDouble(),
      dropLocName: json['dropLocName'] as String?,
      dropLongitude: (json['dropLongitude'] as num?)?.toDouble(),
      receiverEmail: json['receiverEmail'] as String?,
      receiverFullname: json['receiverFullname'] as String?,
      receiverMobile: json['receiverMobile'] as String?,
      receiverUsername: json['receiverUsername'] as String?,
      dropLocation: json['dropLocation'] == null
          ? null
          : LocationModel.fromJson(
              json['dropLocation'] as Map<String, dynamic>),
      dropLocationType:
          $enumDecodeNullable(_$LocationTypeEnumMap, json['dropLocationType']),
      dropLocationWarehouse: json['dropLocationWarehouse'] == null
          ? null
          : WareHouseModel.fromJson(
              json['dropLocationWarehouse'] as Map<String, dynamic>),
      singleReciverPerson: json['singleReciverPerson'] == null
          ? null
          : UserModel.fromJson(
              json['singleReciverPerson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransportOrderLineItemToJson(
        TransportOrderLineItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'productName': instance.productName,
      'expended': instance.expended,
      'productCode': instance.productCode,
      'productFullcode': instance.productFullcode,
      'productDescription': instance.productDescription,
      'baseUom': instance.baseUom,
      'weight': instance.weight,
      'quantity': instance.quantity,
      'distance': instance.distance,
      'transportationFee': instance.transportationFee,
      'dropLocName': instance.dropLocName,
      'dropLatitude': instance.dropLatitude,
      'dropLongitude': instance.dropLongitude,
      'receiverFullname': instance.receiverFullname,
      'receiverUsername': instance.receiverUsername,
      'receiverEmail': instance.receiverEmail,
      'receiverMobile': instance.receiverMobile,
      'dropLocation': instance.dropLocation,
      'dropLocationWarehouse': instance.dropLocationWarehouse,
      'singleReciverPerson': instance.singleReciverPerson,
      'dropLocationType': _$LocationTypeEnumMap[instance.dropLocationType],
    };

const _$LocationTypeEnumMap = {
  LocationType.office: 'office',
  LocationType.known: 'known',
  LocationType.others: 'others',
};
