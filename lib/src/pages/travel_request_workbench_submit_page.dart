import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';

import '../components/check_box.dart';
import '../config/base.dart';

class TravelRequestWorkbenchSubmitPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Container(),
        ],
        flexibleSpace: KAppbar(),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[2],
              //  boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 5.0, offset: Offset(0.0, 0.55))],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: hexToColor('#9BA9B3'),
                  ),
                ),
                Center(
                  child: KText(
                    text: 'Travel Request',
                    bold: true,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Ref. No.',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: '(Auto)',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Date',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: formatDate(date: DateTime.now().toString()),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(color: hexToColor('#EBEBEC')),
                KText(
                  text: 'Travel Type',
                  color: hexToColor('#80939D'),
                ),
                KText(text: 'By Air'),
                SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: hexToColor('#EEF0F6'),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Date',
                                color: hexToColor('#80939D'),
                              ),
                              KText(text: '15 Dec 2022'),
                            ],
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Location name',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: 'BMTF Factory, Gazipur',
                            maxLines: 2,
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Latitude ',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '45.4097467'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Longitude',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '33.9260617'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Description',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text:
                                'Lorem ipsum dolor sit amet, consect etur adi piscing elit, sed do eiusmod tempor inc.',
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: Get.width / 5.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: KText(
                          text: 'Source',
                          fontSize: 12,
                          color: hexToColor('#80939D'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: hexToColor('#EEF0F6'),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Date',
                                color: hexToColor('#80939D'),
                              ),
                              KText(text: '15 Dec 2022'),
                            ],
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Location name',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: 'BMTF Factory, Gazipur',
                            maxLines: 2,
                          ),
                          SizedBox(height: 8),
                          KText(
                            text: 'Latitude ',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '45.4097467'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Longitude',
                            color: hexToColor('#80939D'),
                          ),
                          KText(text: '33.9260617'),
                          SizedBox(height: 8),
                          KText(
                            text: 'Description',
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text:
                                'Lorem ipsum dolor sit amet, consect etur adi piscing elit, sed do eiusmod tempor inc.',
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: -12,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        width: Get.width / 4.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: KText(
                          text: 'Destination',
                          fontSize: 12,
                          color: hexToColor('#80939D'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: true,
                      activeColor: hexToColor('#84BEF3'),
                      checkColor: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is transport support needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: false,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is accommodation support needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                KText(
                  text: 'Estimated Cost (BDT)',
                  color: hexToColor('#80939D'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    CheckBox(
                      onChanged: (bool? v) {},
                      value: true,
                      activeColor: hexToColor('#84BEF3'),
                      checkColor: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    KText(
                      text: 'Is advance cash needed?',
                      color: hexToColor('#80939D'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                KText(
                  text: 'Advance Amount (BDT)',
                  color: hexToColor('#80939D'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: hexToColor('#EBEBEC'),
                        width: .5,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(height: 20),
                KText(
                  text: 'Attachments',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      travelRWC.imagefiles.isEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                              ),
                              itemCount: 2,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return DottedBorder(
                                  color: hexToColor('#FFE1BF'),
                                  strokeWidth: 2,
                                  dashPattern: [4, 4],
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(5),
                                  child: Container(
                                    // height: 130,
                                    width: double.infinity,
                                    color: hexToColor('#FFFBF7'),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () =>
                                            travelRWC.pickMultiImage(),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ),
                                    ),

                                    //background color of inner container
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: travelRWC.imagefiles.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final item = travelRWC.imagefiles[index];
                                return Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          File(item.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Global.confirmDialog(
                                            onConfirmed: () {
                                              travelRWC.imagefiles
                                                  .removeAt(index);
                                              back();
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(60),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133'),
                        ),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        back();
                      },
                      child: KText(
                        text: 'Cancel',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                    // Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            // hexToColor('#007BEC'),
                            hexToColor('#007BEC')),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        push(TravelRequestWorkbenchSubmitPage());
                      },
                      child: KText(
                        text: 'Save',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
