import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/assign_vehicle_and_driver_page.dart';
import 'package:workforce/src/pages/confirm_material_receipt_page.dart';
import 'package:workforce/src/pages/confirm_recipient_page.dart';
import 'package:workforce/src/pages/inspect_materials_to_drop_page.dart';
import 'package:workforce/src/pages/start_journey_page.dart';
import 'package:workforce/src/pages/unload_materials_vehicle_page.dart';

import '../pages/confirm_transport_page.dart';
import '../pages/inspect_materials_to_transport_page.dart';

class DeepLinkController extends GetxController {
  @override
  void onInit() {
    handleIncomingLinks();
    super.onInit();
  }

  void handleIncomingLinks() {
    if (!kIsWeb) {
      uriLinkStream.listen((Uri? uri) {
        // kLog(uri);
        final destPage = uri!.queryParameters['destPage'];
        final transportOrderNo = uri.queryParameters['transportOrderNo'];

        pushPage(transportOrderNo: transportOrderNo!, destPage: destPage!);
      }, onError: (err) {
        print('got err: $err');
      });
    }
  }

  void handleInitialUri() async {
    try {
      final uri = await getInitialUri();
      if (uri == null) {
        // kLog('no initial uri');
      } else {
        // kLog(uri);
        final destPage = uri.queryParameters['destPage'];
        final transportOrderNo = uri.queryParameters['transportOrderNo'];
        pushPage(transportOrderNo: transportOrderNo!, destPage: destPage!);
      }
    } on PlatformException {
      print('falied to get initial uri');
    } on FormatException catch (err) {
      print(err);
    }
  }

  void pushPage({required String transportOrderNo, required String destPage}) {
    switch (destPage) {
      case 'assign_vehicles_and_drivers':
        push(AssignVehicleAndDriverPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'inspect_materials_to_transport':
        push(InspectMaterialsToTransportPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'load_materials_to_vehicles':
        push(InspectMaterialsToTransportPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'confirm_transport_order_readiness_by_driver':
        push(ConfirmTransportOrderReadinessByDriverPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'confirm_transport_order_readiness_by_receiver':
        push(ConfirmTransportOrderReadinessBYReceiverPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'start_journey':
        push(StartJourneyPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'Unload_materials_from_vehicles':
        push(UnloadMaterialsVehicle(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'confirm_material_receipt':
        push(ConfirmMaterialReceiptPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
      case 'inspect_materials_at_drop_locations':
        push(InspectMaterialsToDropLocationPage(
          isFromNotification: true,
          transportOrderNo: transportOrderNo,
        ));
        break;
    }
  }
}
