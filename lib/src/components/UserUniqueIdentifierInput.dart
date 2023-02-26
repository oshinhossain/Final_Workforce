import 'package:flutter/material.dart';

import '../config/base.dart';
import '../helpers/hex_color.dart';

class UserUniqueIdentifierInput extends StatelessWidget with Base {
  final String inputLabel;
  final Function onChanged;

  UserUniqueIdentifierInput({
    super.key,
    required this.inputLabel,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged as Function(String?),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(
          inputLabel,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: hexToColor('#80939D'),
          ),
        ),

        hintText: 'Ex: abc',
        border: OutlineInputBorder(),
        hintStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 14.0,
          color: hexToColor('#80939D'),
          fontWeight: FontWeight.w400,
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
        //labelText: 'Username',
        // errorText: 'Invalid Email/Username',
      ),
    );
  }
}
