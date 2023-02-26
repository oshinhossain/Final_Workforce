import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

class SerchReceivingPartyComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Container(
            width: Get.width,
            height: 75,
            //color: Colors.green,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border(
                left: BorderSide(
                  color: hexToColor('#DBECFB'),
                  width: 1.5,
                ),
                right: BorderSide(
                  color: hexToColor('#DBECFB'),
                  width: 1.5,
                ),
                top: BorderSide(
                  color: hexToColor('#DBECFB'),
                  width: 1.5,
                ),
                bottom: BorderSide(
                  color: hexToColor('#DBECFB'),
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 2,
                    left: 10,
                  ),
                  child: Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F5FA),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Color.fromARGB(255, 230, 230, 233),
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffF5F5FA).withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            '${Constants.imgPath}/bill.jpg',
                            width: 37,
                            height: 37,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Jafor Uddin Ahmed',
                        fontSize: 15,
                        color: hexToColor('#141C44'),
                        bold: true,
                      ),
                      KText(
                        text: 'aforahmed@gmail.com',
                        fontSize: 12,
                        color: hexToColor('#72778F'),
                      ),
                      KText(
                        text: '+8801856624090',
                        fontSize: 12,
                        color: hexToColor('#72778F'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
