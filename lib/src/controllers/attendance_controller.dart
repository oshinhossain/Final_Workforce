import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:latlong2/latlong.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workforce/src/controllers/location_controller.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/log.dart';

import 'package:workforce/src/hive_models/attendance.dart';
import 'package:workforce/src/hive_models/attendance_history.dart';
import 'package:workforce/src/services/api_service.dart';

import '../helpers/global_helper.dart';
import '../models/attendance_history_model.dart';
import '../models/known_office_location_model.dart';
import '../models/my_shift_plan_model.dart';
import '../models/office_location_model.dart';
import 'agencyController.dart';
import 'user_controller.dart';

class AttendanceController extends GetxController with ApiService {
  late String currentDate;
  final sec = RxInt(0);
  final standartDistance = RxDouble(100);
  final searchValue = RxString('');
  final officeLocList = RxList<OfficeLocationModel>([]);
  final attHistoryList = RxList<AttendanceHistoryModel>([]);
  final knownOfficeLocationList = RxList<KnownOfficeLocationModel>([]);
  final myshiftPlan = Rx<MyShiftPlanModel?>(null);
  Rx<StopWatchTimer> stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
  ).obs;

  var controllerDestino = TextEditingController();

  late Box<Attendance> attendanceBox;
  final selectedOfficeLocation = Rx<OfficeLocationModel?>(null);

  final selectedKnownLocation = Rx<KnownOfficeLocationModel?>(null);
  final othersLocation = RxString('');

  // set setSelectedLocation(OfficeLocationModel? selectedLoc) =>
  //     selectedLocation.value = selectedLoc!;
  // OfficeLocationModel? get selectLocation => selectedLocation.value;
  @override
  void onInit() {
    currentDate = DateFormat.yMMMMEEEEd().format(DateTime.now());

    super.onInit();
  }

  @override
  void onReady() async {
    await initAtt();
    super.onReady();
  }

  initAtt() async {
    // kLog('the init');
    // ignore: unused_local_variable
    final currentLoc = Get.put(LocationController()).currentLatLng;

    attendanceBox = Hive.box<Attendance>('attendance');

    final newAtt = Attendance(
        presentDay: getCurrentDateTime(),
        attendanceEventType: 'In',
        effectiveHours: sec.value,
        firstInTime: getCurrentDateTime(),
        lat: 12,
        long: 11,
        history: []);

    //// kLog(newAtt);
    await attendanceBox.put(0, newAtt);
    stopWatchTimer.value = StopWatchTimer(
      mode: StopWatchMode.countUp,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
    );
    //stopWatchTimer.onStartTimer();
    // }
  }

  // --------------------------------------------------------

  final locationType = Rx<LocationType>(LocationType.office);
  final purpose = Rx<Purpose>(Purpose.personal);

  final location = RxString('');
  final remarks = RxString('');

  final efectiveSec = RxInt(0);

  // startTime() =>

  void startTimer() {
    //// kLog('start from zero');
    stopWatchTimer.value = StopWatchTimer(
      mode: StopWatchMode.countUp,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
        0,
      ),
    );
    stopWatchTimer.value.onStartTimer();

    // stopWatchTimer.secondTime.listen((value) {
    //   sec.value = value;
    //   // await attendanceBox.put(
    //   //   0,
    //   //   Attendance(effectiveHours: sec),
    //   // );
    // });

    // stopWatchTimer.secondTime.listen((event) {
    //   print(event);
    // });
    // await Future.delayed(Duration(seconds: 6));
    // stopWatchTimer.onStopTimer();
    // final dddd = Duration();
    // int sec = 0;

    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   final dd = sec++;
    //   final ddddd = dd * 300;

    //   // sec++;
    //   final newD = Duration(seconds: ddddd);

    //   workDurations.value = newD;
    // });
  }

  getAttendaneHistory() async {
    try {
      final username = Get.put(UserController()).username;

      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final params = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'countryCode': 'BD',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId!],
        'attDate': DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        'uiCodes': ['411001']
      };

      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/get_daily_in_out',
        body: params,
      );
      //// kLog('response && body');
      // //// kLog(res.data);
      //// kLog(jsonEncode(params));

      if (res.data['responseCode'] != null &&
          res.data['responseCode'].contains('200') == true) {
        final attendanceHistoryData = res.data['data']
            .map((json) =>
                AttendanceHistoryModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<AttendanceHistoryModel>() as List<AttendanceHistoryModel>;

        final attendanceHistory = attendanceHistoryData
            .map((e) => AttendanceHistory(
                eventType: e.timeType,
                lastEffectime: (double.parse(e.effectiveHoursText!)).toInt(),
                location: e.locationName,
                purpose: e.purpose != null ? e.purpose : '',
                remarks: e.remarks,
                isFirst: attendanceHistoryData.indexOf(e) ==
                        attendanceHistoryData.length - 1
                    ? true
                    : false,
                time: int.parse(e.timeValueText!.split(':')[0]) <= 12
                    ? '${e.timeValueText!} AM'
                    : '0${int.parse(e.timeValueText!.split(':')[0]) - 12}:${e.timeValueText!.split(':')[1]}:${e.timeValueText!.split(':')[2]} PM'))
            .toList()
            .reversed
            .cast<AttendanceHistory>();

        if (attendanceHistoryData != null) {
          attHistoryList.clear();
          attHistoryList.addAll(attendanceHistoryData);
        }
        var attData = attendanceBox.get(0);
        //// kLog('att data');
        //// kLog(attData);

        if (attHistoryList.isNotEmpty) {
          if (attData!.history.isNotEmpty) {
            attData.history.clear();
          }
          attData.history.addAll(attendanceHistory);
          attData = attendanceBox.get(0);

          int beforeEffectTime;

          //// kLog('time');
          if (attData!.history.last.time!.split(' ')[1] == 'PM' &&
              ((int.parse(
                      attData.history.last.time!.split(' ')[0].split(':')[0]) !=
                  12))) {
            beforeEffectTime = ((int.parse(attData.history.last.time!
                            .split(' ')[0]
                            .split(':')[0]) +
                        12) *
                    3600) +
                ((int.parse(attData.history.last.time!
                        .split(' ')[0]
                        .split(':')[1])) *
                    60) +
                (int.parse(
                    attData.history.last.time!.split(' ')[0].split(':')[2]));
          } else {
            beforeEffectTime = ((int.parse(attData.history.last.time!
                        .split(' ')[0]
                        .split(':')[0])) *
                    3600) +
                ((int.parse(attData.history.last.time!
                        .split(' ')[0]
                        .split(':')[1])) *
                    60) +
                (int.parse(
                    attData.history.last.time!.split(' ')[0].split(':')[2]));
          }

          int newTime = (int.parse(DateFormat('HH:mm:ss')
                      .format(DateTime.now())
                      .split(':')[0]) *
                  3600) +
              (int.parse(DateFormat('HH:mm:ss')
                      .format(DateTime.now())
                      .split(':')[1]) *
                  60) +
              int.parse(
                  DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[2]);
          int effTime;

          effTime = (newTime - beforeEffectTime) +
              attData.history.last.lastEffectime!;

          if (attData.history.isNotEmpty) {
            if (attData.history.last.eventType!.toLowerCase() == 'in') {
              // // kLog('In');
              stopWatchTimer.value = StopWatchTimer(
                mode: StopWatchMode.countUp,
                presetMillisecond:
                    StopWatchTimer.getMilliSecFromSecond(effTime),
              );

              stopWatchTimer.value.onStartTimer();
            } else if (attData.history.last.eventType!.toLowerCase() == 'out' &&
                attData.history.last.purpose!.toLowerCase() == 'personal') {
              //  print('personal out');
              // stopWatchTimer.value = StopWatchTimer(
              //   mode: StopWatchMode.countUp,
              //   presetMillisecond:
              //       StopWatchTimer.getMilliSecFromSecond(effTime),
              // );
              stopWatchTimer.value
                  .setPresetSecondTime(attData.history.last.lastEffectime!);
              stopWatchTimer.value.onStopTimer();
            } else if (attData.history.last.eventType!.toLowerCase() == 'out' &&
                attData.history.last.purpose!.toLowerCase() == 'official') {
              //// kLog('official  out');
              stopWatchTimer.value = StopWatchTimer(
                mode: StopWatchMode.countUp,
                presetMillisecond:
                    StopWatchTimer.getMilliSecFromSecond(effTime),
              );
              //stopWatchTimer.value.setPresetSecondTime(effTime);
              stopWatchTimer.value.onStartTimer();
            } else if (attData.history.last.eventType!.toLowerCase() == 'eof') {
              // stopWatchTimer.value = StopWatchTimer(
              //   mode: StopWatchMode.countUp,
              //   presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
              //       attData.history[attData.history.length - 1].lastEffectime!),
              // );

              stopWatchTimer.value
                  .setPresetSecondTime(attData.history.last.lastEffectime!);
              stopWatchTimer.value.onStopTimer();
            }
          } else {
            stopWatchTimer.value = StopWatchTimer(
                mode: StopWatchMode.countUp,
                presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0));
          }
          //// kLog('att list length: ${attData.history.length}');
        } else {
          final newAtt = Attendance(
              presentDay: getCurrentDateTime(),
              attendanceEventType: 'In',
              effectiveHours: sec.value,
              firstInTime: getCurrentDateTime(),
              lat: 12,
              long: 11,
              history: []);

          //// kLog(newAtt);
          await attendanceBox.put(0, newAtt);
          stopWatchTimer.value.onResetTimer();
        }
      } else {}
    } on DioError catch (e) {
      print(e.message);
    }
  }

  attendanceIN() async {
    final existAtt = attendanceBox.get(0);
    final currentLoc = Get.put(LocationController()).latLng;

    if (existAtt != null && existAtt.history.isNotEmpty) {
      //// kLog('existing value: ${existAtt.effectiveHours!}');
      //existAtt.purpose = getLocationType(locationType.value);
      existAtt.attendanceEventType = 'In';
      existAtt.lastInTime = getCurrentDateTime();

      int beforeEffectTime;
      //// kLog('time');
      if (existAtt.history[existAtt.history.length - 1].time!
                  .split(' ')[1]
                  .toLowerCase() ==
              'pm' &&
          ((int.parse(existAtt.history[existAtt.history.length - 1].time!
                  .split(' ')[0]
                  .split(':')[0]) !=
              12))) {
        beforeEffectTime = ((int.parse(existAtt
                        .history[existAtt.history.length - 1].time!
                        .split(' ')[0]
                        .split(':')[0]) +
                    12) *
                3600) +
            ((int.parse(existAtt.history[existAtt.history.length - 1].time!
                    .split(' ')[0]
                    .split(':')[1])) *
                60) +
            (int.parse(existAtt.history[existAtt.history.length - 1].time!
                .split(' ')[0]
                .split(':')[2]));
      } else {
        beforeEffectTime = ((int.parse(existAtt
                    .history[existAtt.history.length - 1].time!
                    .split(' ')[0]
                    .split(':')[0])) *
                3600) +
            ((int.parse(existAtt.history[existAtt.history.length - 1].time!
                    .split(' ')[0]
                    .split(':')[1])) *
                60) +
            (int.parse(existAtt.history[existAtt.history.length - 1].time!
                .split(' ')[0]
                .split(':')[2]));
      }

      int newTime = (int.parse(
                  DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[0]) *
              3600) +
          (int.parse(
                  DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[1]) *
              60) +
          int.parse(
              DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[2]);
      int effTime;

      if (existAtt.history[existAtt.history.length - 1].purpose!
              .toLowerCase() ==
          'official') {
        effTime = (newTime - beforeEffectTime) +
            existAtt.history[existAtt.history.length - 1].lastEffectime!;
      } else {
        effTime = existAtt.history[existAtt.history.length - 1].lastEffectime!;
      }

      existAtt.history.add(AttendanceHistory(
          remarks: remarks.value,
          location: location.value,
          time: getAMPMCurrentTime(),
          eventType: 'IN',
          lastEffectime: effTime));
      await attendanceBox.put(0, existAtt);

      final existAtt1 = attendanceBox.get(0);
      //// kLog('remarks value');

      //// kLog(existAtt1!.history.last.remarks);
      stopWatchTimer.value.clearPresetTime();

      stopWatchTimer.value = StopWatchTimer(
          mode: StopWatchMode.countUp,
          presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
            existAtt1!.history[existAtt1.history.length - 1].lastEffectime!,
          ));
      stopWatchTimer.value.onStartTimer();
      await attendanceInOut(isFirst: false);
      remarks.value = '';
      // startTimer();
    } else {
      // First time

      final newAtt = Attendance(
        presentDay: getCurrentDateTime(),
        attendanceEventType: 'In',
        effectiveHours: sec.value,
        firstInTime: getCurrentDateTime(),
        lat: currentLoc.value.latitude,
        long: currentLoc.value.longitude,
        history: [
          AttendanceHistory(
              remarks: remarks.value,
              location: location.value,
              time: getAMPMCurrentTime(),
              eventType: 'IN',
              isFirst: true,
              lastEffectime: 0),
        ],
      );

      // // kLog(newAtt);
      await attendanceBox.put(0, newAtt);
      stopWatchTimer.value = StopWatchTimer(
          presetMillisecond: StopWatchTimer.getMilliSecFromSecond(
            0,
          ),
          mode: StopWatchMode.countUp);
      stopWatchTimer.value.onStartTimer();
      await attendanceInOut(isFirst: true);
    }
  }

  double getDistance(LatLng p1) {
    LatLng p2 = LatLng(
      locationC.latLng.value.latitude,
      locationC.latLng.value.longitude,
    );
    final double distance = Geolocator.distanceBetween(
        p1.latitude, p1.longitude, p2.latitude, p2.longitude);
    //// kLog('distance calc: $distance');
    return distance;
  }

  attendanceOut() async {
    var attData = attendanceBox.get(0);
    attData!.purpose = getPurpose(purpose.value);
    attData.attendanceEventType = 'Out';
    attData.lastOutTime = getCurrentDateTime();
    attData.isOfficeEnd = purpose.value == Purpose.end ? true : false;
    attData.effectiveHours = sec.value;
    int beforeEffectTime;
    //// kLog('time');

    if (attData.history[attData.history.length - 1].time!.split(' ')[1] ==
            'PM' &&
        ((int.parse(attData.history[attData.history.length - 1].time!
                .split(' ')[0]
                .split(':')[0]) !=
            12))) {
      beforeEffectTime = ((int.parse(attData
                      .history[attData.history.length - 1].time!
                      .split(' ')[0]
                      .split(':')[0]) +
                  12) *
              3600) +
          ((int.parse(attData.history[attData.history.length - 1].time!
                  .split(' ')[0]
                  .split(':')[1])) *
              60) +
          ((int.parse(attData.history[attData.history.length - 1].time!
              .split(' ')[0]
              .split(':')[2])));
    } else {
      beforeEffectTime = ((int.parse(attData
                  .history[attData.history.length - 1].time!
                  .split(' ')[0]
                  .split(':')[0])) *
              3600) +
          ((int.parse(attData.history[attData.history.length - 1].time!
                  .split(' ')[0]
                  .split(':')[1])) *
              60) +
          ((int.parse(attData.history[attData.history.length - 1].time!
              .split(' ')[0]
              .split(':')[2])));
    }

    //  // kLog(beforeEffectTime);

    // // kLog(DateTime.now());
    int newTime = (int.parse(
                DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[0]) *
            3600) +
        (int.parse(
                DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[1]) *
            60) +
        (int.parse(
            DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[2]));
    //// kLog(newTime);
    //// kLog(
    //     'effecttime $newTime - $beforeEffectTime + ${(newTime - beforeEffectTime) + attData.history[attData.history.length - 1].lastEffectime!} ${(newTime - beforeEffectTime) + attData.history[attData.history.length - 1].lastEffectime!}');

    if (attData.history.last.eventType!.toLowerCase() != 'out') {
      attData.history.add(
        AttendanceHistory(
            remarks: remarks.value,
            location: location.value,
            time: getAMPMCurrentTime(),
            eventType: getPurpose(purpose.value).toLowerCase() != 'end'
                ? 'OUT'
                : 'EOF',
            purpose: getPurpose(purpose.value),
            lastEffectime: (newTime - beforeEffectTime) +
                attData.history[attData.history.length - 1].lastEffectime!
            // lastEffectime: effTime
            ),
      );
    }

    await attendanceBox.put(0, attData);
    attData = attendanceBox.get(0);

    if (attData!.purpose!.toLowerCase() != 'official') {
      stopWatchTimer.value.onStopTimer();
    }
    await attendanceInOut(isFirst: false);

    remarks.value = '';
  }

  bool isValidTimeRange(TimeOfDay startTime) {
    TimeOfDay now = TimeOfDay.now();
    return ((now.hour > startTime.hour) ||
        (now.hour == startTime.hour && now.minute >= startTime.minute));
  }

  attendanceInOut({required bool isFirst}) async {
    var attData = attendanceBox.get(0);

    bool lateCount = isValidTimeRange(TimeOfDay(hour: 09, minute: 31));
    bool veryLateCount = isValidTimeRange(TimeOfDay(hour: 12, minute: 31));
    //// kLog(locationType.value);
    //// kLog(lateCount);
    try {
      //isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).username;

      final data = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId!],
        'appCode': 'SHOUT',
        'countryCode': 'BD',
        'uiCodes': ['0000'],
        'modelList': [
          {
            'locationType': locationType.value == LocationType.office
                ? 'office'
                : locationType.value == LocationType.known
                    ? 'known'
                    : 'others',
            'timeValueText': DateFormat('HH:mm:ss').format(DateTime.now()),
            'timeValue24':
                '${DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[0]}.${DateFormat('HH:mm:ss').format(DateTime.now()).split(':')[1]}',
            'locationName': selectedKnownLocation.value != null
                ? selectedKnownLocation.value!.locationName
                : selectedOfficeLocation.value != null
                    ? selectedOfficeLocation.value!.locationName
                    : location.value != ''
                        ? location.value
                        : 'others',
            'remarks': attData!.history.last.eventType!.toLowerCase() == 'end'
                ? 'End Of Office'
                : remarks.value,
            'latitude': othersLocation.value != ''
                ? locationC.latLng.value.latitude
                : locationC.latLng.value.latitude,
            'longitude': othersLocation.value != ''
                ? locationC.latLng.value.longitude
                : locationC.latLng.value.longitude,
            'inDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'attDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
            'effectiveHoursText': int.parse(attData
                .history[attData.history.length - 1].lastEffectime
                .toString()),
            'effectiveHours': double.parse((int.parse(attData
                    .history[attData.history.length - 1].lastEffectime
                    .toString()))
                .toString()),
            'timeType': attData.history[attData.history.length - 1].eventType,
            'purpose': attData.history[attData.history.length - 1].purpose,
            'officeTimeCode': '9am_to_6pm',
            'officeTimeName': '9:00 am to 6:00 pm',
            'lateValue': !isFirst
                ? false
                : veryLateCount
                    ? false
                    : lateCount
                        ? true
                        : false,
            'isAbsent': false,
            'isVeryLate': veryLateCount ? true : false
          }
        ]
      };

      // ignore: unused_local_variable
      final res = await postDynamic(
        authentication: true,
        path: '${dotenv.env['BASE_URL_WFC']}/add_attendance_in_out',
        body: data,
      );
      //// kLog('is saved?');
      //// kLog(res.data);
      remarks.value = '';
      //  offAll(ProjectDashboardv1());

    } on DioError catch (e) {
      print(e.message);
    }
  }

  String getLocationType(LocationType locationType) {
    switch (locationType) {
      case LocationType.office:
        //// kLog(LocationType.office);
        return 'Office';
      case LocationType.known:
        //// kLog(LocationType.known);
        return 'Known';
      case LocationType.others:
        //  // kLog(LocationType.others);
        return 'Others';
    }
  }

  String getPurpose(Purpose purpose) {
    switch (purpose) {
      case Purpose.official:
        return 'Official';
      case Purpose.personal:
        return 'Personal';
      case Purpose.end:
        return 'End';
    }
  }

  void clear() async {
    await attendanceBox.clear();
    stopWatchTimer.value.onStopTimer();
    stopWatchTimer.value.onResetTimer();
  }

  getOfficeLoc() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SHOUT',
        'username': username,
        'additionalUsernames': [username],
        'agencyIds': [selectedAgency!.agencyId]
      };
      //// kLog('params==>');
      //// kLog(jsonEncode(body));
      final res = await postDynamic(
        path:
            '${dotenv.env['BASE_URL_KYC']}/get_agency_office_location_by_username_and_id',
        body: body,
        authentication: true,

        // queryParameters: params,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final officeLocationData = res.data['data']
            .map((json) =>
                OfficeLocationModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<OfficeLocationModel>() as List<OfficeLocationModel>;

        if (officeLocationData.isNotEmpty) {
          officeLocList.clear();
          officeLocList.addAll(officeLocationData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getKnownLocation() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'SHOUT',
        'username': username,
        'additionalUsernames': [username],
        'agencyIds': [selectedAgency!.agencyId],
        'searchText': '',
        'uiCodes': ['122011'],
      };
      //// kLog('params*1');
      //// kLog(jsonEncode(body));
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_GIS']}/search_user_defined_location',
        body: body,
        authentication: true,

        // queryParameters: params,
      );

      print(res.data);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        final officeLocationData = res.data['data']
            .map((json) =>
                KnownOfficeLocationModel.fromJson(json as Map<String, dynamic>))
            .toList()
            .cast<KnownOfficeLocationModel>() as List<KnownOfficeLocationModel>;

        if (officeLocationData.isNotEmpty) {
          knownOfficeLocationList.clear();
          knownOfficeLocationList.addAll(officeLocationData);
        }
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getWeeklyShiftPlan() async {
    try {
      final username = Get.put(UserController()).username;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
      };
      //// kLog('params');
      //// kLog(jsonEncode(body));
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/get_tm_office_time',
        body: body,
        authentication: true,

        // queryParameters: params,
      );

      //  print(res.data);

      if (res.data['data'] != null && res.data['responseCode'] == 200) {
        final a =
            MyShiftPlanModel.fromJson(res.data['data'] as Map<String, dynamic>);
        myshiftPlan.value = a;
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  String getrealtime(String time) {
    String splitTime1 = time.split(':')[0];
    String splitTime2 = time.split(':')[1];
    if (int.parse(splitTime1) > 12) {
      int hour = int.parse(splitTime1) - 12;
      if (int.parse(splitTime1) == 12) {
        return '$splitTime1:$splitTime2 PM';
      } else {
        return '$hour:$splitTime2 PM';
      }
    } else {
      return '$splitTime1:$splitTime2 AM';
    }
  }

  getTimefromapi() async {
    try {
      final response = await Dio().get(
          'http://worldtimeapi.org/api/timezone/Asia/dhaka',
          options: Options(headers: {'Content-Type': 'application/json'}));
      kLog('dhaka time');
      kLog(response);
    } catch (e) {
      print(e);
    }
  }
}

// //     lat: 23.77326377165576,
//       long: 90.41129397036092,
