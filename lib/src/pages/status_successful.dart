import 'package:flutter/material.dart';
import 'package:workforce/src/pages/main_page.dart';

import '../config/app_theme.dart';
import '../helpers/k_text.dart';
import '../helpers/route.dart';

class SuccessFull extends StatelessWidget {
  SuccessFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: KText(
                text: 'Transport Order Completed', bold: true, fontSize: 16),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: InkWell(
              onTap: () {
                push(MainPage());
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                    child: KText(
                  text: 'Back to Home',
                  color: AppTheme.white,
                  bold: true,
                  fontSize: 15,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
