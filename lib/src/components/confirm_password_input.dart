import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';
import '../services/validation_service.dart';

class ConfirmPasswordInput extends StatelessWidget
    with Base, ValidationService {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextField(
        onChanged: authC.forgotConfirmPassword,
        obscureText: authC.isForgotConfirmObscure.value,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Confirm Password',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: hexToColor('#80939D'),
                  ),
                ),
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: hexToColor('#F2BA14'),
                  ),
                ),
              ],
            ),
          ),
          errorMaxLines: 4,
          filled: false,
          hintText: '********',
          border: UnderlineInputBorder(),
          hintStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            // color: AppTheme.textColor3,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(
              authC.isForgotConfirmObscure.value
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: hexToColor('#80939D'),
            ),
            onPressed: () {
              authC.isForgotConfirmObscure.toggle();
            },
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hexToColor('#80939D'), width: 1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hexToColor('#F2BA14'), width: 1.0),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hexToColor('#FE0101'), width: 1.0),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: hexToColor('#FE0101'), width: 1.0),
          ),
          errorText: validateResetConfirmPassword(
            authC.forgotNewPassword.value,
            authC.forgotConfirmPassword.value,
          ),
        ),
      ),
    );
  }
}
