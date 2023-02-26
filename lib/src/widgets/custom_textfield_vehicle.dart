import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

class CustomTextFieldVegicle extends StatelessWidget {
  CustomTextFieldVegicle({
    this.label,
    this.controller,
    this.title,
    this.suffix,
    this.redStar,
    this.hintText,
    this.isRequired = true,
    this.onChanged,
  });

  final String? label;
  final TextEditingController? controller;
  final String? title;
  final Widget? suffix;
  final String? redStar;
  final String? hintText;
  final Function(String?)? onChanged;

  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title!,
        //   style: TextStyle(fontSize: 16, color: Colors.black54),
        // ),
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
}
