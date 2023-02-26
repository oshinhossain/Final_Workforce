// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transportation_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardTransportOrder _$DashboardTransportOrderFromJson(
        Map<String, dynamic> json) =>
    DashboardTransportOrder(
      id: json['id'] as String?,
      transportOrderDate: json['transportOrderDate'] as String?,
      transporterAgencyName: json['transporterAgencyName'] as String?,
      sourceLocName: json['sourceLocName'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      latestEtd: json['latestEtd'] as String?,
      remarks: json['remarks'] as String?,
      receiverAgencyName: json['receiverAgencyName'] as String?,
      destinationLocName: json['destinationLocName'] as String?,
      status: json['status'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardTransportOrderToJson(
        DashboardTransportOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderDate': instance.transportOrderDate,
      'transporterAgencyName': instance.transporterAgencyName,
      'sourceLocName': instance.sourceLocName,
      'transportOrderNo': instance.transportOrderNo,
      'latestEtd': instance.latestEtd,
      'remarks': instance.remarks,
      'receiverAgencyName': instance.receiverAgencyName,
      'destinationLocName': instance.destinationLocName,
      'status': instance.status,
      'isExpanded': instance.isExpanded,
    };

DashboardAgencyMyVehicles _$DashboardAgencyMyVehiclesFromJson(
        Map<String, dynamic> json) =>
    DashboardAgencyMyVehicles(
      total: json['total'] as num?,
      functional: json['functional'] as num?,
      inAcative: json['inAcative'] as num?,
      onDuty: json['onDuty'] as num?,
      requestForService: json['requestForService'] as num?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardAgencyMyVehiclesToJson(
        DashboardAgencyMyVehicles instance) =>
    <String, dynamic>{
      'total': instance.total,
      'functional': instance.functional,
      'inAcative': instance.inAcative,
      'onDuty': instance.onDuty,
      'requestForService': instance.requestForService,
      'isExpanded': instance.isExpanded,
    };

DashboardDriverOrder _$DashboardDriverOrderFromJson(
        Map<String, dynamic> json) =>
    DashboardDriverOrder(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      ets: json['ets'] as String?,
      etd: json['etd'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      reamark: json['reamark'] as String?,
      receivingParty: json['receivingParty'] as String?,
      reamarkFromTransportAgencey:
          json['reamarkFromTransportAgencey'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardDriverOrderToJson(
        DashboardDriverOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'ets': instance.ets,
      'etd': instance.etd,
      'vehicleNo': instance.vehicleNo,
      'source': instance.source,
      'destination': instance.destination,
      'reamark': instance.reamark,
      'receivingParty': instance.receivingParty,
      'reamarkFromTransportAgencey': instance.reamarkFromTransportAgencey,
      'isExpanded': instance.isExpanded,
    };

InspectionPreloading _$InspectionPreloadingFromJson(
        Map<String, dynamic> json) =>
    InspectionPreloading(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      ets: json['ets'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      numberOfItems: (json['numberOfItems'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      sourceLocName: json['sourceLocName'] as String?,
      status: json['status'] as String?,
      remarksFromAgency: json['remarksFromAgency'] as String?,
      remarksFromInspector: json['remarksFromInspector'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$InspectionPreloadingToJson(
        InspectionPreloading instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'ets': instance.ets,
      'vehicleNo': instance.vehicleNo,
      'numberOfItems': instance.numberOfItems,
      'totalWeight': instance.totalWeight,
      'sourceLocName': instance.sourceLocName,
      'status': instance.status,
      'remarksFromAgency': instance.remarksFromAgency,
      'remarksFromInspector': instance.remarksFromInspector,
      'isExpanded': instance.isExpanded,
    };

InspectionPostloading _$InspectionPostloadingFromJson(
        Map<String, dynamic> json) =>
    InspectionPostloading(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      etd: json['etd'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      numberOfItems: (json['numberOfItems'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      destination: json['destination'] as String?,
      status: json['status'] as String?,
      remarks: json['remarks'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$InspectionPostloadingToJson(
        InspectionPostloading instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'etd': instance.etd,
      'vehicleNo': instance.vehicleNo,
      'numberOfItems': instance.numberOfItems,
      'totalWeight': instance.totalWeight,
      'destination': instance.destination,
      'status': instance.status,
      'remarks': instance.remarks,
      'isExpanded': instance.isExpanded,
    };

DashboardLoadingVehicle _$DashboardLoadingVehicleFromJson(
        Map<String, dynamic> json) =>
    DashboardLoadingVehicle(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      etd: json['etd'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      numberOfItem: json['numberOfItem'] as int?,
      weight: json['weight'] as int?,
      source: json['source'] as String?,
      status: json['status'] as String?,
      remarksFromTransportAgencey:
          json['remarksFromTransportAgencey'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardLoadingVehicleToJson(
        DashboardLoadingVehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'etd': instance.etd,
      'vehicleNo': instance.vehicleNo,
      'numberOfItem': instance.numberOfItem,
      'weight': instance.weight,
      'source': instance.source,
      'status': instance.status,
      'remarksFromTransportAgencey': instance.remarksFromTransportAgencey,
      'isExpanded': instance.isExpanded,
    };

DashboardUnloadVehicle _$DashboardUnloadVehicleFromJson(
        Map<String, dynamic> json) =>
    DashboardUnloadVehicle(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      etd: json['etd'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      numberOfItem: json['numberOfItem'] as num?,
      weight: json['weight'] as num?,
      source: json['source'] as String?,
      status: json['status'] as String?,
      remarksFromTransportAgencey:
          json['remarksFromTransportAgencey'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardUnloadVehicleToJson(
        DashboardUnloadVehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'etd': instance.etd,
      'vehicleNo': instance.vehicleNo,
      'numberOfItem': instance.numberOfItem,
      'weight': instance.weight,
      'source': instance.source,
      'status': instance.status,
      'remarksFromTransportAgencey': instance.remarksFromTransportAgencey,
      'isExpanded': instance.isExpanded,
    };

DashboardReceiverOrder _$DashboardReceiverOrderFromJson(
        Map<String, dynamic> json) =>
    DashboardReceiverOrder(
      id: json['id'] as String?,
      transportOrderNo: json['transportOrderNo'] as String?,
      etd: json['etd'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      numberOfItems: (json['numberOfItems'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      status: json['status'] as String?,
      remarksFromAgency: json['remarksFromAgency'] as String?,
      remarksDriver: json['remarksDriver'] as String?,
      remarksFromWarehouseManager:
          json['remarksFromWarehouseManager'] as String?,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardReceiverOrderToJson(
        DashboardReceiverOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transportOrderNo': instance.transportOrderNo,
      'etd': instance.etd,
      'vehicleNo': instance.vehicleNo,
      'numberOfItems': instance.numberOfItems,
      'totalWeight': instance.totalWeight,
      'source': instance.source,
      'destination': instance.destination,
      'status': instance.status,
      'remarksFromAgency': instance.remarksFromAgency,
      'remarksDriver': instance.remarksDriver,
      'remarksFromWarehouseManager': instance.remarksFromWarehouseManager,
      'isExpanded': instance.isExpanded,
    };
