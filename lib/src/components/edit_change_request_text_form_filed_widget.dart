import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';

class CustomFieldWidget extends StatelessWidget {
  final ValueChanged onChanged;
  final String hinttext, title;

  CustomFieldWidget({
    Key? key,
    required this.onChanged,
    required this.hinttext,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: Get.width,
          child: KText(
            text: title,
            fontSize: 13,
            color: hexToColor('#80939D'),
          ),
        ),
        Container(
          width: Get.width,
          alignment: Alignment.centerLeft,
          child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: hinttext,
                hintStyle: TextStyle(
                    color: hexToColor('#515D64'),
                    overflow: TextOverflow.visible)),
          ),
        ),
        Divider(
          height: 5,
          thickness: 2,
        ),
      ],
    );
  }
}
