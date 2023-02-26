import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';

class NewPasswordSubmitButton extends StatelessWidget with Base {
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
                      authC.forgotPasswordInputField.value = '';
                      authC.forgotNewPassword.value = '';
                      authC.forgotConfirmPassword.value = '';

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // backgroundColor: MaterialStateProperty.all<Color>(
                      //     Colors.blueGrey.withOpacity(0.3)),
                      backgroundColor: authC.otp.value.isNotEmpty &&
                              authC.forgotConfirmPassword.value ==
                                  authC.forgotNewPassword.value
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
                    onPressed: () => authC.otp.value.isNotEmpty &&
                            authC.forgotConfirmPassword.value ==
                                authC.forgotNewPassword.value
                        ? authC.sendPasswordResetOTPByEmail()
                        : null,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}
