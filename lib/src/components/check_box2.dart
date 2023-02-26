import 'package:flutter/material.dart';

import '../helpers/hex_color.dart';

// ignore: must_be_immutable
class CheckBox2 extends StatelessWidget {
  final double? height;
  final double? width;
  final bool value;
  void Function(bool?)? onChanged;
  CheckBox2({
    this.height,
    this.width,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null ? height : 20,
      width: width != null ? width : 20,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Radio(
          onChanged: onChanged,
          fillColor: MaterialStateProperty.all<Color?>(hexToColor('#84BEF3')),
          groupValue: value,
          value: value,
        ),
        // child: Checkbox(
        //   checkColor: hexToColor('#84BEF3'),
        //   activeColor: Colors.transparent,
        //   value: value,
        //   onChanged: onChanged,
        //   side: MaterialStateBorderSide.resolveWith((states) {
        //     if (states.contains(MaterialState.pressed)) {
        //       return BorderSide(color: Colors.red);
        //     } else {
        //       return BorderSide(color: hexToColor('#84BEF3'));
        //     }
        //   }),
        // ),
      ),
    );
  }
}
