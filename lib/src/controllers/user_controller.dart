import 'dart:developer';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/attendance_controller.dart';
import 'package:workforce/src/controllers/auth_controller.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/user.dart';
import 'package:workforce/src/pages/login_page.dart';
import '../services/api_service.dart';

class UserController extends GetxController with ApiService {
  final authC = Get.put(AuthController());
  final attC = Get.put(AttendanceController());
  final currentUser = Rx<User?>(null);

  String? get username =>
      currentUser.value != null ? currentUser.value!.username : null;

  check() {
    print(currentUser.toJson());
  }

  String? getToken() {
    return currentUser.value!.token;
  }

  void logOut({bool? isLogin = false}) async {
    offAll(LoginPage(isLogin: isLogin));
    authC.disposeData();
    await 2.delay();
    final userBox = Hive.box<User>('user');
    // final officeBox = Hive.box('office');
    // final knownBox = Hive.box('known');
    // officeBox.clear();
    // knownBox.clear();
    attC.stopWatchTimer.value = StopWatchTimer(
      mode: StopWatchMode.countUp,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
    );
    await userBox.put(
      'current_user',
      User(
        username: currentUser.value!.username,
      ),
    );

    currentUser.value = User(
      username: currentUser.value!.username,
    );

    log('${currentUser.value!.username}');
    log('${currentUser.value!.address}');

    authC.userImage.value = null;
    await Get.put(AgencyController()).clearLocalAgencies();

    // final attendanceBox = Hive.box<Attendance>('attendance');
    // attendanceBox.clear();
    // offAll(LoginPage());
  }
}
