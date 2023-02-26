import 'package:flutter/material.dart';

import '../helpers/hex_color.dart';

// ignore: must_be_immutable
class CheckBox extends StatelessWidget {
  final double? height;
  final double? width;
  final bool value;
  final Color activeColor;
  final Color checkColor;
  void Function(bool?)? onChanged;
  CheckBox({
    this.height,
    this.width,
    this.activeColor = Colors.transparent,
    this.checkColor = Colors.blueAccent,
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
        child: Checkbox(
          checkColor: checkColor,
          activeColor: activeColor,
          value: value,
          onChanged: onChanged,
          side: MaterialStateBorderSide.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return BorderSide(color: Colors.red);
            } else {
              return BorderSide(color: hexToColor('#84BEF3'));
            }
          }),
        ),
      ),
    );
  }
}
