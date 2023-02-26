import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';

import 'package:workforce/src/pages/attendance_page.dart';

import '../controllers/deep_link_controller.dart';
import '../controllers/menu_controller.dart';

import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with Base {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
    SystemChrome.restoreSystemUIOverlays();

    super.initState();
    Get.put(DeepLinkController()).handleInitialUri();
  }

  @override
  Widget build(BuildContext context) {
    attendanceC.getAttendaneHistory();
    // if (Get.put(UserController()).currentUser.value != null &&
    //     agencyC.selectedAgencyData.value != null) {
    //   Timer.periodic(Duration(seconds: 5), (Timer t) {
    //     versionC.getAppVersion();
    //     if (!versionC.checkAppVersion()) {
    //       userC.logOut(isLogin: true);
    //     }
    //   });
    // }
    return Obx(
      () => WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          floatingActionButton: InkWell(
            onTap: (() {
              push(AttendancePage());
            }),
            child: RenderSvg(
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              path: 'attend',
            ),
          ),
          drawer: LeftSidebarComponent(),
          endDrawer: RightSidebarComponent(),
          appBar: KAppbar(),
          bottomNavigationBar: Container(
            color: AppTheme.appbarColor,
            height: 82,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: menuC.bottomMenus
                  .map(
                    (item) => GestureDetector(
                      onTap: () {
                        if (menuC.getMenuIndex(item) == 2) {
                          searchLocationBottomSheet();
                        } else {
                          menuC.setCurrentIndex = item;
                        }
                      },
                      child: SvgPicture.asset(
                        '${Constants.svgPath}/$item',
                        color: menuC.getMenuIndex(item) == 0
                            ? Colors.transparent
                            : menuC.getMenuIndex(item) == 1
                                ? null
                                : menuC.currentIndex.value ==
                                        menuC.getMenuIndex(item)
                                    ? AppTheme.color2
                                    : AppTheme.color6,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          body: menuC.getCurrentPage(),
        ),
      ),
    );
  }
}
