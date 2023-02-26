import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

import '../models/transportation_dashboard.dart';
import '../pages/transport_dashboard_transport_agency_page.dart';
import 'agencyController.dart';
import 'user_controller.dart';

enum TransportOrderType {
  orderer,
  agency,
  driver,
  inspector,
  whManager,
  receiver,
}

class TransportationDashboardController extends GetxController with ApiService {
  // final _dio = Dio();
  final isLoading = RxBool(false);
  final isExpanded = RxBool(false);

  // Operational Dashboard for Transport Orderer
  final dashboardTransportOrder = RxList<DashboardTransportOrder>([]);

  // Operational Dashboard for Transport Agency

  final agencyMyVehicles = Rx<DashboardAgencyMyVehicles?>(null);

  //Operational Dashboard for Driver
  final dashboardDriverOrder = RxList<DashboardDriverOrder>([]);

  //Operational Dashboard for Inspector
  final inspectionPreloading = RxList<InspectionPreloading>([]);
  final inspectionPostloading = RxList<InspectionPostloading>([]);

  //Operational Dashboard for WH Manager
  final dashboardLoadingVehicle = RxList<DashboardLoadingVehicle>([]);
  final dashboardUnloadVehicle = RxList<DashboardUnloadVehicle>([]);

  //Operational Dashboard for Receiver
  final dashboardReceiverOrder = RxList<DashboardReceiverOrder>([]);

  //=========================================================
  // **** Get transport dashboard (order) by user type ******
  //=========================================================
  void getTransportOrderByUserType() {
    getTransportOrder();

    getTransportOrder();

    getTransportOrder();
    getMyVehicles();
    getInspectionPreloading();
    getInspectionPostloading();

    getAgencyPipelineOrder();
    getAgencyInProgressOrder();

    getReceiverOrder();
  }
  // void getTransportOrderByUserType(TransportOrderType type) {
  //   switch (type) {
  //     case TransportOrderType.orderer:
  //       getTransportOrder();
  //       break;
  //     case TransportOrderType.agency:
  //       getTransportOrder();
  //       break;
  //     case TransportOrderType.driver:
  //       getTransportOrder();
  //       break;
  //     case TransportOrderType.inspector:
  //       getInspectionPreloading();
  //       getInspectionPostloading();
  //       break;
  //     case TransportOrderType.whManager:
  //       getAgencyPipelineOrder();
  //       getAgencyInProgressOrder();
  //       break;
  //     case TransportOrderType.receiver:
  //       getReceiverOrder();
  //       break;
  //   }
  // }

  Widget getTransportComponentByUserType() {
    return Column(
      children: [
        TransportationOrdersPlacedWidget(),
        // SizedBox(height: 8),
        // TransportationOrdersInMyPipelineWidget(),
        // SizedBox(height: 8),
        // MyTransportsinProgressWidget(),
        // SizedBox(height: 8),
        // MyVehiclesWidget(),
        // SizedBox(height: 8),
        // ComplaintsInTransportationWidget(),
        // SizedBox(height: 8),
        // MyTransportationOrdersToDriverWidget(),
        // SizedBox(height: 8),
        // PreloadingInspectionOrdersWidget(),
        // SizedBox(height: 8),
        // PostDeliveryInspectionOrdersWidget(),
        // SizedBox(height: 8),
        // TransportOrdersForLoadingToVehicleWidget(),
        // TransportOrdersToUnloadFromVehicleWidget(),
        // SizedBox(height: 8),
        // TransportOrdersToReceiveWidget()
      ],
    );
  }
  // Widget getTransportComponentByUserType(TransportOrderType type) {
  //   switch (type) {
  //     case TransportOrderType.orderer:
  //       return TransportationOrdersPlacedWidget();

  //     case TransportOrderType.agency:
  //       return Column(
  //         children: [
  //           TransportationOrdersInMyPipelineWidget(),
  //           SizedBox(height: 8),
  //           MyTransportsinProgressWidget(),
  //           SizedBox(height: 8),
  //           MyVehiclesWidget(),
  //           SizedBox(height: 8),
  //           ComplaintsInTransportationWidget(),
  //         ],
  //       );

  //     case TransportOrderType.driver:
  //       return MyTransportationOrdersToDriverWidget();

  //     case TransportOrderType.inspector:
  //       return Column(
  //         children: [
  //           PreloadingInspectionOrdersWidget(),
  //           SizedBox(height: 8),
  //           PostDeliveryInspectionOrdersWidget(),
  //         ],
  //       );

  //     case TransportOrderType.whManager:
  //       return Column(
  //         children: [
  //           TransportOrdersForLoadingToVehicleWidget(),
  //           TransportOrdersToUnloadFromVehicleWidget(),
  //         ],
  //       );

  //     case TransportOrderType.receiver:
  //       return TransportOrdersToReceiveWidget();
  //   }
  // }

  //=========================================================
  // ****** Get transport dashboard (Orderer) Order *******
  //=========================================================
  void getTransportOrder() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'agencyId': selectedAgency!.agencyId,
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/dashboard/get',
        queryParameters: params,
      );
      //// kLog(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final dashboardTransportOrderData = res.data['data']
            .map((json) =>
                DashboardTransportOrder.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashboardTransportOrder>() as List<DashboardTransportOrder>;

        if (dashboardTransportOrderData.isNotEmpty) {
          dashboardTransportOrder.clear();
          dashboardTransportOrder.addAll(dashboardTransportOrderData);
        }
        //// kLog(dashboardTransportOrder.length);
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void transportOrderExapndItem(DashboardTransportOrder v) {
    final item = dashboardTransportOrder.singleWhere((x) => x.id == v.id);

    item.isExpanded = item.isExpanded! ? false : true;
    dashboardTransportOrder[dashboardTransportOrder.indexOf(item)] = item;
  }

  //=========================================================
  // **** Get transport dashboard (Agency) Order ****
  //=========================================================

  //Transportation Orders in My Pipeline
  void getAgencyPipelineOrder() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      // ignore: unused_local_variable
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyId': selectedAgency!.agencyId,
      };

      //// kLog(res.data);
      // if (res.data['status'] != null &&
      //     res.data['status'].contains('successful') == true) {
      //   final dashboardDriverOrderData = res.data['data']
      //       .map((json) =>
      //           DashboardDriverOrder.fromJson(json as Map<String, dynamic>))
      //       .toList()
      //       .cast<DashboardDriverOrder>() as List<DashboardDriverOrder>;

      //   if (dashboardDriverOrderData.isNotEmpty) {
      //     isLoading.value = false;
      //     dashboardDriverOrder.clear();
      //     dashboardDriverOrder.addAll(dashboardDriverOrderData);
      //   }
      // }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //My Transports in Progress
  void getAgencyInProgressOrder() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyId': selectedAgency!.agencyId,
      };

      // ignore: unused_local_variable
      final res = await getDynamic(
        path:
            '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/in-progress/get',
        queryParameters: params,
      );

      // kLog(res.data);
      // if (res.data['status'] != null &&
      //     res.data['status'].contains('successful') == true) {
      //   final dashboardDriverOrderData = res.data['data']
      //       .map((json) =>
      //           DashboardDriverOrder.fromJson(json as Map<String, dynamic>))
      //       .toList()
      //       .cast<DashboardDriverOrder>() as List<DashboardDriverOrder>;

      //   if (dashboardDriverOrderData.isNotEmpty) {
      //     isLoading.value = false;
      //     dashboardDriverOrder.clear();
      //     dashboardDriverOrder.addAll(dashboardDriverOrderData);
      //   }
      // }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //My Vehicles
  void getMyVehicles() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/agency-vehicle/count/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final agencyMyVehiclesData = DashboardAgencyMyVehicles.fromJson(
            res.data['data'] as Map<String, dynamic>);

        if (agencyMyVehiclesData != null) {
          isLoading.value = false;
          agencyMyVehicles.value = agencyMyVehiclesData;
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //=========================================================
  // **** Get transport dashboard (Driver) Order ****
  //=========================================================

  void getDriverOrder() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'remarks': '',
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/vehicle/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final dashboardDriverOrderData = res.data['data']
            .map((json) =>
                DashboardDriverOrder.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashboardDriverOrder>() as List<DashboardDriverOrder>;

        if (dashboardDriverOrderData.isNotEmpty) {
          isLoading.value = false;
          dashboardDriverOrder.clear();
          dashboardDriverOrder.addAll(dashboardDriverOrderData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //=========================================================
  // **** Get transport dashboard (Inspector) Order  ****
  //=========================================================

  //My Preloading Inspection Orders
  void getInspectionPreloading() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'agencyIds': selectedAgency!.agencyId,
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/inspection/preloading/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final inspectionPreloadingData = res.data['data']
            .map((json) =>
                InspectionPreloading.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<InspectionPreloading>() as List<InspectionPreloading>;

        if (inspectionPreloadingData.isNotEmpty) {
          isLoading.value = false;
          inspectionPreloading.clear();
          inspectionPreloading.addAll(inspectionPreloadingData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void inspectionPreloadingExapndItem(InspectionPreloading v) {
    final item = inspectionPreloading.singleWhere((x) => x.id == v.id);

    item.isExpanded = item.isExpanded! ? false : true;
    inspectionPreloading[inspectionPreloading.indexOf(item)] = item;
  }

  //My Post Delivery Inspection Orders
  void getInspectionPostloading() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'agencyIds': selectedAgency!.agencyId,
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/inspection/postloading/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final inspectionPostloadingData = res.data['data']
            .map((json) =>
                InspectionPostloading.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<InspectionPostloading>() as List<InspectionPostloading>;

        if (inspectionPostloadingData.isNotEmpty) {
          inspectionPostloading.clear();
          inspectionPostloading.addAll(inspectionPostloadingData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void inspectionPostloadingExapndItem(InspectionPostloading v) {
    final item = inspectionPostloading.singleWhere((x) => x.id == v.id);

    item.isExpanded = item.isExpanded! ? false : true;
    inspectionPostloading[inspectionPostloading.indexOf(item)] = item;
  }
  //-------------------------End-----------------------------

  //=========================================================
  // ****** Get transport dashboard (WH Manager) Order *******
  //=========================================================

  //Transport Orders for Loading to Vehicle
  void getTransportOrderLoading() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/loading/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final dashboardLoadingVehicleData = res.data['data']
            .map((json) =>
                DashboardLoadingVehicle.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashboardLoadingVehicle>() as List<DashboardLoadingVehicle>;

        if (dashboardLoadingVehicleData.isNotEmpty) {
          isLoading.value = false;
          dashboardLoadingVehicle.clear();
          dashboardLoadingVehicle.addAll(dashboardLoadingVehicleData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //Transport Orders to Unload From Vehicle
  void getTransportOrderUnload() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      isLoading.value = true;
      final params = {
        'agencyIds': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/loading/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final dashboardUnloadVehicleData = res.data['data']
            .map((json) =>
                DashboardUnloadVehicle.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashboardUnloadVehicle>() as List<DashboardUnloadVehicle>;

        if (dashboardUnloadVehicleData.isNotEmpty) {
          isLoading.value = false;
          dashboardUnloadVehicle.clear();
          dashboardUnloadVehicle.addAll(dashboardUnloadVehicleData);
        }
      }
      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //=========================================================
  // ****** Get transport dashboard (Receiver) Order *******
  //=========================================================
  //My Post Delivery Inspection Orders
  void getReceiverOrder() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': selectedAgency!.agencyId,
        'remarks': '',
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/transport-order/receive/get',
        queryParameters: params,
      );
      //// kLog(res.data);
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        // kLog(res.data['status']);
        final dashboardReceiverOrderData = res.data['data']
            .map((json) =>
                DashboardReceiverOrder.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<DashboardReceiverOrder>() as List<DashboardReceiverOrder>;

        if (dashboardReceiverOrderData.isNotEmpty) {
          dashboardReceiverOrder.clear();
          dashboardReceiverOrder.addAll(dashboardReceiverOrderData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
