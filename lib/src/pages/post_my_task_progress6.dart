import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';
import '../widgets/title_bar.dart';

class PostMyTaskProgress6 extends StatelessWidget {
  final isChecked = RxBool(true);
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppTheme.searchColor;
    }

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBar(title: 'Post My Task Progress'),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: hexToColor('#EEF0F6'),
            ),
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            child: Row(
              children: [
                KText(
                  text: 'BTCLHaor-BaorProject',
                  fontSize: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RenderSvg(
                    path: 'icon_forward',
                    height: 18,
                    width: 18,
                  ),
                ),
                KText(
                  text: 'Pole',
                  fontSize: 13,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: RenderSvg(
                    path: 'icon_forward',
                    height: 18,
                    width: 18,
                  ),
                ),
                KText(
                  text: 'Pole Delivery',
                  fontSize: 13,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text:
                      'Guidance needed for pole delivery by truck from\n jessore to Tangail',
                  fontSize: 14,
                  color: AppTheme.oColor1,
                  bold: true,
                ),
                Divider(
                  thickness: 1,
                  color: hexToColor('#D9D9D9'),
                ),
                Row(
                  children: [
                    Container(
                      height: 25,
                      width: 90,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: hexToColor('#49CDAB'),
                      ),
                      child: Center(
                        child: KText(
                          text: 'Consulted',
                          color: hexToColor('#FFFFFF'),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Spacer(),
                    KText(
                      text: 'Date: :',
                      fontSize: 13,
                    ),
                    KText(
                      text: ' 05 Sep 2022',
                      fontSize: 13,
                      bold: true,
                    ),
                  ],
                ),
                Row(
                  children: [
                    KText(
                      text: 'OutPut Quantity',
                      fontSize: 13,
                      color: hexToColor('#80939D'),
                    ),
                    Spacer(),
                    KText(
                      text: 'Unit of Mesure',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        initialValue: '1',
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          labelStyle: TextStyle(color: hexToColor('#FF0000')),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: hexToColor('#DBECFB')),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    KText(
                      text: 'Advice',
                      color: hexToColor('#515D64'),
                      fontSize: 15,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: KText(
                    text: 'Remarks',
                    fontSize: 13,
                    color: hexToColor('#80939D'),
                  ),
                ),
                TextFormField(
                  //  initialValue: '1 advice give to Mr. Sazzad on truck selection',
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    labelStyle: TextStyle(color: hexToColor('#FF0000')),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: hexToColor('#DBECFB')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Evidence',
                            fontSize: 13,
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: 'Capture Photo',
                            fontSize: 14,
                            color: hexToColor('#B3B6C6'),
                          ),
                        ],
                      ),
                      Spacer(),
                      RenderSvg(
                        path: 'camera',
                        color: hexToColor('#80939D'),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: hexToColor('#449EF1'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog();
                              });
                        },
                        child: Image.asset(
                          '${Constants.imgPath}/truck.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog();
                              });
                        },
                        child: Image.asset(
                          '${Constants.imgPath}/truck.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog();
                              });
                        },
                        child: Image.asset(
                          '${Constants.imgPath}/truck.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Obx(
                          () => Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked.value,
                              onChanged: (_) {
                                isChecked.toggle();
                              }),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: KText(
                          text:
                              'Close Task (if checked, this task will disappear from the task list. however, from the reporting facility, it will be available.)',
                          fontSize: 14,
                          color: hexToColor('#515D64'),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: 34,
                    width: 116,
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: hexToColor('#449EF1')),
                    child: Center(
                      child: KText(
                        text: 'Save',
                        fontSize: 16,
                        color: Colors.white,
                        bold: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class SimpleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: SizedBox(
        height: 500,
        width: 400,
        // color: Colors.amber,
        child: Image.asset(
          '${Constants.imgPath}/truck.png',
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        Row(
          children: [
            Container(
              height: 34,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: hexToColor('#9BA9B3')),
              child: Center(
                child: KText(
                  text: 'Cancel',
                  fontSize: 16,
                  color: Colors.white,
                  bold: true,
                ),
              ),
            ),
            Spacer(),
            Container(
              height: 34,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: hexToColor('#FE0101')),
              child: Center(
                child: KText(
                  text: 'Delete',
                  fontSize: 16,
                  color: Colors.white,
                  bold: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
