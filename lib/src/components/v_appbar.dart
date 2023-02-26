import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../config/app_theme.dart';

class VAppbar extends StatelessWidget with PreferredSizeWidget, Base {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final title;
  final Widget svgPath;

  VAppbar({required this.title, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          menuC.globalKey.currentState!.openDrawer();
        },
        child: svgPath,
      ),
      title: Center(
        child: KText(
          text: '$title',
          bold: true,
          color: AppTheme.textColor,
          fontSize: 18,
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
    );
  }
}
