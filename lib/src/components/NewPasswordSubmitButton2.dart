import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';

class NewPasswordSubmitButton2 extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: authC.isForgotLoading.value
            ? [
                CircularProgressIndicator(strokeWidth: 3),
              ]
            : [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133')),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      authC.otp.value = '';
                      authC.forgotUsername.value = '';
                      Navigator.of(context).pop();
                    },
                    child: KText(
                      text: 'Cancel',
                      fontSize: 16.0,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: authC.otp.value.isNotEmpty
                          ? MaterialStateProperty.all<Color>(
                              hexToColor('#007BEC'))
                          : MaterialStateProperty.all<Color>(
                              hexToColor('#007BEC').withOpacity(0.3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () => authC.otp.value.isNotEmpty
                        ? authC.sendOtpByEmail()
                        : null,
                    child: KText(
                      text: 'Submit',
                      fontSize: 16.0,
                      color: Colors.white,
                      bold: true,
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}
