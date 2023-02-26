import 'package:flutter/material.dart';

import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/main_page.dart';

class TitleBar extends StatelessWidget {
  final title;

  TitleBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 10, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () => {offAll(MainPage())},
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                back();
              },
            ),
          ),
          SizedBox(
            width: 20,
          ),
          KText(
            text: '$title',
            bold: true,
            color: AppTheme.textColor,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}

class CenterTitleBar extends StatelessWidget {
  final title;
  final double percentange;
  CenterTitleBar({
    required this.title,
    this.percentange = 0.02,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, right: 10, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              back();
            },
          ),
          SizedBox(
            width: 60,
            //    width: Get.width * percentange,
          ),
          KText(
            text: '$title',
            bold: true,
            color: AppTheme.textColor,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
