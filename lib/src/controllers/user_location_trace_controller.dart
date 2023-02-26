import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../helpers/global_helper.dart';
import '../helpers/log.dart';
import '../services/api_service.dart';
import 'agencyController.dart';
import 'location_controller.dart';
import 'user_controller.dart';

class UserLocationTraceController extends GetxController with ApiService {
  final agencyC = Get.put(AgencyController());
  final _dio = Dio();
  final deviceInfoPlugin = DeviceInfoPlugin();
  // late CarrierData carrierInfo;

  // All Models

  final iPAddress = RxString('');
  final phoneIPAddress = RxString('');
  final simCountryCode = RxString('');
  final deviceIMEINumber = RxString('');
  final macAddress = RxString('');
  final appName = RxString('');
  final frequency = RxString('');
  final currentSignalStrength = RxString('');
  final manufacturer = RxString('');
  final model = RxString('');
  final versionRelease = RxString('');

  final networkType = RxString('');
  final networkOperatorName = RxString('');
  final networkOperator = RxString('');
  final simOperator = RxString('');
  final simOperatorName = RxString('');
  final isoCountryCode = RxString('');

  final connectionType = RxString('');
  final signalStrengthWifi = RxString('');
  final signalStrengthMobile = RxString('');

  final int = RxInt(0);

  @override
  Future<void> onReady() async {
    super.onReady();
    //kLog('Init Ip Address');
    getIpAddress();
    //kLog('init carrier info');
    initCarrierInfo();
    //kLog('init device info');
    initDeviceInfo();
    //kLog('init package info');
    initPackageInfo();
    //kLog('init Wifi');
    getWiFiInfo();
    //kLog('Telephony Info');
    // getTelephonyInfo();
    //kLog('Device Info');
    initDeviceInformation();
    //kLog('Sim Country Code');
    initSimCountryCode();
    //kLog('Init Connectivity');
    getConnectivityDetails();
    // kLog('On Ready');

    if (Get.put(UserController()).currentUser.value != null &&
        agencyC.selectedAgencyData.value != null) {
      Timer.periodic(Duration(minutes: 5), (Timer t) => addUserLocation());
    }
  }

  // init carrier info
  Future<void> getIpAddress() async {
    try {
      final res = await _dio.get<String>('https://api.ipify.org');
      iPAddress.value = res.data!;
      //// kLog('IP Address ${iPAddress.value}');
    } catch (e) {
      // kLog(e.toString());
    }
  }

  Future<void> getConnectivityDetails() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        connectionType.value = 'mobile';
        // if (info.rssi != null)
        // info.signalStrengthMobile = info.rssi?.toDouble();
        signalStrengthMobile.value = currentSignalStrength.value;
        signalStrengthWifi.value = '0.0';
      } else if (connectivityResult == ConnectivityResult.wifi) {
        connectionType.value = 'wifi';
        // if (info.rssi != null) info.signalStrengthWifi = info.rssi?.toDouble();
        signalStrengthMobile.value = '0.0';
        signalStrengthWifi.value = currentSignalStrength.value;
      } else {
        signalStrengthMobile.value = '0.0';
        signalStrengthWifi.value = '0.0';
      }
    } catch (e) {
      // kLog('Cannot access ConnectivityDetails: $e');
    }
  }

  Future<void> getWiFiInfo() async {
    try {
      WiFiForIoTPlugin.isEnabled().then(
        (val) async {
          final ip = await WiFiForIoTPlugin.getIP();
          final mac = await WiFiForIoTPlugin.getBSSID();
          final frequencyData = await WiFiForIoTPlugin.getFrequency();
          final strength = await WiFiForIoTPlugin.getCurrentSignalStrength();
          phoneIPAddress.value = ip!;
          macAddress.value = mac!;
          frequency.value = frequencyData.toString();
          currentSignalStrength.value = strength.toString();
          //// kLog(jsonEncode(wiFiInfo.value));
        },
      );
    } catch (e) {
      // kLog('Cannot access getIpAddress: $e');
    }
  }

  Future<void> getTelephonyInfo() async {
    try {
      final Telephony telephonyInfo = Telephony.instance;
      final bool? result = await telephonyInfo.requestPhoneAndSmsPermissions;
      if (result != null && result) {
        /// NetworkType Represents types of networks for a device.
        final networkTypeData = await telephonyInfo.dataNetworkType;

        final networkOperatorNameData = await telephonyInfo.networkOperatorName;
        final networkOperatorData = await telephonyInfo.networkOperator;
        final simOperatorData = await telephonyInfo.simOperator;
        final simOperatorNameData = await telephonyInfo.simOperatorName;

        networkType.value = networkTypeData.index.toString();
        networkOperatorName.value = networkOperatorNameData!;
        networkOperator.value = networkOperatorData!;
        simOperator.value = simOperatorData!;
        simOperatorName.value = simOperatorNameData!;
      }
    } on PlatformException catch (e) {
      kLog('Cannot access Telephony: $e');
    }
  }

  Future<void> getOperatingSystem() async => Platform.operatingSystem;
  Future<void> getScreenResolution() async =>
      '${window.physicalSize.width} X ${window.physicalSize.height}';

  // init carrier info
  Future<void> initCarrierInfo() async {
    await [
      Permission.locationWhenInUse,
      Permission.phone,
    ].request();

    try {
      //  final data = await CarrierInfo.all;
      // isoCountryCode.value = data!.isoCountryCode.toString();
    } catch (e) {
      // kLog(e.toString());
    }
  }

  Future<void> initSimCountryCode() async {
    try {
      final data = await FlutterSimCountryCode.simCountryCode;
      simCountryCode.value = data!;
      //// kLog(simCountryCode.value);
    } on PlatformException catch (e) {
      kLog(e);
    }
  }

  Future<void> initDeviceInformation() async {
    try {
      final data = await DeviceInformation.deviceIMEINumber;
      deviceIMEINumber.value = data;
    } on PlatformException catch (e) {
      kLog(e);
    }
  }

  // init device info
  Future<void> initDeviceInfo() async {
    try {
      final data = await deviceInfoPlugin.androidInfo;
      if (Platform.isAndroid) {
        manufacturer.value = data.manufacturer;
        model.value = data.model;
        versionRelease.value = data.version.release;
      }
    } on PlatformException catch (e) {
      kLog(e);
    }
  }

  // init package info
  Future<void> initPackageInfo() async {
    final packageInfoData = await PackageInfo.fromPlatform();
    appName.value = packageInfoData.appName;
  }

  addUserLocation() async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final userC = Get.put(UserController());
      final locationC = Get.put(LocationController());
      //// kLog(locationC.currentLatLng!.latitude);
      //// kLog(locationC.currentLatLng!.longitude);

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SURVEY',
        'countryCode': 'BD',
        'username': userC.currentUser.value!.username,
        'uiCodes': ['236541'],
        'modelList': [
          {
            'appCode': 'WFC',
            'appName': appName.value,
            'empCode': 'null',
            'empName': 'null',
            'latitude': locationC.currentLatLng != null
                ? locationC.currentLatLng!.latitude.toString()
                : 'N/A',
            'longitude': locationC.currentLatLng != null
                ? locationC.currentLatLng!.longitude.toString()
                : 'N/A',
            'platform': Platform.operatingSystem,
            'username': userC.currentUser.value!.username,
            'personName': userC.currentUser.value!.fullName,
            'visitDate': getCurrrentDateForWF().toString(),
            'visitTime':
                formatDateTime(format: 'yyyy-MM-dd hh:mm:ss').toString(),
            'wsIp': phoneIPAddress.value,
            'wsName':
                '${manufacturer.value} ${model.value} ${versionRelease.value}',
            'status': 'null',
            'ip': iPAddress.value.isNotEmpty ? iPAddress.value : 'N/A',
            'mac': macAddress.value,
            'imei': deviceIMEINumber.value,
            'frequency': frequency.value,
            'signalStrengthWifi': signalStrengthWifi.value,
            'signalStrengthMobile': signalStrengthMobile.value,
            'networkCountryIso': isoCountryCode.value,
            'networkOperator': networkOperator.value,
            'networkType': networkType.value.toString(),
            'networkOperatorName': networkOperatorName.value,
            'simCountryIso': simCountryCode.value,
            'simOperatorName': simOperatorName.value,
            'simOperator': simOperator.value,
            'agencyCode': selectedAgency!.agencyCode,
            'agencyId': selectedAgency.agencyId,
            'projectCode': 'null',
            'assignId': '',
            'areaLevelFullCode': 'null',
            'areaType': 'null',
            'areaLevel': 'null',
            'refNumber': '2b5432a8-7d3b-46d2-b871-c5aba3f51323',
            'broadcastEnabled': 'false'
          }
        ]
      };
      //// kLog(jsonEncode(body));

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_LOG']}/add_user_location_traces',
        body: body,
      );
      //// kLog(res);
    } on DioError catch (e) {
      kLog(e.message);
    }
  }
}
