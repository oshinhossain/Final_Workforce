import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:workforce/src/components/agency_list_component.dart';
import 'package:workforce/src/pages/project_progress_dashboard_page.dart';
import 'package:workforce/src/pages/site_locations_page.dart';
import '../components/network_link_installation_summary_component.dart';
import '../components/pole_installation_summery_component.dart';
import '../components/task_progress_component.dart';
import '../components/transport_orders_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';
import '../controllers/user_location_trace_controller.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';

import '../helpers/render_img.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import 'network_topology_page.dart';

class HomePage extends StatelessWidget with Base {
  final key1 = GlobalKey<State<Tooltip>>();
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    final username = Get.put(UserController()).username;
    await Future.delayed(Duration(seconds: 1));
    // monitor network fetch

    userC.check();
    agencyC.getAgencies(username!);
    projectDashbordC.getDashbordProject();
    taskProgressC.getTaskProgress();
    //  projectProgressDashboardC.projectGet();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    projectDashbordC.getDashbordProject();
    attendanceC.getAttendaneHistory();
    PISummeryC.getPoleInstallationSummery();
    NLISummeryC.getNetworkLinkInstallationSummery();
  }

  @override
  Widget build(BuildContext context) {
    final username = Get.put(UserController()).username;
    Get.put(UserLocationTraceController()).onReady();
    userC.check();
    PISummeryC.getPoleInstallationSummery();
    NLISummeryC.getNetworkLinkInstallationSummery();
    projectDashbordC.getDashbordProject();
    taskProgressC.getTaskProgress();
    projectProgressDashboardC.projectGet();
    versionC.getAppVersion();
    agencyC.getAgencies(username!);
    attendanceC.getAttendaneHistory();
    attendanceC.getWeeklyShiftPlan();
    return SmartRefresher(
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: SingleChildScrollView(
            child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AgencyListComponent(),
              if (PISummeryC.poleInstallationSummeryModel.value != null)
                PoleInstallationSummeryComponent(),
              if (NLISummeryC.networkLinkInstallationSummeryModel.value != null)
                NetworkLinkInstallationSummaryComponent(),
              TaskProgressComponent(),
              // ignore: sized_box_for_whitespace

              TextButton(
                onPressed: () {
                  print('-----------call----------');
                  // push(RingingPage());
                  //  push(VideoCallPage());
                  // socketS.getPcConfig();

                  socketS.initializeSocket();
                },
                child: KText(
                  text: 'Go',
                ),
              ),

              // KText(text: userC.currentUser.value!.username),
              // Container(
              //   // padding: EdgeInsets.all(12),
              //   margin: EdgeInsets.only(left: 12),
              //   height: 180,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 2,
              //     itemBuilder: (BuildContext context, int index) {
              //       return SizedBox(
              //         width: 350,
              //         child: Card(
              //           margin: EdgeInsets.only(right: 12),
              //           shadowColor: Colors.black,
              //           elevation: .3,
              //           child: Padding(
              //             padding: EdgeInsets.all(8.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 // SizedBox(
              //                 //   height: 120,
              //                 // ),

              //                 Row(
              //                   children: [
              //                     ClipOval(
              //                       child: SizedBox.fromSize(
              //                         size: Size.fromRadius(30),
              //                         // Image radius
              //                         child: Image.asset(
              //                           '${Constants.imgPath}/placeholder.jpg',
              //                           fit: BoxFit.cover,
              //                           width: 30,
              //                           height: 30,
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 8,
              //                     ),
              //                     Expanded(
              //                         child: KText(
              //                       bold: true,
              //                       text: 'Bangladesh Machine Tools Factory (BMTF)',
              //                       fontSize: 16,
              //                     ))
              //                   ],
              //                 ),
              //                 SizedBox(
              //                   height: 12,
              //                 ),
              //                 Row(
              //                   children: [
              //                     Column(
              //                       children: [
              //                         Row(
              //                           children: [
              //                             SvgPicture.asset(
              //                               '${Constants.svgPath}/icon_task_pending.svg',
              //                               width: 25,
              //                             ),
              //                             KText(
              //                               text: 'Task Pending',
              //                               fontSize: 14,
              //                               color: AppTheme.textColor,
              //                             ),
              //                             SizedBox(
              //                               width: 6,
              //                             ),
              //                             KText(
              //                               text: '215',
              //                               bold: true,
              //                               fontSize: 14,
              //                               color: hexToColor('#41525A'),
              //                             ),
              //                             SizedBox(
              //                               width: 6,
              //                             ),
              //                             KText(
              //                               text: '(29%)',
              //                               fontSize: 14,
              //                               color: hexToColor('#80939D'),
              //                             ),
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           height: 8,
              //                         ),
              //                         Row(
              //                           children: [
              //                             SvgPicture.asset(
              //                               '${Constants.svgPath}/icon_escalation.svg',
              //                               width: 23,
              //                             ),
              //                             KText(
              //                               text: 'Task Escalation',
              //                               fontSize: 14,
              //                               color: AppTheme.textColor,
              //                             ),
              //                             SizedBox(
              //                               width: 6,
              //                             ),
              //                             KText(
              //                               text: '15',
              //                               bold: true,
              //                               fontSize: 14,
              //                               color: hexToColor('#41525A'),
              //                             ),
              //                             SizedBox(
              //                               width: 6,
              //                             ),
              //                             KText(
              //                               text: '(18%)',
              //                               fontSize: 14,
              //                               color: hexToColor('#80939D'),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                     Spacer(),
              //                     Stack(
              //                       clipBehavior: Clip.none,
              //                       children: [
              //                         Container(
              //                           height: 35,
              //                           width: 35,
              //                           decoration: BoxDecoration(
              //                             color: Color(0xffF5F5FA),
              //                             borderRadius: BorderRadius.circular(50),
              //                             border: Border.all(
              //                               color:
              //                                   Color.fromARGB(255, 230, 230, 233),
              //                               style: BorderStyle.solid,
              //                               width: 0.2,
              //                             ),
              //                             boxShadow: [
              //                               BoxShadow(
              //                                 color: Color(0xffF5F5FA)
              //                                     .withOpacity(0.6),
              //                                 spreadRadius: 5,
              //                                 blurRadius: 7,
              //                                 offset: Offset(0,
              //                                     3), // changes position of shadow
              //                               ),
              //                             ],
              //                           ),
              //                           child: Container(
              //                             height: 35,
              //                             width: 35,
              //                             decoration: BoxDecoration(
              //                               color: Colors.white,
              //                               borderRadius: BorderRadius.circular(50),
              //                             ),
              //                             child: Padding(
              //                               padding: EdgeInsets.all(1.5),
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(50),
              //                                 child: Image.asset(
              //                                   'assets/img/bill.jpeg',
              //                                   height: 35,
              //                                   width: 35,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: 15,
              //                           top: 0,
              //                           child: Container(
              //                             height: 35,
              //                             width: 35,
              //                             decoration: BoxDecoration(
              //                               color: Color(0xffF5F5FA),
              //                               borderRadius: BorderRadius.circular(50),
              //                               border: Border.all(
              //                                 color: Color.fromARGB(
              //                                     255, 230, 230, 233),
              //                                 style: BorderStyle.solid,
              //                                 width: 0.2,
              //                               ),
              //                               // boxShadow: [
              //                               //   BoxShadow(
              //                               //     color:
              //                               //         Color(0xffF5F5FA).withOpacity(0.6),
              //                               //     spreadRadius: 5,
              //                               //     blurRadius: 7,
              //                               //     offset: Offset(
              //                               //         0, 3), // changes position of shadow
              //                               //   ),
              //                               // ],
              //                             ),
              //                             child: Container(
              //                               height: 35,
              //                               width: 35,
              //                               decoration: BoxDecoration(
              //                                 color: Colors.white,
              //                                 borderRadius:
              //                                     BorderRadius.circular(50),
              //                               ),
              //                               child: Padding(
              //                                 padding: EdgeInsets.all(1.5),
              //                                 child: ClipRRect(
              //                                   borderRadius:
              //                                       BorderRadius.circular(50),
              //                                   child: Image.asset(
              //                                     'assets/img/bill.jpeg',
              //                                     height: 35,
              //                                     width: 35,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Positioned(
              //                           left: 32,
              //                           top: 0,
              //                           child: Container(
              //                             height: 33,
              //                             width: 33,
              //                             decoration: BoxDecoration(
              //                               color: Color(0xffF5F5FA),
              //                               borderRadius: BorderRadius.circular(50),
              //                               border: Border.all(
              //                                 color: Color.fromARGB(
              //                                     255, 230, 230, 233),
              //                                 style: BorderStyle.solid,
              //                                 width: 0.2,
              //                               ),
              //                               // boxShadow: [
              //                               //   BoxShadow(
              //                               //     color:
              //                               //         Color(0xffF5F5FA).withOpacity(0.6),
              //                               //     spreadRadius: 5,
              //                               //     blurRadius: 7,
              //                               //     offset: Offset(
              //                               //         0, 3), // changes position of shadow
              //                               //   ),
              //                               // ],
              //                             ),
              //                             child: Container(
              //                               height: 32,
              //                               width: 32,
              //                               decoration: BoxDecoration(
              //                                 color: Color(0xffEEF0F6),
              //                                 borderRadius:
              //                                     BorderRadius.circular(50),
              //                               ),
              //                               child: Center(
              //                                   child: Text(
              //                                 '+25',
              //                                 style: TextStyle(
              //                                   color: Colors.red,
              //                                 ),
              //                               )),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       width: 32,
              //                     )
              //                   ],
              //                 ),
              //                 SizedBox(
              //                   height: 16,
              //                 ),

              //                 Row(
              //                   children: [
              //                     Expanded(
              //                       flex: 6,
              //                       child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(8),
              //                         child: LinearProgressIndicator(
              //                           minHeight: 10,
              //                           valueColor: AlwaysStoppedAnimation(
              //                               hexToColor('#00D8A0')),
              //                           value: .6,
              //                           backgroundColor: hexToColor('#ECECEC'),
              //                         ),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       width: 12,
              //                     ),
              //                     Expanded(
              //                       flex: 1,
              //                       child: KText(
              //                         text: '75%',
              //                         bold: true,
              //                       ),
              //                     )
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),

              // SizedBox(
              //   height: 28,
              // ),
              // // ChartPage(),

              // Center(
              //     child: SfCartesianChart(

              //         // Initialize category axis
              //         primaryXAxis: CategoryAxis(
              //             // axisLine: AxisLine(width: 2),

              //             ),
              //         primaryYAxis:
              //             NumericAxis(rangePadding: ChartRangePadding.round),
              //         isTransposed: false,
              //         tooltipBehavior: TooltipBehavior(
              //             enable: true, activationMode: ActivationMode.doubleTap
              //             // canShowMarker: true,
              //             ),
              //         series: <ChartSeries>[
              //       // Initialize line series
              //       LineSeries<ChartData, String>(
              //           // Enables the tooltip for individual series
              //           enableTooltip: true,
              //           markerSettings: MarkerSettings(
              //             borderWidth: 10,
              //           ),
              //           dataSource: [
              //             // Bind data source
              //             ChartData('Jan', 100),
              //             ChartData('Feb', 90),
              //             ChartData('Mar', 70),
              //             ChartData('Apr', 60),
              //             ChartData('May', 100)
              //           ],
              //           xValueMapper: (ChartData data, _) => data.x,
              //           yValueMapper: (ChartData data, _) => data.y),
              //       LineSeries<ChartData, String>(
              //           // Enables the tooltip for individual series
              //           enableTooltip: true,
              //           dataSource: [
              //             // Bind data source
              //             ChartData('Jan', 85),
              //             ChartData('Feb', 58),
              //             ChartData('Mar', 54),
              //             ChartData('Apr', 42),
              //             ChartData('May', 50),
              //             ChartData('June', 50)
              //           ],
              //           xValueMapper: (ChartData data, _) => data.x,
              //           yValueMapper: (ChartData data, _) => data.y),
              //       LineSeries<ChartData, String>(
              //           // Enables the tooltip for individual series
              //           enableTooltip: true,
              //           dataSource: [
              //             // Bind data source
              //             ChartData('Jan', 95),
              //             ChartData('Feb', 78),
              //             ChartData('Mar', 64),
              //             ChartData('Apr', 87),
              //             ChartData('May', 50),
              //             ChartData('June', 80)
              //           ],
              //           xValueMapper: (ChartData data, _) => data.x,
              //           yValueMapper: (ChartData data, _) => data.y),
              //       LineSeries<ChartData, String>(
              //           // Enables the tooltip for individual series
              //           enableTooltip: true,
              //           dataSource: [
              //             // Bind data source
              //             ChartData('Jan', 60),
              //             ChartData('Feb', 77),
              //             ChartData('Mar', 99),
              //             ChartData('Apr', 90),
              //             ChartData('May', 80),
              //             ChartData('June', 100)
              //           ],
              //           xValueMapper: (ChartData data, _) => data.x,
              //           yValueMapper: (ChartData data, _) => data.y)
              //     ])),

              // SizedBox(
              //   height: 22,
              // ),

              //  // IconButton(
              //   //     onPressed: () {
              // //     projectDashbordC.getDashbordProject();
              //  //     },
              //  //     icon: Icon(
              //  //       Icons.add,
              //   //     )),

              // SizedBox(
              //   height: 12,
              // ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'Subtract'),
                            SizedBox(width: 8),
                            Obx(
                              () => KText(
                                text:
                                    'Projects (${projectDashbordC.projectDashbordHome.length})',
                                bold: true,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                push(SiteLocationsPage());
                              },
                              child: KText(
                                text: 'Sites, ',
                                fontSize: 15,
                                color: hexToColor('#515D64'),
                              ),
                            ),
                            // SizedBox(width: 3),
                            // Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: hexToColor('#80939D'),
                            //   size: 15,
                            // ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                push(NetworkTopologyPage());
                              },
                              child: KText(
                                text: 'Network',
                                fontSize: 15,
                                color: hexToColor('#515D64'),
                              ),
                            ),
                            // SizedBox(width: 3),
                            // Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: hexToColor('#80939D'),
                            //   size: 15,
                            // ),
                            SizedBox(width: 8),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    DottedLine(
                      lineThickness: 1,
                      dashLength: 1.5,
                      dashGapLength: 2,
                      dashColor: hexToColor(
                        '#80939D',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 3),
                height: 380,
                child: Obx(
                  () =>
                      // projectDashbordC.projectDashborCheck.value == true
                      //     ? Center(
                      //         child: Loading(),
                      //       )
                      //     :
                      // projectDashbordC.loading == true
                      //     ? Center(
                      //         child: CircularProgressIndicator(),
                      //       )
                      //     :
                      projectDashbordC.projectDashbordHome.isEmpty
                          ? projectDashbordC.loading.value
                              ? SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                    child: Loading(),
                                  ),
                                )
                              : SizedBox(
                                  height: Get.height / 1.5,
                                  child: Center(
                                      child: KText(text: 'No data found')),
                                )
                          : ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  projectDashbordC.projectDashbordHome.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item =
                                    projectDashbordC.projectDashbordHome[index];
                                return Container(
                                  width: 360,
                                  height: 300,
                                  padding: EdgeInsets.only(left: 15),
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Card(
                                    margin: EdgeInsets.only(right: 12),
                                    shadowColor: Colors.black,
                                    elevation: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // SizedBox(
                                          //   height: 120,
                                          // ),

                                          Row(
                                            children: [
                                              // ClipOval(
                                              //   child: SizedBox.fromSize(
                                              //     size: Size.fromRadius(30),
                                              //     // Image radius
                                              //     child: RenderImg(
                                              //       path: 'service_icon.png',
                                              //       fit: BoxFit.cover,
                                              //     ),
                                              //   ),
                                              // ),
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  // ClipOval(
                                                  //   child: SizedBox.fromSize(
                                                  //     size: Size.fromRadius(26),
                                                  //     // Image radius
                                                  //     child: RenderImg(
                                                  //       path: 'service_icon.png',
                                                  //       fit: BoxFit.cover,
                                                  //     ),
                                                  //   ),
                                                  // ),

                                                  SizedBox(
                                                      height: 60.0,
                                                      width: 60.0,
                                                      child:
                                                          SimpleCircularProgressBar(
                                                        valueNotifier:
                                                            ValueNotifier(
                                                                // 1
                                                                double.parse(item!
                                                                        .outputProgress
                                                                        .toString()) *
                                                                    100.toInt()),
                                                        onGetText:
                                                            (double value) {
                                                          TextStyle
                                                              centerTextStyle =
                                                              TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          );

                                                          return Text(
                                                            '${(double.parse(item.outputProgress.toString()) * 100).toStringAsFixed(1)}%',
                                                            style:
                                                                centerTextStyle,
                                                          );
                                                        },
                                                        maxValue: 100,
                                                        mergeMode: true,
                                                        backStrokeWidth: 8,
                                                        progressStrokeWidth: 8,
                                                        backColor: hexToColor(
                                                            '#D9D9D9'),
                                                        progressColors: [
                                                          hexToColor('#00D8A0')
                                                        ],
                                                      ))

                                                  // CircularProgressIndicator(
                                                  //   valueColor: AlwaysStoppedAnimation<Color>(
                                                  //       Colors.orange),
                                                  //   strokeWidth: 3,
                                                  //   value: .75,
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: KText(
                                                  maxLines: 3,
                                                  bold: true,
                                                  text: item.projectName != null
                                                      ? '${item.projectName}'
                                                      : '',
                                                  fontSize: 15,
                                                ),
                                              ),

                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // kLog(projectDashbordC
                                                  // .projectDashbordHome
                                                  // .length);
                                                  // print(
                                                  //     projectProgressDashboardC
                                                  //         .projectPlanningBoard
                                                  //         .length);
                                                  // projectProgressDashboardC
                                                  //         .changeIndex.value =
                                                  //     projectProgressDashboardC
                                                  //         .projectPlanningBoard
                                                  //         .indexWhere((element) =>
                                                  //             element!
                                                  //                 .projectName ==
                                                  //             item.projectName);
                                                  push(
                                                      ProjectProgressDashboardPage());
                                                },
                                                icon: Icon(
                                                  Icons.visibility,
                                                  color: AppTheme.textColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          SizedBox(
                                            height: 250,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment
                                                    //         .spaceBetween,
                                                    children: [
                                                      KText(text: 'Target  '),
                                                      Spacer(),
                                                      KText(
                                                        text: item.outputTarget !=
                                                                null
                                                            ? ' ${item.outputTarget} '
                                                            : '',
                                                        bold: true,
                                                      ),
                                                      KText(
                                                        text: item.outputDescr !=
                                                                null
                                                            ? ' ${item.outputDescr}'
                                                            : '',
                                                        bold: true,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment
                                                    //         .spaceBetween,
                                                    children: [
                                                      KText(text: 'Achieved  '),
                                                      Spacer(),
                                                      KText(
                                                        text: item.outputAchieved !=
                                                                null
                                                            ? ' ${item.outputAchieved} '
                                                            : '',
                                                        bold: true,
                                                      ),
                                                      KText(
                                                        text: item.outputDescr !=
                                                                null
                                                            ? ' ${item.outputDescr}'
                                                            : '',
                                                        bold: true,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),

                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      KText(
                                                          fontSize: 12,
                                                          text:
                                                              'Project Director '),
                                                      Spacer(),
                                                      KText(
                                                        text: item.pmFullname !=
                                                                null
                                                            ? ' ${item.pmFullname}'
                                                            : 'N/A',
                                                        bold: true,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      // projectDashbordC.userImage
                                                      //             .value !=
                                                      //         null
                                                      //     ? Container(
                                                      //         height: 32,
                                                      //         width: 32,
                                                      //         padding:
                                                      //             EdgeInsets.all(
                                                      //                 2),
                                                      //         decoration:
                                                      //             BoxDecoration(
                                                      //                 color: Colors
                                                      //                     .white,
                                                      //                 shape: BoxShape
                                                      //                     .circle,
                                                      //                 boxShadow: [
                                                      //               BoxShadow(
                                                      //                 color: Colors
                                                      //                     .grey,
                                                      //                 offset:
                                                      //                     Offset(
                                                      //                         0,
                                                      //                         0),
                                                      //                 blurRadius:
                                                      //                     8.0,
                                                      //               ),
                                                      //             ]),
                                                      //         child: ClipRRect(
                                                      //           borderRadius:
                                                      //               BorderRadius
                                                      //                   .circular(
                                                      //                       50),
                                                      //           child:
                                                      //               Image.memory(
                                                      //             projectDashbordC
                                                      //                 .userImage
                                                      //                 .value!,
                                                      //             fit: BoxFit
                                                      //                 .cover,
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : GestureDetector(
                                                      //         onTap: () {
                                                      //           projectDashbordC
                                                      //               .getImageByUserName(
                                                      //                   username:
                                                      //                       item.pmUsername!);
                                                      //         },
                                                      //         child: CircleAvatar(
                                                      //           backgroundColor:
                                                      //               AppTheme
                                                      //                   .color4,
                                                      //           radius: 15,
                                                      //           child: RenderSvg(
                                                      //               path:
                                                      //                   'avatar_placeholder'),
                                                      //         ),
                                                      //       ),
                                                      //
                                                      if (item.pmFullname !=
                                                          null)
                                                        RenderImg(
                                                          path:
                                                              'icon_avatar.png',
                                                          width: 30,
                                                          height: 30,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(),

                                                ///
                                                InkWell(
                                                  onTap: () {
                                                    FlutterPhoneDirectCaller
                                                        .callNumber(
                                                            '${item.pmMobile}');
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      /// mainAxisAlignment:
                                                      //     MainAxisAlignment
                                                      //         .spaceBetween,
                                                      children: [
                                                        KText(
                                                            text:
                                                                'Mobile Number'),
                                                        Spacer(),
                                                        // SizedBox(
                                                        //   height: 30,
                                                        //   child: IconButton(
                                                        //       padding:
                                                        //           EdgeInsets.all(
                                                        //               0.0),
                                                        //       onPressed: () {
                                                        //         FlutterPhoneDirectCaller
                                                        //             .callNumber(
                                                        //                 '${item.pmMobile}');
                                                        //         // launch(
                                                        //         //     'tel:${item.pmMobile}');
                                                        //       },
                                                        //       icon: Icon(
                                                        //           Icons
                                                        //               .phone_forwarded_sharp,
                                                        //           size: 20,
                                                        //           color: Colors
                                                        //               .blue)),
                                                        // ),

                                                        KText(
                                                          text: item.pmMobile !=
                                                                  null
                                                              ? ' ${item.pmMobile} '
                                                              : '',
                                                          bold: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // Divider(),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     KText(text: 'Mobile: '),
                                                //     KText(
                                                //       text: ' ${item.pmMobile}',
                                                //       bold: true,
                                                //     ),
                                                //   ],
                                                // ),
                                                // Divider(),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     KText(text: 'Email: '),
                                                //     KText(
                                                //       text: ' ${item.pmEmail}',
                                                //       bold: true,
                                                //     ),
                                                //   ],
                                                // ),
                                                Divider(),

                                                SizedBox(
                                                  height: 40,
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#C1FFEF'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#DDFFF6'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'R',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#09CD9A'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                  left: 30,
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#09CD9A'),
                                                                    radius: 7,
                                                                    child:
                                                                        FittedBox(
                                                                      child:
                                                                          KText(
                                                                        text: item.countR !=
                                                                                null
                                                                            ? '${item.countR}'
                                                                            : '0',
                                                                        fontSize:
                                                                            14,
                                                                        bold:
                                                                            true,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#FFF8B9'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#FFFCE1'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'A',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#E2BE02'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#E2BE02'),
                                                                  radius: 7,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: item.countA !=
                                                                              null
                                                                          ? '${item.countA}'
                                                                          : '0',
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#CFE8FF'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#E7F3FF'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'S',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#007BEC'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#007BEC'),
                                                                  radius: 7,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: item.countS !=
                                                                              null
                                                                          ? '${item.countS}'
                                                                          : '0',
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#FFE9CF'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#FFF4E8'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'C',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#FFA133'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#FF8383'),
                                                                  radius: 7,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: item.countS !=
                                                                              null
                                                                          ? '${item.countS}'
                                                                          : '0',
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Stack(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            15),
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 22,
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#8BB2D6'),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        hexToColor(
                                                                            '#DCE8F3'),
                                                                    radius: 21,
                                                                    child:
                                                                        KText(
                                                                      text: 'I',
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true,
                                                                      color: hexToColor(
                                                                          '#8BB2D6'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 30,
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      hexToColor(
                                                                          '#8BB2D6'),
                                                                  radius: 7,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        KText(
                                                                      text: item.countI !=
                                                                              null
                                                                          ? '${item.countI}'
                                                                          : '0',
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 45,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/exclamatory_back.png'))),
                                                          ),
                                                          // Positioned(
                                                          //   top: 20,
                                                          //   child: RenderSvg(
                                                          //       height: 20,
                                                          //       path: 'exclamatory'),
                                                          // ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: hexToColor(
                                                                            '#FF8383'),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                              child: RenderSvg(
                                                                path: 'flag',
                                                              )),
                                                          Positioned(
                                                            left: 5,
                                                            bottom: 25,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  hexToColor(
                                                                      '#6AB2F5'),
                                                              radius: 7,
                                                              child: FittedBox(
                                                                child: KText(
                                                                  text: item.countRisk !=
                                                                          null
                                                                      ? '${item.countRisk}'
                                                                      : '0',
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(1),
                                                              height: 40,
                                                              width: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: hexToColor(
                                                                            '#E9D418'),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                              child: RenderSvg(
                                                                path: 'null',
                                                              )),
                                                          Positioned(
                                                            left: 5,
                                                            bottom: 25,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  hexToColor(
                                                                      '#8BB2D6'),
                                                              radius: 7,
                                                              child: FittedBox(
                                                                child: KText(
                                                                  text: item.countIssue !=
                                                                          null
                                                                      ? '${item.countIssue}'
                                                                      : '0',
                                                                  fontSize: 14,
                                                                  bold: true,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
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

                                          // Row(
                                          //   children: [
                                          //     InkWell(
                                          //       onTap: () {
                                          //         projectDashbordC.getDashbordProject();
                                          //       },
                                          //       child: SvgPicture.asset(
                                          //         '${Constants.svgPath}/icon_card_messages.svg',
                                          //         height: 16.0,
                                          //         width: 18.0,
                                          //         allowDrawingOutsideViewBox: true,
                                          //         color: hexToColor('#9BA9B3'),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 3,
                                          //     ),
                                          //     KText(
                                          //       text: '',
                                          //       fontSize: 16,
                                          //       color: hexToColor('#515D64'),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 10,
                                          //     ),
                                          //     SvgPicture.asset(
                                          //       '${Constants.svgPath}/icon_chat_attach.svg',
                                          //       height: 16.0,
                                          //       width: 18.0,
                                          //       allowDrawingOutsideViewBox: true,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 3,
                                          //     ),
                                          //     KText(
                                          //       text: '',
                                          //       fontSize: 16,
                                          //       color: hexToColor('#515D64'),
                                          //     ),
                                          //     SizedBox(
                                          //       width: 10,
                                          //     ),
                                          //     SvgPicture.asset(
                                          //       '${Constants.svgPath}/icon_card_escalation.svg',
                                          //       height: 16.0,
                                          //       width: 18.0,
                                          //       allowDrawingOutsideViewBox: true,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 3,
                                          //     ),
                                          //     KText(
                                          //       text: '',
                                          //       fontSize: 16,
                                          //       color: hexToColor('#515D64'),
                                          //     ),
                                          //     Spacer(),
                                          //     RenderSvg(
                                          //       path: 'icon_add_user',
                                          //       width: 35,
                                          //     ),
                                          //     SizedBox(
                                          //       width: 8,
                                          //     ),
                                          //     Stack(
                                          //       clipBehavior: Clip.none,
                                          //       children: [
                                          //         Container(
                                          //           height: 35,
                                          //           width: 35,
                                          //           decoration: BoxDecoration(
                                          //             color: Color(0xffF5F5FA),
                                          //             borderRadius: BorderRadius.circular(50),
                                          //             border: Border.all(
                                          //               color: Color.fromARGB(
                                          //                   255, 230, 230, 233),
                                          //               style: BorderStyle.solid,
                                          //               width: 0.2,
                                          //             ),
                                          //             boxShadow: [
                                          //               BoxShadow(
                                          //                 color: Color(0xffF5F5FA)
                                          //                     .withOpacity(0.6),
                                          //                 spreadRadius: 5,
                                          //                 blurRadius: 7,
                                          //                 offset: Offset(0,
                                          //                     3), // changes position of shadow
                                          //               ),
                                          //             ],
                                          //           ),
                                          //           child: Container(
                                          //             height: 35,
                                          //             width: 35,
                                          //             decoration: BoxDecoration(
                                          //               color: Colors.white,
                                          //               borderRadius:
                                          //                   BorderRadius.circular(50),
                                          //             ),
                                          //             child: Padding(
                                          //               padding: EdgeInsets.all(1.5),
                                          //               child: ClipRRect(
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(50),
                                          //                 child: Image.asset(
                                          //                   'assets/img/bill.jpeg',
                                          //                   height: 35,
                                          //                   width: 35,
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         Positioned(
                                          //           left: 15,
                                          //           top: 0,
                                          //           child: Container(
                                          //             height: 35,
                                          //             width: 35,
                                          //             decoration: BoxDecoration(
                                          //               color: Color(0xffF5F5FA),
                                          //               borderRadius:
                                          //                   BorderRadius.circular(50),
                                          //               border: Border.all(
                                          //                 color: Color.fromARGB(
                                          //                     255, 230, 230, 233),
                                          //                 style: BorderStyle.solid,
                                          //                 width: 0.2,
                                          //               ),
                                          //               // boxShadow: [
                                          //               //   BoxShadow(
                                          //               //     color:
                                          //               //         Color(0xffF5F5FA).withOpacity(0.6),
                                          //               //     spreadRadius: 5,
                                          //               //     blurRadius: 7,
                                          //               //     offset: Offset(
                                          //               //         0, 3), // changes position of shadow
                                          //               //   ),
                                          //               // ],
                                          //             ),
                                          //             child: Container(
                                          //               height: 35,
                                          //               width: 35,
                                          //               decoration: BoxDecoration(
                                          //                 color: Colors.white,
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(50),
                                          //               ),
                                          //               child: Padding(
                                          //                 padding: EdgeInsets.all(1.5),
                                          //                 child: ClipRRect(
                                          //                   borderRadius:
                                          //                       BorderRadius.circular(50),
                                          //                   child: Image.asset(
                                          //                     'assets/img/bill.jpeg',
                                          //                     height: 35,
                                          //                     width: 35,
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         Positioned(
                                          //           left: 30,
                                          //           top: 0,
                                          //           child: Container(
                                          //             height: 33,
                                          //             width: 33,
                                          //             decoration: BoxDecoration(
                                          //               color: Color(0xffF5F5FA),
                                          //               borderRadius:
                                          //                   BorderRadius.circular(50),
                                          //               border: Border.all(
                                          //                 color: Color.fromARGB(
                                          //                     255, 230, 230, 233),
                                          //                 style: BorderStyle.solid,
                                          //                 width: 0.2,
                                          //               ),
                                          //               // boxShadow: [
                                          //               //   BoxShadow(
                                          //               //     color:
                                          //               //         Color(0xffF5F5FA).withOpacity(0.6),
                                          //               //     spreadRadius: 5,
                                          //               //     blurRadius: 7,
                                          //               //     offset: Offset(
                                          //               //         0, 3), // changes position of shadow
                                          //               //   ),
                                          //               // ],
                                          //             ),
                                          //             child: Container(
                                          //               height: 32,
                                          //               width: 32,
                                          //               decoration: BoxDecoration(
                                          //                 color: Color(0xffEEF0F6),
                                          //                 borderRadius:
                                          //                     BorderRadius.circular(50),
                                          //               ),
                                          //               child: Center(
                                          //                   child: Text(
                                          //                 '+25',
                                          //                 style: TextStyle(
                                          //                   color: Colors.red,
                                          //                 ),
                                          //               )),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //     SizedBox(
                                          //       width: 30,
                                          //     )
                                          //   ],
                                          // ),

                                          // TextButton(
                                          //     onPressed: () {
                                          //       projectDashbordC
                                          //           .getImageByUserName(
                                          //               username:
                                          //                   item.pmUsername!);
                                          //     },
                                          //     child: KText(text: 'ok')),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
              // SizedBox(height: 15),

              TransportOrdersComponent(),
            ],
          ),
        )));
  }

  Widget kTooltip({required GlobalKey key}) {
    return Tooltip(
      key: key,
      triggerMode: TooltipTriggerMode.tap,
      message:
          'For multi-agency, approval will\n be neede from the biz parth     \nMulti-agency project is an \n major revenue earn',
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.appbarColor,
      ),
      padding: EdgeInsets.all(12),
      textStyle: TextStyle(
        fontFamily: 'Manrope Regular',
        color: AppTheme.textColor,
      ),
      child: IconButton(
        onPressed: () {
          final dynamic tooltip = key.currentState!;
          tooltip?.ensureTooltipVisible();
        },
        icon: Icon(Icons.info_outline),
        color: Colors.grey,
      ),
    );
  }
  //===========
}

class SalesData {
  /// Holds the datapoint values like x, y, etc.,
  SalesData(this.x, this.y, this.date, this.color);

  /// X value of the data point
  final dynamic x;

  /// y value of the data point
  final dynamic y;

  /// color value of the data point
  final Color? color;

  /// Date time value of the data point
  final DateTime? date;
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
