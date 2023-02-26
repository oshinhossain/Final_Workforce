import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/route.dart';
import '../config/app_theme.dart';
import '../config/constants.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/render_svg.dart';

class ProjectdashboardcreateMaterialstransportOrderpage extends StatefulWidget {
  @override
  State<ProjectdashboardcreateMaterialstransportOrderpage> createState() =>
      _ProjectdashboardcreateMaterialstransportOrderpageState();
}

class _ProjectdashboardcreateMaterialstransportOrderpageState
    extends State<ProjectdashboardcreateMaterialstransportOrderpage> with Base {
  @override
  Widget build(BuildContext context) {
    //  projectDashboardCreateController.getprojectname();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: hexToColor('#9BA9B3'),
            )),
        title: Padding(
          padding: const EdgeInsets.only(right: 150),
          child: KText(
            text: 'MR # A22100501',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      RenderSvg(
                        path: 'trucklogo',
                        height: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      KText(
                        text: 'Transport Requests',
                        fontSize: 18,
                        bold: true,
                      ),
                      Spacer(),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: hexToColor('#FFECD6')),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: KText(
                            text: '03',
                            fontSize: 18,
                            bold: true,
                            color: hexToColor('#FFA133'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DottedLine(dashLength: 0.5),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#E1FFF7'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#C0F9EA'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#49CDAB'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Approved ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                      //     CustomTextFieldVegicle(
                      //       title: "Passport Exp Date",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  Container(
                    height: 780,
                    margin: EdgeInsets.only(top: 12),
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border:
                            Border.all(color: hexToColor('#DBECFB'), width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Transport Order ',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),

                                  KText(
                                    text: 'S2SD83SD8 ',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#515D64'),
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  // Icon(
                                  //   uiC.isExpanded.value
                                  //       ? EvaIcons.arrowIosUpwardOutline
                                  //       : EvaIcons.arrowIosDownwardOutline,
                                  //   color: hexToColor('#80939D'),
                                  // ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: KText(
                                      text: 'Date ',
                                      bold: true,
                                      fontSize: 13,
                                      color: hexToColor('#80939D'),
                                    ),
                                  ),

                                  KText(
                                    text: '01 Sep 2022',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#515D64'),
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  // Icon(
                                  //   uiC.isExpanded.value
                                  //       ? EvaIcons.arrowIosUpwardOutline
                                  //       : EvaIcons.arrowIosDownwardOutline,
                                  //   color: hexToColor('#80939D'),
                                  // ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 50, top: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: hexToColor('#DBECFB'),
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  KText(
                                    text: 'Transport Orderer',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                  Spacer(),
                                  KText(
                                    text: 'Arif Hossain',
                                    bold: true,
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                  Container(
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
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: hexToColor('#DBECFB'),
                          thickness: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: 'Transport Agency',
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                              KText(
                                text: 'Delta Traport Solution ',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              KText(
                                text: 'Receiving Party ',
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                              KText(
                                text: 'Jessore Trade Agency',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              KText(
                                text: 'Source Location (Loading point) ',
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                              KText(
                                text: 'BMTF Factory, Gazipur ',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              KText(
                                text: 'Destination Location (Unloading Point) ',
                                fontSize: 13,
                                color: hexToColor('#80939D'),
                              ),
                              KText(
                                text: 'Jessore Sadar, Jessore',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_box_outline_blank_sharp,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  KText(
                                    text: 'Single Receiving Person',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Jafor Uddin Ahmed',
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_box_outline_blank_sharp,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  KText(
                                    text:
                                        'Single Goods Inspector at the Drop Location',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Jafor Uddin Ahmed',
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  KText(
                                    text:
                                        'Goods Inspector at the Loading Point',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  KText(
                                    text: 'Tamal Sarkar',
                                    fontSize: 14,
                                    color: hexToColor('#515D64'),
                                  ),
                                ],
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_box_outline_blank_sharp,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  KText(
                                    text: 'Single Drop Location',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                              KText(
                                text: '(Destination Location Only)',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_box_outline_blank_sharp,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  KText(
                                    text: 'Prescribe Travel Path',
                                    fontSize: 13,
                                    color: hexToColor('#80939D'),
                                  ),
                                ],
                              ),
                              KText(
                                text: 'BMTF Factory --> Jessore Sadar',
                                fontSize: 14,
                                color: hexToColor('#515D64'),
                              ),
                              Divider(
                                color: hexToColor('#80939D'),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2, right: 6, top: 20, bottom: 6),
                        child: Container(
                          height: 70,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: hexToColor('#FFD1D1'),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: hexToColor('#C0F9EA'))),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Transport Order',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: 'S2SD82SD8',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Date',
                                            fontSize: 13,
                                            color: AppTheme.appTextColor1,
                                          ),
                                          KText(
                                            text: '01 Sep 2022',
                                            fontSize: 15,
                                            bold: true,
                                            color: AppTheme.appTextColor1,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 20,
                        top: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: hexToColor('#FF9191'),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 3,
                              bottom: 3,
                            ),
                            child: KText(
                              text: 'Rejected ',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       height: 20,
                      //     ),
                      //     CustomTextFieldVegicle(
                      //       title: "Passport Exp Date",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      // SafeArea(

      // // ),
    );
  }

  Widget searchField({
    required String title,
    required String placeholder,
    void Function()? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              KText(
                text: title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: onTap,
                // child: SvgPicture.asset(
                //   '${Constants.svgPath}/icon_search_elements.svg',
                //   color: hexToColor('#66A1D9'),
                //   width: 20,
                // ),
                child: RenderSvg(
                  path: 'icon_search_elements',
                  width: 26,
                  color: hexToColor('#66A1D9'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          KText(
            text: placeholder,
            fontSize: 15,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  void itemSelectionChanged(String? s) {
    print(s);
  }
}
