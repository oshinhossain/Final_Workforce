import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workforce/src/helpers/route.dart';

import '../config/base.dart';

import 'hex_color.dart';
import 'k_text.dart';
import 'render_svg.dart';

class GlobalDialog with Base {
  GlobalDialog._();

  //show success Dialog
  static void statusDialog({
    required String title,
    required String msg,
    Color? color,
    String? path,
    required void Function()? onPressed,
  }) async {
    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color != null ? color : hexToColor('#007BEC'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (path != null) RenderSvg(path: path),
                      if (path != null) SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(fontFamily: 'Manrope', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      KText(
                        text: msg,
                        maxLines: 5,
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            color != null ? color : hexToColor('#007BEC'),
                          ),
                          visualDensity: VisualDensity(horizontal: 2),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: KText(
                          text: 'Ok',
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //show success Dialog
  static void confirmationDialog({
    required String title,
    required String msg,
    Color? titleBackgroundColor,
    Color? cancelBackgroundColor,
    Color? confirmBackgroundColor,
    String? path,
    required void Function()? onPressed,
  }) async {
    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 23),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: titleBackgroundColor != null ? titleBackgroundColor : hexToColor('#007BEC'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (path != null) RenderSvg(path: path),
                      if (path != null) SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(fontFamily: 'Manrope', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      KText(
                        text: msg,
                        maxLines: 5,
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  cancelBackgroundColor != null ? cancelBackgroundColor : hexToColor('#FF6565'),
                                ),
                                visualDensity: VisualDensity(horizontal: 2),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              onPressed: () => back(),
                              child: KText(
                                text: 'No',
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size?>(Size(109, 35)),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  confirmBackgroundColor != null ? confirmBackgroundColor : hexToColor('#007BEC'),
                                ),
                                visualDensity: VisualDensity(horizontal: 2),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    // side: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              onPressed: onPressed,
                              child: KText(
                                text: 'Yes',
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Add site dialog for add marker
  static void addSiteDialog({
    required String title,
    Color? titleBackgroundColor,
    Color? cancelBackgroundColor,
    Color? confirmBackgroundColor,
    String? path,
    // required void Function()? onPressed,
    required Widget widget,
  }) async {
    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // height: 500,
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: titleBackgroundColor != null ? titleBackgroundColor : hexToColor('#FFB661'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (path != null) RenderSvg(path: path),
                      if (path != null) SizedBox(width: 10),
                      Text(
                        title,
                        style:
                            TextStyle(fontFamily: 'Manrope', color: hexToColor('#3B454B'), fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                widget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
