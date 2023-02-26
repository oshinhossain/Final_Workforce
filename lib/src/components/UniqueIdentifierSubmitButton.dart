import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';

class UniqueIdentifierSubmitButton extends StatelessWidget with Base {
  final VoidCallback? onPressed;
  // final String inputValue;

  UniqueIdentifierSubmitButton({
    super.key,
    required this.onPressed,
    // required this.inputValue,
  });
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
                      authC.forgotPasswordInputField.value = '';
                      authC.forgotUsername.value = '';
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel ',
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
                    key: Key('unique_identifier_submit_button'),
                    style: ButtonStyle(
                      backgroundColor:
                          authC.forgotPasswordInputField.value.isNotEmpty ||
                                  authC.forgotUsername.value.isNotEmpty
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
                    onPressed:
                        authC.forgotPasswordInputField.value.isNotEmpty ||
                                authC.forgotUsername.value.isNotEmpty
                            ? onPressed
                            : null,
                    child: Text(
                      'Next',
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
