import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/auth_controller.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/hive_models/user_image.dart';
import 'package:workforce/src/pages/call/videocall_page.dart';
import 'package:workforce/src/pages/home_page.dart';
import 'package:workforce/src/pages/login_page.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/services/hive_service.dart';
import 'package:workforce/src/services/onesignal_service.dart';
import 'dart:async';
import '../config/app_theme.dart';
import '../config/base.dart';
import '../models/user.dart';
import '../pages/call/call_page.dart';
import '../pages/call/ringing_page.dart';
import '../pages/test/page.dart';

class ConfigController extends GetxController with Base {
  Future<void> initAppConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.put(OneSignalService());

    // await Get.put(FirebaseController()).initFirebase();

    // FCM

    // -----------------------------------------

    // Initialize global environment variables
    await dotenv.load();
    // ---------------------------------------------------
    // Initialize Hive DB
    await Get.put(HiveService()).onInitForApp();
    await notificationsC.getNotifications();
    // Get.put(BackgroundTaskService());
    // ---------------------------------------------------

    //---------To get Location Permission-----------------
    // To get location permition.
    await locationC.getLocationPermission();

    // To listen current latlng after per second.
    await locationC.locationListener();
    //--------------------- End -------------------------

    // Setup App system theme [AppBar & System Navigation]
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    // ignore: deprecated_member_use
    await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppTheme.appbarColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey[50],
        systemNavigationBarColor: Colors.white,
      ),
    );
    // ---------------------------------------------------

    // Set Orientation [default : portrait]
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // ---------------------------------------------------
  }

// Initialize page after default configuration
  void init() async {
    await 1.delay();

    final imageBox = Hive.box<UserImage>('user_image');
    final userImage = imageBox.get('current_user_image');
    if (imageBox.containsKey('current_user_image') &&
        userImage!.image != null) {
      Get.put(AuthController()).userImage.value = userImage.image;
    }

    //-------------------------------------------------
    final userBox = Hive.box<User>('user');
    final localUser = userBox.get('current_user');

    if (userBox.containsKey('current_user') && localUser!.token != null) {
      // Logged in user
      final userData = User(
        fullName: localUser.fullName,
        username: localUser.username,
        token: localUser.token,
        address: localUser.address,
        // image: localUser.image,
      );

      userC.currentUser.value = userData;
      await Get.put(AgencyController()).getAgenciesFromLocalDB();

      offAll(MainPage());
    } else {
      offAll(LoginPage());
    }

    // final userBox = Hive.box<User>('user');
    // final currentUser = userBox.get('current_user');

    // if (currentUser != null) {
    //   Get.put(UserController()).user.value = currentUser;
    //   offAll(MainPage());
    // } else {

    // }
  }
}
