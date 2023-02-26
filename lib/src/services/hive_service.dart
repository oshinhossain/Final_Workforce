import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:workforce/src/controllers/create_transport_controller.dart';
import 'package:workforce/src/hive_models/attendance.dart';
import 'package:workforce/src/hive_models/attendance_history.dart';
import 'package:workforce/src/hive_models/user_image.dart';
import 'package:workforce/src/models/agency_model.dart';
import 'package:workforce/src/models/order.dart';
import 'package:workforce/src/models/push_notifiaction_model.dart';

import '../models/known_office_location_model.dart';
import '../models/office_location_model.dart';
import '../models/user.dart';

class HiveService extends GetxService {
  Future<void> onInitForApp() async {
    Directory appDocumentDir = await getApplicationDocumentsDirectory();

    Hive.init(appDocumentDir.path);

    await registerAdapters();

    await openBoxes();

    print('Hive initialized for app');
  }

// For background
  Future<void> onInitForBackground() async {
    if (Platform.isAndroid) PathProviderAndroid.registerWith();

    Directory appDocumentDir = await getApplicationDocumentsDirectory();

    Hive.init(appDocumentDir.path);

    await registerAdapters();

    await openBoxes();

    print('Hive initialized for background service');

    await Hive.close();
  }

  Future<void> openBoxes() async {
    await Hive.openBox<User>('user');

    await Hive.openBox<Attendance>('attendance');
    await Hive.openBox<AttendanceHistory>('attendance_history');
    await Hive.openBox<OfficeLocationModel>('office');
    await Hive.openBox<KnownOfficeLocationModel>('known');
    await Hive.openBox<String>('others');
    await Hive.openBox<int>('location_type');

    await Hive.openBox<PushNotificationModel>('push_notifications');

    await Hive.openBox<AgencyModel>('agencies');
    await Hive.openBox<UserImage>('user_image');
    await Hive.openBox<int>('location_type');
  }

  Future<void> registerAdapters() async {
    Hive.registerAdapter(UserAdapter(), override: true);
    Hive.registerAdapter(AttendanceAdapter(), override: true);
    Hive.registerAdapter(AttendanceHistoryAdapter(), override: true);
    Hive.registerAdapter(OrderAdapter(), override: true);
    Hive.registerAdapter(PushNotificationModelAdapter(), override: true);
    Hive.registerAdapter(AgencyModelAdapter(), override: true);
    Hive.registerAdapter(UserImageAdapter(), override: true);
    Hive.registerAdapter(OfficeLocationModelAdapter(), override: true);
    Hive.registerAdapter(KnownOfficeLocationModelAdapter(), override: true);
  }
}
