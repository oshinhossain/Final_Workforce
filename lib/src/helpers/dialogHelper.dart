// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/site_location_v2.dart';

import '../components/confirm_password_input.dart';
import '../components/NewPasswordInput.dart';
import '../components/NewPasswordSubmitButton.dart';
import '../components/NewPasswordSubmitButton2.dart';
import '../components/OTPInput.dart';
import '../components/UniqueIdentifierSubmitButton.dart';
import '../components/UserUniqueIdentifierInput.dart';
import '../models/appliances.dart';

import '../pages/login_page.dart';
import 'hex_color.dart';

class DialogHelper {
  DialogHelper._();
  //show error dialog
  static void showUniqueIdentifierInputDialog({
    required String title,
    required String inputLabel,
    required Function onChanged,
    required VoidCallback? onPressed,
    // required String inputValue,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hexToColor('#0465BF'),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  children: [
                    UserUniqueIdentifierInput(
                      inputLabel: inputLabel,
                      onChanged: onChanged,
                    ),
                    SizedBox(height: 10),
                    UniqueIdentifierSubmitButton(
                      onPressed: onPressed,
                      // inputValue: inputValue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show error dialog
  static void showOtpAndNewPassInputDialog2({
    required String title,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: hexToColor('#0465BF'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    border: Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    KText(
                      text:
                          'An OTP has been sent on your email. Please check your inbox or spam.',
                      fontSize: 12,
                      color: hexToColor('#007BEC'),
                      maxLines: 2,
                    ),
                    OTPInput(),
                    NewPasswordInput(),
                    ConfirmPasswordInput(),
                    SizedBox(height: 10),
                    NewPasswordSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void forgetPassShowErrorDialog({required String msg}) {
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#0465BF'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Error!',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        msg,
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#007BEC')),
                          visualDensity: VisualDensity(horizontal: 2),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                        ),
                        onPressed: () => back(),
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16.0,
                              color: Colors.white),
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

  static void showOtpAndNewPassInputDialog() {
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: hexToColor('#0465BF'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    border: Border.all(color: hexToColor('#FFFFFF'), width: 1)),
                child: Text(
                  'Forgot Username',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    // TimerCountDown(),
                    KText(
                      text:
                          'An OTP has been sent on your email. Please check your inbox or spam.',
                      fontSize: 12,
                      color: hexToColor('#007BEC'),
                      maxLines: 2,
                    ),

                    OTPInput(),
                    SizedBox(height: 10),
                    NewPasswordSubmitButton2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showForgotPasswordSuccessDialog({
    required String title,
    required String msg,
  }) {
    Get.dialog(
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#0465BF'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        msg,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12.0,
                          color: hexToColor('#007BEC'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#007BEC')),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          visualDensity: VisualDensity(horizontal: 2),
                        ),
                        onPressed: () => back(),
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18.0,
                              color: Colors.white),
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

//====================================================

//show error dialog
  static void signUpShowErrorsDialog({
    required String title,
    required List<dynamic> errorList,
    // required String inputValue,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#78909C'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Error!',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: errorList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${errorList[index]}',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#78909C')),
                          visualDensity: VisualDensity(horizontal: 2),
                        ),
                        onPressed: () {
                          back();
                        },
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//show error dialog
  static void signUpShowPinSendingDialog({
    required String title,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 13, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#78909C'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    '$title',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
    );
  }

//show error dialog
  static void signUpShowPasswordSetDialog({
    required String title,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hexToColor('#78909C'),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
                ),
                child: Text(
                  'Set Your Password',
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                child: Column(
                  children: [
                    // TimerCountDown(),
                    // OTPInput(),
                    // PasswordInput(),
                    // // ConfirmPasswordInput(),
                    // SignUpConfirmPasswordInput(),
                    // SizedBox(height: 10),
                    // SubmitNewPasswordButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//show error dialog
  static void signUpShowSuccessDialog({
    required String msg,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#78909C'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Success!',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        msg,
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#78909C')),
                          visualDensity: VisualDensity(horizontal: 2),
                        ),
                        onPressed: () {
                          back();
                          push(LoginPage());
                        },
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18.0,
                              color: Colors.white),
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

//show version dialog
  static void versionDialog({
    required String msg,
    required void Function()? onPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: hexToColor('#449EF1'),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    'App Version',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        msg,
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size?>(Size(109, 35)),
                          visualDensity: VisualDensity(horizontal: 2),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              hexToColor('#449EF1')),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18.0,
                              color: Colors.white),
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
  static void successDialog({
    required String title,
    required String msg,
    required Color color,
    String? path,
    required void Function()? onPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
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
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      KText(
                        text: msg,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size?>(Size(109, 35)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(color),
                          visualDensity: VisualDensity(horizontal: 2),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        onPressed: onPressed,
                        child: Text(
                          'Ok',
                          style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 18.0,
                              color: Colors.white),
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
  static void alertDialog({
    required String title,
    required String msg,
    required Color color,
    String? path,
    required void Function()? onPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              color: hexToColor('#FFFFFF'),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 12, bottom: 13),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
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
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      KText(
                        text: msg,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size?>(
                                  Size(109, 35)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  hexToColor('#FFA133')),
                              visualDensity: VisualDensity(horizontal: 2),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            onPressed: () => back(),
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size?>(
                                  Size(109, 35)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(color),
                              visualDensity: VisualDensity(horizontal: 2),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            onPressed: onPressed,
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                          ),
                        ],
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

  static void showScaffoldMessage({
    required BuildContext context,
    required String message,
    Color color = Colors.black87,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: duration,
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

// ========== Network topology page ==============

  static void showNetworkTopologyDetails({
    required ProjectSites x,
  }) {
    Get.bottomSheet(
      isScrollControlled: true,
      persistent: false,
      isDismissible: true,
      SizedBox(
        height: Get.height * .9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: hexToColor('#FFB661'),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: Center(
                    child: Column(
                  children: [
                    KText(
                      text: 'Project Site : ${x.siteCode}',
                      bold: true,
                      fontSize: 16,
                      //  maxLines: 2,
                    ),
                    KText(
                      text: 'Type -${x.pillarType}',
                      bold: true,
                      fontSize: 16,
                    ),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 80,
                  left: 10,
                  right: 10,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: 'Geography',
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text:
                          '${x.geoLevel2Name} > ${x.geoLevel3Name} > ${x.geoLevel4Name}',
                      maxLines: 2,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Pole Type',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text: x.pillarType != null ? x.pillarType : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Power Source',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text:
                                    x.powerSource != null ? x.powerSource : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Place Type',
                              color: hexToColor('#80939D'),
                            ),
                            KText(text: x.placeType != null ? x.placeType : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Place Name',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: x.siteName != null ? x.siteName : '',
                              maxLines: 2,
                            ),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                      ],
                    ),
                    KText(
                      text: 'Address',
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text:
                          '${x.geoLevel2Name}, ${x.geoLevel3Name}, ${x.geoLevel4Name} ',
                      maxLines: 2,
                    ),
                    Divider(),
                    KText(
                      text: 'Geography Point',
                      color: hexToColor('#80939D'),
                    ),
                    KText(text: 'Lat: ${x.latitude}'),
                    KText(text: 'Long: ${x.longitude}'),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Potential Beneficiaries',
                              color: hexToColor('#80939D'),
                            ),
                            KText(text: x.potentialBeneficiaryCount.toString()),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Priority',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text: x.priorityName != null
                                    ? x.priorityName
                                    : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Custodian Name',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                              text: x.custodianFullname != null
                                  ? x.custodianFullname
                                  : '',
                              maxLines: 2,
                            ),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Mobile No.',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text: x.custodianMobile != null
                                    ? x.custodianMobile
                                    : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'NID No.',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text: x.custodianNid != null
                                    ? x.custodianNid
                                    : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Email',
                              color: hexToColor('#80939D'),
                            ),
                            KText(
                                text: x.custodianEmail != null
                                    ? x.custodianEmail
                                    : ''),
                            SizedBox(width: Get.width * .4, child: Divider()),
                          ],
                        ),
                      ],
                    ),
                    KText(
                      text: 'Custodian Address',
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text:
                          x.custodianAddress != null ? x.custodianAddress : '',
                      maxLines: 2,
                    ),
                    Divider(),
                    KText(
                      text: 'Captured Images',
                      color: hexToColor('#80939D'),
                    ),
                    // Container(
                    //   color: Colors.amber,
                    //   padding: EdgeInsets.all(10),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       controller!.imagefiles.isEmpty
                    //           ? SizedBox()
                    //           : GridView.builder(
                    //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //                 crossAxisCount: 2,
                    //               ),
                    //               itemCount: controller.imagefiles.length,
                    //               primary: false,
                    //               shrinkWrap: true,
                    //               itemBuilder: (BuildContext context, int index) {
                    //                 final item = controller.imagefiles[index];
                    //                 return Stack(
                    //                   children: [
                    //                     Container(
                    //                       width: double.infinity,
                    //                       margin: EdgeInsets.all(5),
                    //                       decoration: BoxDecoration(
                    //                         borderRadius: BorderRadius.circular(5),
                    //                       ),
                    //                       child: ClipRRect(
                    //                         borderRadius: BorderRadius.circular(5),
                    //                         child: Image.file(
                    //                           File(item.path),
                    //                           fit: BoxFit.cover,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Positioned(
                    //                       top: 0,
                    //                       right: 0,
                    //                       left: 0,
                    //                       bottom: 0,
                    //                       child: InkWell(
                    //                         onTap: () {
                    //                           controller.imagefiles.removeAt(index);
                    //                         },
                    //                         child: Container(
                    //                           margin: EdgeInsets.all(60),
                    //                           decoration: BoxDecoration(
                    //                             borderRadius: BorderRadius.circular(50),
                    //                             color: Colors.white.withOpacity(0.5),
                    //                           ),
                    //                           child: Icon(
                    //                             Icons.delete,
                    //                             color: Colors.redAccent,
                    //                             size: 30,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     )
                    //                   ],
                    //                 );
                    //               },
                    //             ),
                    //     ],
                    //   ),
                    // ),
                    Center(
                      child: GestureDetector(
                        onTap: back,
                        child: Container(
                          height: 34,
                          width: 109,
                          margin: EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: hexToColor('#449EF1')),
                          child: Center(
                            child: KText(
                              text: 'Close',
                              bold: true,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== Network topology page ==============

  static void showNetworkTopologyDeviceInfo({
    required Appliances x,
  }) {
    Get.bottomSheet(
      isScrollControlled: true,
      persistent: false,
      isDismissible: true,
      SizedBox(
        height: Get.height * .9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: hexToColor('#FFB661'),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: Center(
                    child: KText(
                  text: 'Device Properties',
                  bold: true,
                  fontSize: 16,
                )),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 80,
                  left: 10,
                  right: 10,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Site ID',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.siteCode != null ? x.siteCode : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Site Name',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.siteName != null ? x.siteName : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Device Code',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.deviceCode != null ? x.deviceCode : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Device Type',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              x.deviceTypeName != null ? x.deviceTypeName : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'IP Address',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.deviceIp != null ? x.deviceIp : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'MAC Address',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.deviceMac != null ? x.deviceMac : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'OS',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.operatingSystem != null
                              ? x.operatingSystem
                              : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Model',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.deviceModel != null ? x.deviceModel : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Standard',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.technologyStandard != null
                              ? x.technologyStandard
                              : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Tag No',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: '',
                          // text: x. != null ? x.operatingSystem : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Capacity',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.connectionCapacity != null ? x.connectionCapacity : ''}',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Condition',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.deviceCondition != null
                              ? x.deviceCondition
                              : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Power Source',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.powerSource != null ? x.powerSource : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Divider(),
                    KText(
                      text: 'Address',
                      color: hexToColor('#80939D'),
                    ),
                    KText(
                      text: x.siteAddress != null ? x.siteAddress : '',
                      fontSize: 14,
                    ),
                    KText(
                      text: 'Geography Point',
                      color: hexToColor('#80939D'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Lat: ${x.latitude != null ? x.latitude : ''},',
                          fontSize: 14,
                        ),
                        KText(
                          text:
                              'Long: ${x.longitude != null ? x.longitude : ''}',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Installed',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.installedOn != null ? x.installedOn : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Vendor',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: '',
                          //  text: x. != null ? x.powerSource : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'On-Aired',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.onairDate != null ? x.onairDate : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Integration',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: x.integrationMethod != null
                              ? x.integrationMethod
                              : '',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Frequency-1',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.frequencyGhz != null ? x.frequencyGhz : ''} GHz',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Frequency-2',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.frequencyGhz2 != null ? x.frequencyGhz2 : ''} GHz',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Radius(M)',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.coverageRadiusMtr != null ? x.coverageRadiusMtr : ''}',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Height(ft)',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.equipmentHeightFt != null ? x.equipmentHeightFt : ''}',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Contact',
                          color: hexToColor('#80939D'),
                        ),
                        Row(
                          children: [
                            if (x.custodianFullname!.isNotEmpty)
                              CircleAvatar(
                                radius: 10,
                              ),
                            SizedBox(
                              width: 6,
                            ),
                            KText(
                              text:
                                  '${x.custodianFullname != null ? x.custodianFullname : ''}',
                              fontSize: 14,
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Mobile',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.custodianMobile != null ? x.custodianMobile : ''}',
                          fontSize: 14,
                          // bold: true,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(
                          text: 'Email',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text:
                              '${x.custodianEmail != null ? x.custodianEmail : ''}',
                          fontSize: 14,
                        )
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: back,
                        child: Container(
                          height: 34,
                          width: 109,
                          margin: EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: hexToColor('#449EF1')),
                          child: Center(
                            child: KText(
                              text: 'Close',
                              bold: true,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






//-----------------------------------------