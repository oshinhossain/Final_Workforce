import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/scroll_behavior_modified.dart';
import 'package:workforce/src/pages/splash_page.dart';

import 'config/app_theme.dart';
import 'controllers/deep_link_controller.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with Base {
  @override
  void initState() {
    Get.put(DeepLinkController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      dragSpeedRatio: 0.91,
      headerBuilder: () => MaterialClassicHeader(
        color: Colors.green,
      ),
      footerBuilder: () => ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: GetMaterialApp(
        defaultTransition: Transition.cupertino,
        builder: (context, widget) => ScrollConfiguration(
            behavior: ScrollBehaviorModified(), child: widget!),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        home: SplashPage(),
      ),
    );
  }
}
