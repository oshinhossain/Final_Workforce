import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/pages/my_approval_dashboard_page.dart';
import 'package:workforce/src/pages/push_notifications_page.dart';

class KAppbar extends StatelessWidget with PreferredSizeWidget, Base {
  // Widget? flexiblespace;
  // Widget? bottom;
  // KAppbar({
  //   this.flexiblespace = null,
  //   this.bottom = null,
  // });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: IconButton(
          tooltip: 'Open Drawer',
          icon: Icon(
            Icons.more_vert_rounded,
            color: AppTheme.textColor,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: InkWell(
        onTap: () {
          menuC.currentIndex.value = 0;
          offAll(MainPage());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: SvgPicture.asset(
            '${Constants.svgPath}/workforce_text_logo.svg',
          ),
        ),
      ),
      titleSpacing: 0,
      surfaceTintColor: AppTheme.appbarColor,
      backgroundColor: AppTheme.appbarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppTheme.appbarColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.grey[50],
        systemNavigationBarColor: Colors.grey[50],
      ),
      actions: menuC.appbarMenus
          .map(
            (item) => GestureDetector(
              onTap: () {
                switch (menuC.appbarMenus.indexOf(item)) {
                  case 0:
                    push(MyApprovalDashboardPage());
                    break;
                  case 4:
                    Scaffold.of(context).openEndDrawer();
                    break;
                  case 3:
                    push(PushNotificationsPage());
                    break;
                }
              },
              child: menuC.appbarMenus.indexOf(item) == 1
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                      child: IconButton(
                        tooltip: 'Open Drawer',
                        icon: SvgPicture.asset(
                          'assets/svg/top_5.svg',
                          height: 22,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    )
                  : Obx(
                      () => Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7),
                            child: SvgPicture.asset(
                              '${Constants.svgPath}/$item',
                              color: AppTheme.textColor,
                            ),
                          ),
                          if (notificationsC.notifications.isNotEmpty &&
                              menuC.appbarMenus.indexOf(item) == 3)
                            Positioned(
                              top: 4,
                              right: -1,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppTheme.appbarColor, width: 2),
                                  shape: BoxShape.circle,
                                  color: hexToColor('#F51616'),
                                ),
                                child: KText(
                                  text:
                                      '${notificationsC.notifications.length}',
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
            ),
          )
          .toList(),
    );
  }
}
