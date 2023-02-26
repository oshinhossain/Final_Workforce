import 'package:json_annotation/json_annotation.dart';
part 'transportation_history.g.dart';

@JsonSerializable()
class TransportationHistory {
  String? id;
  String? transporterAgencyName;
  String? transportOrderNo;
  String? driverName;
  String? sourceLocName;
  double? sourceLatitude;
  double? sourceLongitude;
  String? destinationLocName;
  double? destinationLatitude;
  double? destinationLongitude;
  String? ets;
  String? etd;
  List<String>? items;
  num? distanceKm;
  String? vehicleRegNo;
  String? status;

  List<DropLocation>? dropLocation;
  bool? isExpand;
  TransportationHistory(
      {this.id,
      this.transporterAgencyName,
      this.transportOrderNo,
      this.driverName,
      this.sourceLocName,
      this.sourceLatitude,
      this.sourceLongitude,
      this.destinationLocName,
      this.destinationLatitude,
      this.destinationLongitude,
      this.ets,
      this.etd,
      this.items,
      this.distanceKm,
      this.vehicleRegNo,
      this.status,
      this.dropLocation,
      this.isExpand});

  factory TransportationHistory.fromJson(Map<String, dynamic> json) => _$TransportationHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$TransportationHistoryToJson(this);
}

@JsonSerializable()
class DropLocation {
  String? productCode;
  String? productName;
  String? dropLocName;
  double? dropLatitude;
  double? dropLongitude;

  DropLocation({this.productCode, this.productName, this.dropLocName, this.dropLatitude, this.dropLongitude});

  factory DropLocation.fromJson(Map<String, dynamic> json) => _$DropLocationFromJson(json);
  Map<String, dynamic> toJson() => _$DropLocationToJson(this);
}
