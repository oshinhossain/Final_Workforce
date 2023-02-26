import 'package:flutter/material.dart';
import 'package:workforce/src/config/app_theme.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.key,
    this.label,
    this.controller,
    this.title,
    this.suffix,
    this.errorText,
    this.enable,
    this.keyboardType,
    this.border,
  }) : super(key: key);
  final String? label;
  final TextEditingController? controller;
  final String? title;
  final String? errorText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  @override
  // ignore: overridden_fields
  final Key? key;
  final bool? enable;
  final InputBorder? border;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                text: title!,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 13.0,
                  color: AppTheme.textfieldColor,
                  fontWeight: FontWeight.w400,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colorS2)),
                ],
              ),
            ),
            Spacer(),
            if (suffix != null)
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined,
                      color: AppTheme.searchColor)),
            if (suffix != null)
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.photo,
                    color: AppTheme.searchColor,
                  ))
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextField(
            enabled: enable,
            key: key,
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: AppTheme.focusColor,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 15.0,
              // color: textColor21,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
                border: border,
                errorText: errorText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.focusColor, width: 1),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: enable == false
                      ? BorderSide(color: Colors.red)
                      : BorderSide(color: AppTheme.enableColor, width: 1),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                suffixIcon: suffix,
                labelText: label),
          ),
        ),
      ],
    );
  }
}
