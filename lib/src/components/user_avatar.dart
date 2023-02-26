import 'package:flutter/material.dart';
import 'package:workforce/src/helpers/render_svg.dart';

class UserAvatar extends StatelessWidget {
  final String? path;
  final double? height;
  final double? width;
  UserAvatar({this.path, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height : 38,
      width: width != null ? width : 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: RenderSvg(
              path: 'avatar_placeholder',
            )),
      ),
    );
  }
}
