import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../config/app_theme.dart';

class CustomTextFieldProjectdashboard extends StatelessWidget {
  final key1 = GlobalKey<State<Tooltip>>();
  CustomTextFieldProjectdashboard({
    this.label,
    this.controller,
    this.title,
    this.suffix,
    this.redStar,
    this.hintText,
    this.isRequired = true,
    this.onChanged,
    this.isTooltipRequired,
  });

  final String? label;
  final TextEditingController? controller;
  final String? title;
  final Widget? suffix;
  final String? redStar;
  final String? hintText;
  final Function(String?)? onChanged;

  final bool? isRequired;
  final bool? isTooltipRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            KText(
              text: title,
              fontSize: 13,
              color: hexToColor('#80939D'),
            ),
            if (isRequired!)
              KText(
                text: '*',
                color: Colors.redAccent,
              ),
            if (isTooltipRequired!) kTooltip(key1),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextFormField(
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.digitsOnly
            // ],
            onChanged: onChanged,
            controller: controller,
            cursorColor: Color(0xFF90A4AE),
            decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: suffix,
                constraints: BoxConstraints(maxHeight: 40),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF90A4AE),
                  ),
                ),
                // focusColor: hexToColor('#84BEF3'),
                focusColor: Colors.red,
                labelStyle: TextStyle(color: Color(0xFF424242)),
                labelText: label),
          ),
        ),
      ],
    );
  }

  Widget kTooltip(GlobalKey key) {
    return Tooltip(
      key: key1,
      triggerMode: TooltipTriggerMode.tap,
      message:
          'For multi-agency, approval will\n be neede from the biz parth     \nMulti-agency project is an \n major revenue earn',
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.appbarColor,
      ),
      padding: EdgeInsets.all(12),
      textStyle: TextStyle(
        fontFamily: 'Manrope Regular',
        color: AppTheme.textColor,
      ),
      child: IconButton(
        onPressed: () {
          final dynamic tooltip = key.currentState!;
          tooltip?.ensureTooltipVisible();
        },
        icon: Icon(Icons.info_outline),
        color: Colors.grey,
      ),
    );
  }
}
