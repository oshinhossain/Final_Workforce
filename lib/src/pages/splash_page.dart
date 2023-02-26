import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/config_controller.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_img.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../helpers/global_helper.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with Base {
  @override
  void initState() {
    _updateAppbar();
    initAppVersion();

    // Get.put(ConfigController()).init();
    super.initState();
  }

  initAppVersion() async {
    versionC.getAppVersion();
    await 4.delay();
    Get.put(ConfigController()).init();
  }

  void _updateAppbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: hexToColor('#33a0da').withOpacity(0.1),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              hexToColor('#33A0DA'),
              hexToColor('#AFD6EB'),
              hexToColor('#FFFFFF'),
              hexToColor('#FFFFFF'),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: RenderImg(
                  path: 'splash_banner.png',
                  width: 300,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              RenderSvg(
                path: 'workforce_logo',
                width: 200,
              ),
              SizedBox(height: 60),
              RenderSvg(
                path: 'ctrends_logo',
                width: 100,
                color: hexToColor('#8FC2F0'),
              ),
              SizedBox(height: 20),
              KText(
                text: 'Version ${AppTheme.appVersion}',
                color: hexToColor('#9FB3BE'),
              ),
              SizedBox(height: 5),
              KText(
                text: '© ${getCurrentYear()} ${AppTheme.appTitle}',
                color: hexToColor('#9FB3BE'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
