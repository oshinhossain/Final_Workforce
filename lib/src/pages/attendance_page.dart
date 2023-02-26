import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/get_hepler.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/known_office_location_model.dart';
import 'package:workforce/src/pages/search_agency_office_location_by_username.dart';
import '../helpers/loading.dart';
import '../hive_models/attendance.dart';
import '../models/office_location_model.dart';
import 'search_known_location.dart';

class AttendancePage extends StatefulWidget {
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> with Base {
  int _selectedIndex = 0;
  late Box<Attendance> attendanceBox;
  late Box<OfficeLocationModel> officeLocBox;
  late Box<KnownOfficeLocationModel> knownofficeLocBox;
  late Box<String> otherLocationBox;
  late Box<int> locationTypeBox;
  // ignore: prefer_final_fields
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    attendanceC.getAttendaneHistory();
    attendanceBox = Hive.box<Attendance>('attendance');
    officeLocBox = Hive.box<OfficeLocationModel>('office');
    knownofficeLocBox = Hive.box<KnownOfficeLocationModel>('known');
    otherLocationBox = Hive.box<String>('others');
    locationTypeBox = Hive.box<int>('location_type');
    attendanceC.controllerDestino.clear();
    attendanceC.location.value = '';

    if (locationTypeBox.containsKey(agencyC.selectedAgency!.agencyName)) {
      final locationtype =
          locationTypeBox.get(agencyC.selectedAgency!.agencyName);
      switch (locationtype) {
        case 1:
          attendanceC.locationType.value = LocationType.office;
          if (officeLocBox.containsKey(agencyC.selectedAgency!.agencyName)) {
            final loc = officeLocBox.get(agencyC.selectedAgency!.agencyName);
            attendanceC.selectedOfficeLocation.value = loc;
            attendanceC.controllerDestino.text =
                attendanceC.selectedOfficeLocation.value!.locationName!;
            attendanceC.location.value =
                attendanceC.selectedOfficeLocation.value!.locationName!;
            attendanceC.selectedKnownLocation.value = null;
          }
          break;
        case 2:
          attendanceC.locationType.value = LocationType.known;
          attendanceC.selectedOfficeLocation.value = null;
          attendanceC.location.value = '';
          if (knownofficeLocBox
              .containsKey(agencyC.selectedAgency!.agencyName)) {
            final loc =
                knownofficeLocBox.get(agencyC.selectedAgency!.agencyName);
            attendanceC.selectedKnownLocation.value = loc;
            attendanceC.controllerDestino.text =
                attendanceC.selectedKnownLocation.value!.locationName!;
            attendanceC.location.value =
                attendanceC.selectedKnownLocation.value!.locationName!;
          }
          // attendanceC.selectedKnownLocation.value = null;
          // attendanceC.selectedOfficeLocation.value = null;
          attendanceC.othersLocation.value = '';
          break;
        case 3:
          attendanceC.locationType.value = LocationType.others;
          attendanceC.controllerDestino.clear();
          if (otherLocationBox
              .containsKey(agencyC.selectedAgency!.agencyName)) {
            final loc =
                otherLocationBox.get(agencyC.selectedAgency!.agencyName);

            attendanceC.controllerDestino.text = loc!;
            attendanceC.location.value = loc;
            attendanceC.othersLocation.value = loc;
          }
          attendanceC.selectedKnownLocation.value = null;
          attendanceC.selectedOfficeLocation.value = null;
          attendanceC.othersLocation.value = '';

          break;
        default:
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    attendanceC.getOfficeLoc();
    attendanceC.getKnownLocation();
    attendanceC.getWeeklyShiftPlan();
    // attendanceC.getAttendaneHistory();

    return OrientationBuilder(builder: (context, orientation) {
      return DefaultTabController(
        length: 2,
        child: WillPopScope(
          onWillPop: () async {
            if (attendanceC.othersLocation.value != '') {
              await otherLocationBox.put(agencyC.selectedAgency!.agencyName,
                  attendanceC.controllerDestino.text);
            }
            return Future(
              () => true,
            );
          },
          child: Scaffold(
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () async {
            //     await attendanceC.getTimefromapi();
            //     //DateTime time = await FlutterNativeTime.getHardwareTime();

            //   //  print(time);
            //   },
            // ),

            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () async {
                    if (attendanceC.othersLocation.value != '') {
                      await otherLocationBox.put(
                          agencyC.selectedAgency!.agencyName,
                          attendanceC.controllerDestino.text);
                    }
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back)),
              backgroundColor: AppTheme.appbarColor,
              iconTheme: IconThemeData(
                color: AppTheme.textColor,
              ),
              centerTitle: true,
              elevation: 0,
              //title: appBarTitle(title: widget.title),
              title: Text(
                'My Attendance',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Material(
                  color: AppTheme.appbarColor, // #78909C
                  child: Container(
                    height: 44.75,
                    padding: EdgeInsets.only(
                        left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
                    child: Container(
                      //color: Colors.white.withOpacity(0.5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                      ),
                      child: TabBar(
                        labelColor: AppTheme.white,
                        unselectedLabelColor: AppTheme.textColor,
                        labelStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14.0,
                            color: AppTheme.newAppBarTextColor,
                            fontWeight: FontWeight.w700),
                        indicator: BoxDecoration(
                          borderRadius: _selectedIndex == 0
                              ? BorderRadius.only(topLeft: Radius.circular(5.0))
                              : _selectedIndex == 1
                                  ? BorderRadius.only(
                                      topRight: Radius.circular(5.0),
                                    )
                                  : null,
                          color: hexToColor('#78909C'),
                        ),
                        indicatorWeight: 1,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,

                        //unselectedLabelColor: Colors.blue,
                        unselectedLabelStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14.0,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w700),
                        isScrollable: false,
                        physics: BouncingScrollPhysics(),
                        tabs: [
                          Tab(
                            text: 'Basic',
                          ),
                          Tab(
                            text: 'My Shift Plan',
                          ),
                        ],
                        onTap: (tabIndex) {
                          setState(() {
                            _selectedIndex = tabIndex;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: [
                  basicTab(),
                  shiftPlan(),
                ],
              ),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     attendanceC.clear();
            //   },
            //   child: Icon(Icons.close),
            // ),
            //bottomNavigationBar: (orientation == Orientation.portrait) ? _BottomNavigationSheet() : null,
          ),
        ),
      );
    });
  }

  Widget basicTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 19.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 12,
          ),
          ValueListenableBuilder(
            valueListenable: attendanceC.attendanceBox.listenable(keys: [0]),
            builder: (context, box, widget) {
              return box.isEmpty ? emptyAtt() : existAtt(box);

              // build widget
            },
          ),
        ],
      ),
    );
  }

  Widget emptyAtt() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: KText(
                  text: attendanceC.currentDate,
                  bold: true,
                  fontSize: 16,
                  color: AppTheme.textColor,
                ),
              ),
              ImageIcon(
                AssetImage('assets/icons/late_icon.png'),
                color: AppTheme.appFooterColor,
                size: 22.0,
              )
            ],
          ),
          SizedBox(height: 5.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location Type: ',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13.0,
                      color: AppTheme.appTextColor1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.office,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                await locationTypeBox.put(
                                    agencyC.selectedAgency!.agencyName, 1);
                                attendanceC.controllerDestino.clear();
                                attendanceC.selectedKnownLocation.value = null;
                                attendanceC.location.value = '';
                                if (officeLocBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = officeLocBox
                                      .get(agencyC.selectedAgency!.agencyName);
                                  attendanceC.selectedOfficeLocation.value =
                                      loc;
                                  attendanceC.controllerDestino.text =
                                      attendanceC.selectedOfficeLocation.value!
                                          .locationName!;
                                  attendanceC.location.value = attendanceC
                                      .selectedOfficeLocation
                                      .value!
                                      .locationName!;
                                }

                                attendanceC.othersLocation.value = '';
                                attendanceC.locationType.value = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Office',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.known,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                await locationTypeBox.put(
                                    agencyC.selectedAgency!.agencyName, 2);
                                attendanceC.controllerDestino.clear();

                                attendanceC.selectedOfficeLocation.value = null;
                                attendanceC.location.value = '';
                                if (knownofficeLocBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = knownofficeLocBox
                                      .get(agencyC.selectedAgency!.agencyName);
                                  attendanceC.selectedKnownLocation.value = loc;
                                  attendanceC.controllerDestino.text =
                                      attendanceC.selectedKnownLocation.value!
                                          .locationName!;
                                  attendanceC.location.value = attendanceC
                                      .selectedKnownLocation
                                      .value!
                                      .locationName!;
                                }
                                // attendanceC.selectedKnownLocation.value = null;
                                // attendanceC.selectedOfficeLocation.value = null;
                                attendanceC.othersLocation.value = '';
                                attendanceC.locationType.value = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Known',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.others,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                attendanceC.controllerDestino.clear();
                                if (otherLocationBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = otherLocationBox
                                      .get(agencyC.selectedAgency!.agencyName);

                                  attendanceC.controllerDestino.text = loc!;
                                  attendanceC.location.value = loc;
                                  attendanceC.othersLocation.value = loc;
                                }
                                attendanceC.selectedKnownLocation.value = null;
                                attendanceC.selectedOfficeLocation.value = null;

                                attendanceC.locationType.value = value!;

                                // kLog(
                                // 'location value ${attendanceC.location.value}');
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Others',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: AppTheme.primaryColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      onChanged: (value) {   attendanceC.location.value = value;
                            attendanceC.othersLocation.value = value;
                      },
                      controller: attendanceC.controllerDestino,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15.0,
                          color: AppTheme.appTextColor2,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: attendanceC.locationType.value !=
                                LocationType.others
                            ? 'Select Your location'
                            : 'Write Your location',
                        suffixIcon: Visibility(
                          visible: attendanceC.locationType.value !=
                              LocationType.others,
                          child: GestureDetector(
                            onTap: () async {
                              if (attendanceC.locationType.value ==
                                  LocationType.office) {
                                push(
                                  SearchAgencyOfficeLocation(
                                      title: 'Office Location Search',
                                      uiCodes: 411001),
                                );
                              } else if (attendanceC.locationType.value ==
                                  LocationType.known) {
                                push(
                                  SearchKnownLocation(
                                      title: 'Known Location Search',
                                      uiCodes: 411001),
                                );
                              }
                            },
                            child: Icon(
                              Icons.search,
                              color: AppTheme.appTextColor2,
                            ),
                          ),
                        ),
                        labelStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13.0,
                            color: AppTheme.appTextColor1,
                            fontWeight: FontWeight.w400),
                        floatingLabelStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13.0,
                            color: AppTheme.appTextColor1,
                            fontWeight: FontWeight.w400),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppTheme.focusedLineColor, width: 1.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.enabledLineColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _textEditingController,
                onChanged: (value) {
                  attendanceC.remarks.value = value;
                },
                maxLines: 3,
                minLines: 2,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                // inputFormatters: [FilteringTextInputFormatter.deny(RegExp("['\"]"))],
                key: Key('employee_attendance_remarks_textField'),
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  hintText: 'Write remarks here',
                  labelStyle: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13.0,
                      color: AppTheme.appTextColor1,
                      fontWeight: FontWeight.w400),
                  floatingLabelStyle: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13.0,
                      color: AppTheme.appTextColor1,
                      fontWeight: FontWeight.w400),
                  //border: OutlineInputBorder(),
                  //alignLabelWithHint: true,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: AppTheme.focusedLineColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    //borderSide: BorderSide(color: textColor22),
                    borderSide: BorderSide(color: AppTheme.enabledLineColor),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15.0,
                  color: AppTheme.appTextColor2,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: KText(
                      text: 'Effective Working Hours :',
                      fontSize: 16,
                      color: AppTheme.newAppBarTextColor,
                    ),
                  ),
                  //SizedBox(width: 10.0),
                  //Spacer(),

                  Expanded(
                    //child: Text('00:00:00', style: TextStyle(fontSize: 17.0), overflow: TextOverflow.clip),
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: attendanceC.stopWatchTimer != null
                                ? StreamBuilder<int>(
                                    stream: attendanceC
                                        .stopWatchTimer.value.rawTime,
                                    builder: (context, snap) {
                                      if (!snap.hasData) {
                                        Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: attendanceC
                                                            .stopWatchTimer
                                                            .value
                                                            .isRunning
                                                        ? hexToColor('#F2BA14')
                                                        : hexToColor('#78909C'),
                                                  ),
                                                  child: KText(
                                                    text: '00',
                                                    bold: true,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                KText(
                                                  text: ' : ',
                                                  fontSize: 18,
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                  bold: true,
                                                ),
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: attendanceC
                                                            .stopWatchTimer
                                                            .value
                                                            .isRunning
                                                        ? hexToColor('#F2BA14')
                                                        : hexToColor('#78909C'),
                                                  ),
                                                  child: KText(
                                                    text: '00',
                                                    bold: true,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                KText(
                                                  text: ' : ',
                                                  fontSize: 18,
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                  bold: true,
                                                ),
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: attendanceC
                                                            .stopWatchTimer
                                                            .value
                                                            .isRunning
                                                        ? hexToColor('#F2BA14')
                                                        : hexToColor('#78909C'),
                                                  ),
                                                  child: KText(
                                                    text: '00',
                                                    bold: true,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                      final value = snap.data;

                                      final displayTime = value != null
                                          ? StopWatchTimer.getDisplayTime(
                                              value,
                                              milliSecond: false,
                                            )
                                          : '00:00:00';

                                      final rawTime = displayTime.split(':');
                                      final hour = rawTime[0];
                                      final min = rawTime[1];
                                      final sec = rawTime[2];
                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: hexToColor('#F2BA14'),
                                                ),
                                                child: KText(
                                                  text: hour,
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              KText(
                                                text: ' : ',
                                                fontSize: 18,
                                                color: attendanceC
                                                        .stopWatchTimer
                                                        .value
                                                        .isRunning
                                                    ? hexToColor('#F2BA14')
                                                    : hexToColor('#78909C'),
                                                bold: true,
                                              ),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                ),
                                                child: KText(
                                                  text: min,
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              KText(
                                                text: ' : ',
                                                fontSize: 18,
                                                color: attendanceC
                                                        .stopWatchTimer
                                                        .value
                                                        .isRunning
                                                    ? hexToColor('#F2BA14')
                                                    : hexToColor('#78909C'),
                                                bold: true,
                                              ),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                ),
                                                child: KText(
                                                  text: sec,
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            height: 30.0,
                                            width: 30.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: attendanceC.stopWatchTimer
                                                      .value.isRunning
                                                  ? hexToColor('#F2BA14')
                                                  : hexToColor('#78909C'),
                                            ),
                                            child: KText(
                                              text: '00',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          KText(
                                            text: ' : ',
                                            fontSize: 18,
                                            color: AppTheme.textColor,
                                            bold: true,
                                          ),
                                          Container(
                                            height: 30.0,
                                            width: 30.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: attendanceC.stopWatchTimer
                                                      .value.isRunning
                                                  ? hexToColor('#F2BA14')
                                                  : hexToColor('#78909C'),
                                            ),
                                            child: KText(
                                              text: '00',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          KText(
                                            text: ' : ',
                                            fontSize: 18,
                                            color: attendanceC.stopWatchTimer
                                                    .value.isRunning
                                                ? hexToColor('#F2BA14')
                                                : hexToColor('#78909C'),
                                            bold: true,
                                          ),
                                          Container(
                                            height: 30.0,
                                            width: 30.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: attendanceC.stopWatchTimer
                                                      .value.isRunning
                                                  ? hexToColor('#F2BA14')
                                                  : hexToColor('#78909C'),
                                            ),
                                            child: KText(
                                              text: '00',
                                              bold: true,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22,
              ),
              SizedBox(
                width: Get.width,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(hexToColor('#78909C')),

                    //visualDensity: VisualDensity(vertical: 4),
                  ),
                  onPressed: () async {
                    if (attendanceC.othersLocation.value != '') {
                      await otherLocationBox.put(
                          agencyC.selectedAgency!.agencyName,
                          attendanceC.controllerDestino.text);
                    }
                    await locationC.getattendanceCurrentLocation();
                    // kLog('khela kobe hbe 3 ${attendanceC.location.value}');
                    if (attendanceC.locationType.value != LocationType.others) {
                      if (attendanceC.location.value != '') {
                        attendanceC.attendanceIN();
                        _textEditingController.clear();
                        attendanceC.remarks.value = '';
                      } else {
                        GetHelper.snackBar(
                            text: 'Location Not Selected',
                            status: Status.error);
                      }
                    } else {
                      if (attendanceC.othersLocation.value != '') {
                        if (attendanceC.getDistance(
                              attendanceC.selectedKnownLocation.value != null
                                  ? LatLng(
                                      attendanceC.selectedKnownLocation.value!
                                          .latitude!,
                                      attendanceC.selectedKnownLocation.value!
                                          .longitude!)
                                  : LatLng(
                                      attendanceC.selectedOfficeLocation.value!
                                          .officeLatitude!,
                                      attendanceC.selectedOfficeLocation.value!
                                          .officeLongitude!),
                            ) >
                            attendanceC.standartDistance.value) {
                          GetHelper.showDialog(
                            widget: KText(text: 'You Are Out Of Area'),
                          );
                        } else {
                          attendanceC.attendanceIN();
                          _textEditingController.clear();
                          attendanceC.remarks.value = '';
                        }
                      } else {
                        GetHelper.snackBar(
                            text: 'Location Not Selected',
                            status: Status.error);
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ImageIcon(
                      //   AssetImage('assets/icons/in_icon.png'),
                      //   color: Color(0xFFFFFFFF),
                      //   size: 24.0,
                      // ),
                      // SizedBox(width: 15.0),
                      Text(
                        'IN',

                        //style: TextStyle(color: Colors.white),
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFCFDEE3),
                        height: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Employee In-Out History',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.0,
                          color: AppTheme.newAppBarTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFFCFDEE3),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   physics: BouncingScrollPhysics(),
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     physics: BouncingScrollPhysics(),
              //     child: DataTable(
              //       columnSpacing: 15,
              //       showCheckboxColumn: false,
              //       dividerThickness: 1,
              //       showBottomBorder: true,
              //       headingRowHeight: 35.0,
              //       dataRowHeight: 32.0,
              //       headingRowColor: MaterialStateColor.resolveWith(
              //           (states) => AppTheme.appbarColor),
              //       decoration: BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(width: 1.0, color: Color(0xFFCFDEE3)),
              //         ),
              //       ),
              //       headingTextStyle: TextStyle(
              //           fontFamily: 'Manrope Bold',
              //           fontSize: 14.0,
              //           color: AppTheme.textColor,
              //           fontWeight: FontWeight.w700),
              //       dataTextStyle: TextStyle(
              //           fontFamily: 'Manrope Regular',
              //           fontSize: 12.0,
              //           color: AppTheme.newAppBarTextColor,
              //           fontWeight: FontWeight.w400),
              //       columns: [
              //         DataColumn(label: Text('Type')),
              //         DataColumn(label: Text('Time')),
              //         DataColumn(label: Text('Location')),
              //         DataColumn(label: Text('Purpose')),
              //         DataColumn(label: Text('Remarks')),
              //       ],
              //       rows: [
              //         DataRow(
              //           cells: <DataCell>[
              //             DataCell(
              //               Text(
              //                 'Out',
              //                 //inOutModel.timeType ?? '',
              //               ),
              //             ),
              //             DataCell(
              //               Text('11:08:27 AM'),
              //             ),
              //             DataCell(
              //               Text(''),
              //             ),
              //             DataCell(
              //               Text('personal'),
              //             ),
              //             DataCell(
              //               Text(''),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget existAtt(Box<Attendance> box) {
    int a = 34200;
    return Builder(
      builder: (context) {
        final item = box.values.last;
        int intime = 0;
        if (item.history.isNotEmpty) {
          String timeV = item.history.first.time.toString().split(' ')[0];
          String timeType = item.history.first.time.toString().split(' ')[1];
          if (timeType.toLowerCase() == 'pm') {
            intime = ((int.parse(timeV.split(':')[0]) + 12) * 3600) +
                (int.parse(timeV.split(':')[1]) * 60) +
                int.parse(timeV.split(':')[2]);
          } else {
            intime = (int.parse(timeV.split(':')[0]) * 3600) +
                (int.parse(timeV.split(':')[1]) * 60) +
                int.parse(timeV.split(':')[2]);
          }
        }
        return Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: KText(
                      text: attendanceC.currentDate,
                      bold: true,
                      fontSize: 16,
                      color: AppTheme.textColor,
                    ),
                  ),
                  item.history.isEmpty
                      ? SvgPicture.asset(
                          'assets/icons/default.svg',
                          width: 25,
                        )
                      : intime >= a
                          ? RenderSvg(
                              path: 'late_icon',
                              height: 24,
                              width: 24,
                            )
                          : RenderSvg(
                              path: 'present_icon', height: 24, width: 24)
                ],
              ),
              SizedBox(height: 5.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Location Type: ',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13.0,
                        color: AppTheme.appTextColor1,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.office,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                await locationTypeBox.put(
                                    agencyC.selectedAgency!.agencyName, 1);
                                attendanceC.controllerDestino.clear();
                                attendanceC.selectedKnownLocation.value = null;
                                attendanceC.location.value = '';
                                if (officeLocBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = officeLocBox
                                      .get(agencyC.selectedAgency!.agencyName);
                                  attendanceC.selectedOfficeLocation.value =
                                      loc;
                                  attendanceC.controllerDestino.text =
                                      attendanceC.selectedOfficeLocation.value!
                                          .locationName!;
                                  attendanceC.location.value = attendanceC
                                      .selectedOfficeLocation
                                      .value!
                                      .locationName!;
                                }

                                attendanceC.othersLocation.value = '';
                                attendanceC.locationType.value = value!;
                                //  attendanceC.controllerDestino.clear();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Office',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.known,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                await locationTypeBox.put(
                                    agencyC.selectedAgency!.agencyName, 2);
                                attendanceC.controllerDestino.clear();
                                attendanceC.selectedOfficeLocation.value = null;
                                attendanceC.location.value = '';
                                if (knownofficeLocBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = knownofficeLocBox
                                      .get(agencyC.selectedAgency!.agencyName);
                                  attendanceC.selectedKnownLocation.value = loc;
                                  attendanceC.controllerDestino.text =
                                      attendanceC.selectedKnownLocation.value!
                                          .locationName!;
                                  attendanceC.location.value = attendanceC
                                      .selectedKnownLocation
                                      .value!
                                      .locationName!;
                                }

                                attendanceC.othersLocation.value = '';
                                attendanceC.locationType.value = value!;
                                //    attendanceC.controllerDestino.clear();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Known',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: Radio(
                              value: LocationType.others,
                              groupValue: attendanceC.locationType.value,
                              // activeColor: Colors.green,
                              onChanged: (value) async {
                                attendanceC.controllerDestino.text = '';
                                attendanceC.location.value = '';

                                if (otherLocationBox.containsKey(
                                    agencyC.selectedAgency!.agencyName)) {
                                  final loc = otherLocationBox
                                      .get(agencyC.selectedAgency!.agencyName);
                                  attendanceC.othersLocation.value = loc!;
                                  attendanceC.location.value = loc;
                                  attendanceC.controllerDestino.text = loc;
                                }
                                attendanceC.selectedKnownLocation.value = null;
                                attendanceC.selectedOfficeLocation.value = null;

                                attendanceC.locationType.value = value!;

                                // kLog(
                                //  'location value ${attendanceC.location.value}');
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 15.0),
                            child: Text(
                              'Others',
                              style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.0,
                                  color: AppTheme.appTextColor2,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: AppTheme.primaryColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          onChanged: (value) {
                            attendanceC.location.value = value;
                            attendanceC.othersLocation.value = value;
                          },
                          readOnly: attendanceC.locationType.value
                                  .toString()
                                  .toLowerCase() !=
                              LocationType.others.toString().toLowerCase(),
                          controller: attendanceC.controllerDestino,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 15.0,
                            color: AppTheme.appTextColor2,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Location',
                            hintText: attendanceC.locationType.value !=
                                    LocationType.others
                                ? 'Select Your location'
                                : 'Write Your location',
                            suffixIcon: Visibility(
                              visible: attendanceC.locationType.value !=
                                  LocationType.others,
                              child: GestureDetector(
                                onTap: () {
                                  if (attendanceC.locationType.value ==
                                      LocationType.office) {
                                    push(SearchAgencyOfficeLocation(
                                        title: 'Office Location Search',
                                        uiCodes: 411001));
                                  } else if (attendanceC.locationType.value ==
                                      LocationType.known) {
                                    push(SearchKnownLocation(
                                        title: 'Known Location Search',
                                        uiCodes: 411001));
                                  }
                                },
                                child: Icon(
                                  Icons.search,
                                  color: AppTheme.appTextColor2,
                                ),
                              ),
                            ),
                            labelStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 13.0,
                                color: AppTheme.appTextColor1,
                                fontWeight: FontWeight.w400),
                            floatingLabelStyle: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 13.0,
                                color: AppTheme.appTextColor1,
                                fontWeight: FontWeight.w400),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme.focusedLineColor, width: 1.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.enabledLineColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: item.history.isNotEmpty
                        ? item.history.last.eventType == 'IN'
                        : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Purpose: ',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13.0,
                            color: AppTheme.appTextColor1,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  attendanceC.purpose.value = Purpose.personal,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: Purpose.personal,
                                      groupValue: attendanceC.purpose.value,
                                      // activeColor: Colors.green,
                                      onChanged: attendanceC.purpose,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 15.0),
                                    child: Text(
                                      'Personal',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  attendanceC.purpose.value = Purpose.official,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: Purpose.official,
                                      groupValue: attendanceC.purpose.value,
                                      // activeColor: Colors.green,
                                      onChanged: attendanceC.purpose,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 15.0),
                                    child: Text(
                                      'Offcial',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  attendanceC.purpose.value = Purpose.end,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Radio(
                                      value: Purpose.end,
                                      groupValue: attendanceC.purpose.value,
                                      // activeColor: Colors.green,
                                      onChanged: attendanceC.purpose,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.0, right: 15.0),
                                    child: Text(
                                      'End of Office',
                                      style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14.0,
                                          color: AppTheme.appTextColor2,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  color: AppTheme.primaryColor,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      attendanceC.remarks.value = value;
                    },
                    maxLines: 3,
                    minLines: 2,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    // inputFormatters: [FilteringTextInputFormatter.deny(RegExp("['\"]"))],
                    key: Key('employee_attendance_remarks_textField'),
                    decoration: InputDecoration(
                      labelText: 'Remarks',
                      hintText: 'Write remarks here',
                      labelStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 13.0,
                          color: AppTheme.appTextColor1,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 13.0,
                          color: AppTheme.appTextColor1,
                          fontWeight: FontWeight.w400),
                      //border: OutlineInputBorder(),
                      //alignLabelWithHint: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppTheme.focusedLineColor, width: 1.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        //borderSide: BorderSide(color: textColor22),
                        borderSide:
                            BorderSide(color: AppTheme.enabledLineColor),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15.0,
                      color: AppTheme.appTextColor2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: KText(
                          text: 'Effective Working Hours :',
                          fontSize: 16,
                          color: AppTheme.newAppBarTextColor,
                        ),
                      ),
                      //SizedBox(width: 10.0),
                      //Spacer(),

                      Expanded(
                        //child: Text('00:00:00', style: TextStyle(fontSize: 17.0), overflow: TextOverflow.clip),
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child: attendanceC.stopWatchTimer != null
                                    ? StreamBuilder<int>(
                                        stream: attendanceC
                                            .stopWatchTimer.value.rawTime,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: '00',
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    KText(
                                                      text: ' : ',
                                                      fontSize: 18,
                                                      color: attendanceC
                                                              .stopWatchTimer
                                                              .value
                                                              .isRunning
                                                          ? hexToColor(
                                                              '#F2BA14')
                                                          : hexToColor(
                                                              '#78909C'),
                                                      bold: true,
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: '00',
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    KText(
                                                      text: ' : ',
                                                      fontSize: 18,
                                                      color: attendanceC
                                                              .stopWatchTimer
                                                              .value
                                                              .isRunning
                                                          ? hexToColor(
                                                              '#F2BA14')
                                                          : hexToColor(
                                                              '#78909C'),
                                                      bold: true,
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: '00',
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else {
                                            final displayTime =
                                                StopWatchTimer.getDisplayTime(
                                              snapshot.data!,
                                              milliSecond: false,
                                            );

                                            final rawTime =
                                                displayTime.split(':');
                                            final hour = rawTime[0];
                                            final min = rawTime[1];
                                            final sec = rawTime[2];
                                            return Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: hour,
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    KText(
                                                      text: ' : ',
                                                      fontSize: 18,
                                                      color: attendanceC
                                                              .stopWatchTimer
                                                              .value
                                                              .isRunning
                                                          ? hexToColor(
                                                              '#F2BA14')
                                                          : hexToColor(
                                                              '#78909C'),
                                                      bold: true,
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: min,
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    KText(
                                                      text: ' : ',
                                                      fontSize: 18,
                                                      color: attendanceC
                                                              .stopWatchTimer
                                                              .value
                                                              .isRunning
                                                          ? hexToColor(
                                                              '#F2BA14')
                                                          : hexToColor(
                                                              '#78909C'),
                                                      bold: true,
                                                    ),
                                                    Container(
                                                      height: 30.0,
                                                      width: 30.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: attendanceC
                                                                .stopWatchTimer
                                                                .value
                                                                .isRunning
                                                            ? hexToColor(
                                                                '#F2BA14')
                                                            : hexToColor(
                                                                '#78909C'),
                                                      ),
                                                      child: KText(
                                                        text: sec,
                                                        bold: true,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      )
                                    : Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                ),
                                                child: KText(
                                                  text: '00',
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              KText(
                                                text: ' : ',
                                                fontSize: 18,
                                                color: attendanceC
                                                        .stopWatchTimer
                                                        .value
                                                        .isRunning
                                                    ? hexToColor('#F2BA14')
                                                    : hexToColor('#78909C'),
                                                bold: true,
                                              ),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                ),
                                                child: KText(
                                                  text: '00',
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              KText(
                                                text: ' : ',
                                                fontSize: 18,
                                                color: attendanceC
                                                        .stopWatchTimer
                                                        .value
                                                        .isRunning
                                                    ? hexToColor('#F2BA14')
                                                    : hexToColor('#78909C'),
                                                bold: true,
                                              ),
                                              Container(
                                                height: 30.0,
                                                width: 30.0,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: attendanceC
                                                          .stopWatchTimer
                                                          .value
                                                          .isRunning
                                                      ? hexToColor('#F2BA14')
                                                      : hexToColor('#78909C'),
                                                ),
                                                child: KText(
                                                  text: '00',
                                                  bold: true,
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  item.history.isEmpty
                      ? SizedBox(
                          width: Get.width,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  hexToColor('#78909C')),

                              //visualDensity: VisualDensity(vertical: 4),
                            ),
                            onPressed: () async {
                              if (attendanceC.othersLocation.value != '') {
                                await otherLocationBox.put(
                                    agencyC.selectedAgency!.agencyName,
                                    attendanceC.controllerDestino.text);
                              }
                              await locationC.getattendanceCurrentLocation();
                              // kLog(
                              //   'khela kobe hbe 4 ${attendanceC.location.value}');
                              //// kLog(
                              //     'value: ${attendanceC.selectedLocation.value!.agencyName}');
                              if (attendanceC.locationType.value !=
                                  LocationType.others) {
                                if (attendanceC.location.value != '') {
                                  if (attendanceC.getDistance(
                                        attendanceC.selectedKnownLocation
                                                    .value !=
                                                null
                                            ? LatLng(
                                                attendanceC
                                                    .selectedKnownLocation
                                                    .value!
                                                    .latitude!,
                                                attendanceC
                                                    .selectedKnownLocation
                                                    .value!
                                                    .longitude!)
                                            : LatLng(
                                                attendanceC
                                                    .selectedOfficeLocation
                                                    .value!
                                                    .officeLatitude!,
                                                attendanceC
                                                    .selectedOfficeLocation
                                                    .value!
                                                    .officeLongitude!),
                                      ) >
                                      attendanceC.standartDistance.value) {
                                    GetHelper.showDialog(
                                        widget:
                                            KText(text: 'You Are Not In Area'));
                                  } else {
                                    attendanceC.attendanceIN();
                                    _textEditingController.clear();
                                    attendanceC.remarks.value = '';
                                  }
                                } else {
                                  GetHelper.snackBar(
                                      text: 'Location Not Selected',
                                      status: Status.error);
                                }
                              } else {
                                if (attendanceC.othersLocation.value != '') {
                                  attendanceC.attendanceIN();
                                  _textEditingController.clear();
                                  attendanceC.remarks.value = '';
                                } else {
                                  GetHelper.snackBar(
                                      text: 'Location Not Selected',
                                      status: Status.error);
                                }
                              }
                            },
                            child: locationC.loading1.value
                                ? Loading(
                                    color: Colors.white,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // ImageIcon(
                                      //   AssetImage('assets/icons/in_icon.png'),
                                      //   color: Color(0xFFFFFFFF),
                                      //   size: 24.0,
                                      // ),
                                      SizedBox(width: 15.0),
                                      Text(
                                        'IN',

                                        //style: TextStyle(color: Colors.white),
                                        style: TextStyle(
                                            fontFamily: 'Manrope',
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      :
                      //  item.history.every((element) =>
                      //         element.purpose!.toLowerCase() != 'end')
                      //     ?
                      item.history.isEmpty
                          ? SizedBox(
                              width: Get.width,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      item.history.last.eventType!
                                                  .toLowerCase() ==
                                              'in'
                                          ? hexToColor('#F2BA14')
                                          : hexToColor('#78909C')),

                                  //visualDensity: VisualDensity(vertical: 4),
                                ),
                                onPressed: () async {
                                  if (attendanceC.othersLocation.value != '') {
                                    await otherLocationBox.put(
                                        agencyC.selectedAgency!.agencyName,
                                        attendanceC.controllerDestino.text);
                                  }
                                  await locationC
                                      .getattendanceCurrentLocation();
                                  // kLog(
                                  //  'khela kobe hbe 1 ${attendanceC.location.value}');
                                  if (attendanceC.locationType.value !=
                                      LocationType.others) {
                                    if (attendanceC.location.value != '') {
                                      if (item.attendanceEventType!
                                              .toLowerCase() ==
                                          'in') {
                                        if (attendanceC.getDistance(
                                              attendanceC.selectedKnownLocation
                                                          .value !=
                                                      null
                                                  ? LatLng(
                                                      attendanceC
                                                          .selectedKnownLocation
                                                          .value!
                                                          .latitude!,
                                                      attendanceC
                                                          .selectedKnownLocation
                                                          .value!
                                                          .longitude!)
                                                  : LatLng(
                                                      attendanceC
                                                          .selectedOfficeLocation
                                                          .value!
                                                          .officeLatitude!,
                                                      attendanceC
                                                          .selectedOfficeLocation
                                                          .value!
                                                          .officeLongitude!),
                                            ) >
                                            attendanceC
                                                .standartDistance.value) {
                                          GetHelper.showDialog(
                                            widget: KText(
                                                text: 'You Are Not In Area'),
                                          );
                                        } else {
                                          await attendanceC.attendanceOut();
                                          _textEditingController.clear();
                                          attendanceC.remarks.value = '';
                                        }
                                      } else {
                                        if (attendanceC.getDistance(
                                              attendanceC.selectedKnownLocation
                                                          .value !=
                                                      null
                                                  ? LatLng(
                                                      attendanceC
                                                          .selectedKnownLocation
                                                          .value!
                                                          .latitude!,
                                                      attendanceC
                                                          .selectedKnownLocation
                                                          .value!
                                                          .longitude!)
                                                  : LatLng(
                                                      attendanceC
                                                          .selectedOfficeLocation
                                                          .value!
                                                          .officeLatitude!,
                                                      attendanceC
                                                          .selectedOfficeLocation
                                                          .value!
                                                          .officeLongitude!),
                                            ) >
                                            attendanceC
                                                .standartDistance.value) {
                                          GetHelper.showDialog(
                                              widget: KText(
                                                  text: 'You Are Not In Area'));
                                        } else {
                                          await attendanceC.attendanceIN();

                                          _textEditingController.clear();
                                          attendanceC.remarks.value = '';
                                        }
                                      }
                                    } else {
                                      GetHelper.snackBar(
                                          text: 'Location Not Selected',
                                          status: Status.error);
                                    }
                                  } else {
                                    if (attendanceC.othersLocation.value !=
                                        '') {
                                      if (item.attendanceEventType!
                                              .toLowerCase() ==
                                          'in') {
                                        await attendanceC.attendanceOut();
                                        _textEditingController.clear();
                                        attendanceC.remarks.value = '';
                                      } else {
                                        // double distance=await attendanceC.calculateDistance(officeLat, officeLng, userLat, userLng)
                                        await attendanceC.attendanceIN();

                                        _textEditingController.clear();
                                        attendanceC.remarks.value = '';
                                      }
                                    } else {
                                      GetHelper.snackBar(
                                          text: 'Location  -- Selected',
                                          status: Status.error);
                                    }
                                  }
                                },
                                child: locationC.loading1.value
                                    ? Loading(
                                        color: Colors.white,
                                      )
                                    : KText(
                                        text: item.history.last.eventType!
                                                    .toLowerCase() ==
                                                'in'
                                            ? 'OUT'
                                            : 'IN',
                                        bold: true,
                                        color: AppTheme.white,
                                        fontSize: 17,
                                      ),
                              ),
                            )
                          : item.history.any((element) =>
                                  element.eventType!.toLowerCase() == 'eof')
                              ? SizedBox(
                                  width: Get.width,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        hexToColor('#78909C').withOpacity(0.4),

                                        //visualDensity: VisualDensity(vertical: 4),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: KText(
                                      text: 'IN',
                                      bold: true,
                                      color: AppTheme.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: Get.width,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(item
                                                      .history.last.eventType!
                                                      .toLowerCase() ==
                                                  'in'
                                              ? hexToColor('#F2BA14')
                                              : hexToColor('#78909C')),

                                      //visualDensity: VisualDensity(vertical: 4),
                                    ),
                                    onPressed: () async {
                                      if (attendanceC.othersLocation.value !=
                                          '') {
                                        await otherLocationBox.put(
                                            agencyC.selectedAgency!.agencyName,
                                            attendanceC.controllerDestino.text);
                                      }
                                      await locationC
                                          .getattendanceCurrentLocation();
                                      // kLog(
                                      //     'khela kobe hbe 2 ${attendanceC.location.value}');
                                      if (attendanceC.locationType.value !=
                                          LocationType.others) {
                                        if (attendanceC.location.value != '') {
                                          if (item.attendanceEventType!
                                                  .toLowerCase() ==
                                              'in') {
                                            if (attendanceC.getDistance(
                                                  attendanceC
                                                              .selectedKnownLocation
                                                              .value !=
                                                          null
                                                      ? LatLng(
                                                          attendanceC
                                                              .selectedKnownLocation
                                                              .value!
                                                              .latitude!,
                                                          attendanceC
                                                              .selectedKnownLocation
                                                              .value!
                                                              .longitude!)
                                                      : LatLng(
                                                          attendanceC
                                                              .selectedOfficeLocation
                                                              .value!
                                                              .officeLatitude!,
                                                          attendanceC
                                                              .selectedOfficeLocation
                                                              .value!
                                                              .officeLongitude!),
                                                ) >
                                                attendanceC
                                                    .standartDistance.value) {
                                              GetHelper.showDialog(
                                                  widget: KText(
                                                      text:
                                                          'You Are Not In Area'));
                                            } else {
                                              await attendanceC.attendanceOut();
                                              _textEditingController.clear();
                                              attendanceC.remarks.value = '';
                                            }
                                          } else {
                                            if (attendanceC.getDistance(
                                                  attendanceC
                                                              .selectedKnownLocation
                                                              .value !=
                                                          null
                                                      ? LatLng(
                                                          attendanceC
                                                              .selectedKnownLocation
                                                              .value!
                                                              .latitude!,
                                                          attendanceC
                                                              .selectedKnownLocation
                                                              .value!
                                                              .longitude!)
                                                      : LatLng(
                                                          attendanceC
                                                              .selectedOfficeLocation
                                                              .value!
                                                              .officeLatitude!,
                                                          attendanceC
                                                              .selectedOfficeLocation
                                                              .value!
                                                              .officeLongitude!),
                                                ) >
                                                attendanceC
                                                    .standartDistance.value) {
                                              GetHelper.showDialog(
                                                  widget: KText(
                                                      text:
                                                          'You Are Not In Area'));
                                            } else {
                                              await attendanceC.attendanceIN();

                                              _textEditingController.clear();
                                              attendanceC.remarks.value = '';
                                            }
                                          }
                                        } else {
                                          GetHelper.snackBar(
                                              text: 'Location Not Selected',
                                              status: Status.error);
                                        }
                                      } else {
                                        if (attendanceC.othersLocation.value !=
                                            '') {
                                          if (item.attendanceEventType!
                                                  .toLowerCase() ==
                                              'in') {
                                            await attendanceC.attendanceOut();
                                            _textEditingController.clear();
                                            attendanceC.remarks.value = '';
                                          } else {
                                            // double distance=await attendanceC.calculateDistance(officeLat, officeLng, userLat, userLng)
                                            await attendanceC.attendanceIN();

                                            _textEditingController.clear();
                                            attendanceC.remarks.value = '';
                                          }
                                        } else {
                                          GetHelper.snackBar(
                                              text: 'Location Not Selected',
                                              status: Status.error);
                                        }
                                      }
                                    },
                                    child: locationC.loading1.value
                                        ? Loading(
                                            color: Colors.white,
                                          )
                                        : KText(
                                            text: item.history.last.eventType!
                                                        .toLowerCase() ==
                                                    'in'
                                                ? 'OUT'
                                                : 'IN',
                                            bold: true,
                                            color: AppTheme.white,
                                            fontSize: 17,
                                          ),
                                  ),
                                )

                  //:
                  //  SizedBox(
                  //     width: Get.width,
                  //     child: TextButton(
                  //       style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all(Colors.grey),

                  //         //visualDensity: VisualDensity(vertical: 4),
                  //       ),
                  //       onPressed: () async {},
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           ImageIcon(
                  //             AssetImage('assets/icons/in_icon.png'),
                  //             color: AppTheme.white,
                  //             size: 24.0,
                  //           ),
                  //           SizedBox(width: 15.0),
                  //           KText(
                  //             text: 'In',
                  //             bold: true,
                  //             color: AppTheme.white,
                  //             fontSize: 17,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),

                  ,
                  SizedBox(height: 5.0),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            color: Color(0xFFCFDEE3),
                            height: 1.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Employee In-Out History',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16.0,
                              color: AppTheme.newAppBarTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Color(0xFFCFDEE3),
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: DataTable(
                        columnSpacing: 15,
                        showCheckboxColumn: false,
                        dividerThickness: 1,
                        showBottomBorder: true,
                        headingRowHeight: 35.0,
                        dataRowHeight: 32.0,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => AppTheme.appbarColor),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0, color: Color(0xFFCFDEE3)),
                          ),
                        ),
                        headingTextStyle: TextStyle(
                          fontFamily: 'Manrope Bold',
                          fontSize: 14.0,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w700,
                        ),
                        dataTextStyle: TextStyle(
                            fontFamily: 'Manrope Regular',
                            fontSize: 12.0,
                            color: AppTheme.newAppBarTextColor,
                            fontWeight: FontWeight.w400),
                        columns: [
                          DataColumn(label: Text('Type')),
                          DataColumn(label: Text('Time')),
                          DataColumn(label: Text('Location')),
                          DataColumn(label: Text('Purpose')),
                          DataColumn(label: Text('Remarks')),
                        ],
                        rows: item.history
                            .map((e) => DataRow(
                                  color: MaterialStateProperty.all(
                                      e.isFirst == true
                                          ? intime >= a
                                              ? Colors.red.shade400
                                              : Colors.green.shade100
                                          : Colors.white),
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(
                                        '${e.eventType}',
                                        //inOutModel.timeType ?? '',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${e.time}',
                                        //inOutModel.timeType ?? '',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${e.location}',
                                        //inOutModel.timeType ?? '',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.purpose ?? '',
                                        //inOutModel.timeType ?? '',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        e.remarks != null ? '${e.remarks}' : '',
                                        //inOutModel.timeType ?? '',
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget shiftPlan() {
    return attendanceC.myshiftPlan.value == null
        ? Center(
            child: KText(text: 'No Shift Plan Available'),
          )
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFCFDEE3),
                        height: 1.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        attendanceC.myshiftPlan.value!.officeTimeName!,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.0,
                          color: AppTheme.newAppBarTextColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Color(0xFFCFDEE3),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    child: DataTable(
                      columnSpacing: 27,
                      showCheckboxColumn: false,
                      dividerThickness: 1,
                      showBottomBorder: true,
                      headingRowHeight: 35.0,
                      dataRowHeight: 32.0,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1.0, color: Color(0xFFCFDEE3)),
                        ),
                      ),
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFFE7F4F9)),
                      headingTextStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.0,
                          color: AppTheme.primaryColor.withOpacity(.6),
                          fontWeight: FontWeight.w700),
                      dataTextStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12.0,
                          color: AppTheme.newAppBarTextColor,
                          fontWeight: FontWeight.w400),
                      columns: [
                        DataColumn(label: Text('Day')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Start')),
                        DataColumn(label: Text('End')),
                      ],
                      rows: [
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Sunday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Sunday')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isSunOfficeDay ==
                                        true
                                    ? 'Working Day'
                                    : '--')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isSunOfficeDay ==
                                        true
                                    ? attendanceC.getrealtime(attendanceC
                                        .myshiftPlan.value!.sunStartTime!)
                                    : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isSunOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.sunEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Monday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Monday')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isMonOfficeDay ==
                                        true
                                    ? 'Working Day'
                                    : '--')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isMonOfficeDay ==
                                        true
                                    ? attendanceC.getrealtime(attendanceC
                                        .myshiftPlan.value!.monStartTime!)
                                    : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isMonOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.monEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Tuesday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Tuesday')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isTuesOfficeDay ==
                                    true
                                ? 'Working Day'
                                : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isTuesOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(attendanceC
                                    .myshiftPlan.value!.tuesStartTime!)
                                : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isTuesOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.tuesEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Wednesday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Wednesday')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isWedOfficeDay ==
                                        true
                                    ? 'Working Day'
                                    : '--')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isWedOfficeDay ==
                                        true
                                    ? attendanceC.getrealtime(attendanceC
                                        .myshiftPlan.value!.wedStartTime!)
                                    : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isWedOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.wedEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Thursday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Thursday')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isThursOfficeDay ==
                                    true
                                ? 'Working Day'
                                : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isThursOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(attendanceC
                                    .myshiftPlan.value!.thursStartTime!)
                                : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isThursOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(attendanceC
                                    .myshiftPlan.value!.thursEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Friday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Friday')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isFriOfficeDay ==
                                        true
                                    ? 'Working Day'
                                    : '--')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isFriOfficeDay ==
                                        true
                                    ? attendanceC.getrealtime(attendanceC
                                        .myshiftPlan.value!.friStartTime!)
                                    : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isFriOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.friEndTime!)
                                : '--')),
                          ],
                        ),
                        DataRow(
                          color: MaterialStateProperty.all(DateFormat('EEEE')
                                      .format(DateTime.now())
                                      .toLowerCase() ==
                                  'Saturday'.toLowerCase()
                              ? Colors.amber.shade100
                              : Colors.white),
                          cells: <DataCell>[
                            DataCell(Text('Saturday')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isSatOfficeDay ==
                                        true
                                    ? 'Working Day'
                                    : '--')),
                            DataCell(Text(
                                attendanceC.myshiftPlan.value!.isSatOfficeDay ==
                                        true
                                    ? attendanceC.getrealtime(attendanceC
                                        .myshiftPlan.value!.satStartTime!)
                                    : '--')),
                            DataCell(Text(attendanceC
                                        .myshiftPlan.value!.isSatOfficeDay ==
                                    true
                                ? attendanceC.getrealtime(
                                    attendanceC.myshiftPlan.value!.satEndTime!)
                                : '--')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
