import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../controllers/location_controller.dart';
import '../controllers/user_controller.dart';
import '../helpers/global_helper.dart';
import '../helpers/loading.dart';
import '../helpers/route.dart';

class AssignVehicleAndDriverPage extends StatefulWidget with Base {
  final String? transportOrderNo;
  final bool? isFromNotification;

  AssignVehicleAndDriverPage({this.transportOrderNo, this.isFromNotification});

  @override
  // ignore: library_private_types_in_public_api
  _AssignVehicleAndDriverPageState createState() =>
      _AssignVehicleAndDriverPageState();
}

class _AssignVehicleAndDriverPageState extends State<AssignVehicleAndDriverPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      assignVehicleAndDriverC.getTransportOrder(
        transportOrderNo: widget.transportOrderNo!,
      );
      loadMaterialsToVehicleC.getTransportOrderVehicle(
        transportOrderNo: widget.transportOrderNo!,
      );
    } else {
      assignVehicleAndDriverC.getTransportOrder(
        transportOrderNo: '221024.00001',
      );
      // loadMaterialsToVehicleC.getTransportOrderVehicle(
      //   transportOrderNo: '20221002.00001',
      // );
    }

    assignVehicleAndDriverC.getAssignVehicleDriverTravelPath();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController!.index;
        });
      }
    });

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Scaffold(
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
          title: KText(
            text: 'Assign Vehicle and Driver',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: hexToColor('#EEF0F6'),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: _tabBar,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BasicData(),
            Materials(),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            color: Colors.amber,
            fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: _activeIndex == 0
              ? BorderRadius.only(topLeft: Radius.circular(5.0))
              : _activeIndex == 1
                  ? BorderRadius.only(topRight: Radius.circular(5.0))
                  : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'Basic Data'),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
            child: Tab(text: 'Material'),
          ),
        ],
      );
  //

}

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool searchIcon;
  final bool avatar;
  final bool hasCheckbox;
  final String? srchText;
  final Color? color;

  TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = true,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    this.color,
    this.srchText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isActive = true;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              if (widget.hasCheckbox)
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      activeColor: hexToColor('#84BEF3'),
                      value: isActive,
                      onChanged: (bool? value) {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                    ),
                  ),
                ),
              KText(
                text: widget.title,
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              widget.avatar
                  ? Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 40,
                        width: 40,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
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
                                '${Constants.imgPath}/bill.jpeg',
                                width: 37,
                                height: 37,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              KText(
                text: widget.srchText,
                fontSize: 15,
                color: widget.color != null ? widget.color : AppTheme.textColor,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

//

class BasicData extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    final locationC = Get.put(LocationController());
    final latLng =
        '${locationC.latLng.value.longitude},${locationC.latLng.value.longitude}';

    final username = Get.put(UserController()).username;

    return Obx(
      () => assignVehicleAndDriverC.transportOrder.value == null
          ? Center(child: Loading())
          : ListView(
              children: [
                SizedBox(
                  height: 22,
                ),
                assignVehicleAndDriverC.transportOrder.value != null
                    ? Builder(builder: (context) {
                        final item =
                            assignVehicleAndDriverC.transportOrder.value;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                width: Get.width,
                                color: hexToColor('#FFFFFF'),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Transport Order',
                                          fontSize: 14,
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: '${item!.transportOrderNo}',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        KText(
                                          text: 'Date',
                                          fontSize: 14,
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: formatDate(
                                              date: item.transportOrderDate!),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              color: hexToColor('#EBEBEC'),
                              height: 1,
                              width: Get.width,
                            ),
                            SizedBox(height: 10),
                            TextFieldWidget(
                              avatar: false,
                              title: 'Source Location (Loading Point)',
                              srchText: '${item.sourceLocName}',
                            ),
                            TextFieldWidget(
                              avatar: false,
                              title: 'Destination Location (Unloading Point)',
                              srchText: '${item.destinationLocName}',
                              color: hexToColor('#515D64'),
                            ),
                          ],
                        );
                      })
                    : SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RenderSvg(path: 'trucklogo'),
                          SizedBox(
                            width: 5,
                          ),
                          Row(
                            children: [
                              KText(
                                text: 'Vehicle',
                                fontSize: 14,
                                color: hexToColor('#41525A'),
                                bold: true,
                              ),
                              KText(
                                text: '*',
                                fontSize: 14,
                                color: Colors.red,
                                bold: true,
                              ),
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              assignVehicleAndDriverC.addVehicleBottomSheet();
                              //  openBottomSheet();
                            },
                            child: SvgPicture.asset(
                                '${Constants.svgPath}/icon_add_box.svg'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DottedLine(
                        lineThickness: 0.1,
                        dashColor: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: assignVehicleAndDriverC.modelList.length,
                      itemBuilder: (context, index) {
                        final item1 = assignVehicleAndDriverC.modelList[index];
                        return Container(
                          margin: EdgeInsets.only(top: 15),

                          height: 235,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: hexToColor('#FFE9CF')),
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: hexToColor('#FFFFFF'),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 34,
                                width: double.infinity,

                                // color: hexToColor('#FFE9CF'),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)),
                                  color: hexToColor('#FFE9CF'),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5, left: 15, top: 5),
                                      child: KText(
                                        text: '${item1.registrationNo}',
                                        //'Dhaka Metro ${item.model}',
                                        fontSize: 16,
                                        color: hexToColor('#41525A'),
                                        bold: true,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        assignVehicleAndDriverC.modelList
                                            .removeWhere(
                                                (x) => x.id == item1.id);
                                      },
                                      child: SvgPicture.asset(
                                        '${Constants.svgPath}/icon_delete.svg',
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        //Type
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'Type: ',
                                                fontSize: 14,
                                                color: hexToColor('#80939D'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                              KText(
                                                text: item1.vehicleType != null
                                                    ? '${item1.vehicleType} '
                                                    : '',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Capacity
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'Capacity: ',
                                                fontSize: 14,
                                                color: hexToColor('#80939D'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                              KText(
                                                text: item1.weightCapacity !=
                                                        null
                                                    ? '${item1.weightCapacity} '
                                                    : '',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                              KText(
                                                text: item1.weightCapacityUnit !=
                                                        null
                                                    ? '${item1.weightCapacityUnit}'
                                                    : '',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Brand
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            children: [
                                              KText(
                                                text: 'Brand: ',
                                                fontSize: 14,
                                                color: hexToColor('#80939D'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                              KText(
                                                text: item1.brand != null
                                                    ? '${item1.brand} '
                                                    : '',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: false,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 5, right: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.white60),
                                      child: SizedBox(
                                          height: 100,
                                          width: 140,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: assignVehicleAndDriverC
                                                        .selectedvechileImageCount[
                                                            assignVehicleAndDriverC
                                                                .selectedvechileImageCount
                                                                .indexWhere((element) =>
                                                                    element
                                                                        .regNo ==
                                                                    item1
                                                                        .registrationNo)]
                                                        .imageCount ==
                                                    '0'
                                                ? RenderSvg(
                                                    path: 'image_vehicle',
                                                  )
                                                : Image.network(
                                                    '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=${locationC.latLng}&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item1.id}&originalFileNameNeeded=&registrationNo=${item1.registrationNo}&status=&flag=1',

                                                    // '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}',
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                    width: 140,
                                                  ),
                                          )

                                          //// kLog("snapshot.data paichi ");
                                          //kLog(snapshot.data);
                                          // if (snapshot
                                          //         .data.statusCode ==
                                          //     '200') {
                                          //   return ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(
                                          //             5),
                                          //     child: Image.network(
                                          //       '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=${locationC.latLng}&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item.id}&originalFileNameNeeded=&registrationNo=${item.registrationNo}&status=&flag=1',

                                          //       // '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}',
                                          //       fit: BoxFit.cover,
                                          //       height: 160,
                                          //       width: 200,
                                          //     ),
                                          //   );
                                          // }
                                          // if (snapshot
                                          //         .data.statusCode ==
                                          //     '500') {
                                          //   return RenderSvg(
                                          //     path: 'image_vehicle',
                                          //   );
                                          // } else {
                                          // return RenderSvg(
                                          //   path: 'image_vehicle',
                                          // );
                                          // }
                                          ))
                                ],
                              ),
                              Divider(
                                endIndent: 15,
                                indent: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Driver',
                                      bold: false,
                                      fontSize: 14,
                                      color: hexToColor('#41525A'),
                                    ),
                                    SizedBox(width: 1),
                                    KText(
                                      text: '*',
                                      fontSize: 14,
                                      color: Colors.red,
                                      bold: true,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        assignVehicleAndDriverC
                                            .addDriverBottomSheet(
                                                vehicleId: item1.id!);
                                      },
                                      child: SvgPicture.asset(
                                          '${Constants.svgPath}/icon_Search_Elements.svg'),
                                    ),
                                  ],
                                ),
                              ),
                              if (item1.driverFullname != null &&
                                  item1.driverFullname!.isNotEmpty)

                                //driver name & image
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    item1.driverUsername != null
                                        ? Container(
                                            height: 38,
                                            width: 38,
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 2.0,
                                                  ),
                                                ]),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item1.driverUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: AppTheme.color4,
                                            radius: 45,
                                            child: RenderSvg(
                                                path: 'avatar_placeholder'),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    KText(
                                      text: item1.driverUsername,
                                      fontSize: 15,
                                      color: AppTheme.textColor,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //---//
                // travel route && remarks
                //---//

                // if (assignVehicleAndDriverC.travelPath.value != null)
                //   Builder(builder: (context) {
                //     final item = assignVehicleAndDriverC.travelPath.value;
                //     return Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 15),
                //       child: Column(
                //         children: [
                //           Row(
                //             children: [
                //               SvgPicture.asset(
                //                   '${Constants.svgPath}/icon_path.svg'),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               KText(
                //                 text: 'Travel Route',
                //                 bold: true,
                //                 fontSize: 14,
                //                 color: hexToColor('#41525A'),
                //               ),
                //               Spacer(),
                //               KText(
                //                 text: '${item!.pathLenghtKm} Km',
                //                 bold: false,
                //                 fontSize: 14,
                //                 color: hexToColor('#41525A'),
                //               ),
                //             ],
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           DottedLine(
                //             lineThickness: 0.1,
                //             dashColor: Colors.black,
                //           ),
                //           SizedBox(height: 10),
                //           KText(
                //             text: item.travelPathName,
                //             color: hexToColor('#515D64'),
                //           ),
                //           SizedBox(height: 10),
                //           Container(
                //             height: 190,
                //             width: Get.width,
                //             decoration: BoxDecoration(
                //               color: hexToColor('#FFE9CF'),
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(5),
                //               child: FlutterMap(
                //                 mapController: mapViewC.kMapController,
                //                 options: MapOptions(
                //                   center: item.points![0],
                //                   zoom: 14.0,
                //                   minZoom: 1.0,
                //                   maxZoom: 90,
                //                 ),
                //                 children: [
                //                   TileLayer(
                //                     userAgentPackageName:
                //                         'com.ctrendssoftware.workforce',
                //                     urlTemplate:
                //                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                //                     // urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                //                     // subdomains: ['a', 'b', 'c'],
                //                   ),
                //                   MarkerLayer(
                //                     markers: [
                //                       Marker(
                //                         //marker
                //                         width: 40.0,
                //                         height: 10.0,

                //                         builder: (context) {
                //                           return GestureDetector(
                //                             onTap: () {},
                //                             child: Padding(
                //                               padding: EdgeInsets.only(
                //                                 bottom: 50,
                //                                 right: 8,
                //                               ),
                //                               child: Icon(
                //                                 Icons.location_on,
                //                                 color: hexToColor('#007BEC'),
                //                                 size: 40,
                //                               ),
                //                             ),
                //                             // child: RenderImg(
                //                             //   path: 'man-1.png',
                //                             //   height: 30,
                //                             //   width: 30,
                //                             // ),
                //                           );
                //                         },
                //                         point: item.points!.first,
                //                       ),
                //                       Marker(
                //                         //marker
                //                         width: 40.0,
                //                         height: 40.0,

                //                         builder: (context) {
                //                           return GestureDetector(
                //                             onTap: () {},
                //                             child: Icon(
                //                               Icons.location_on,
                //                               color: hexToColor('#00D8A0'),
                //                               size: 40,
                //                             ),
                //                             // child: RenderImg(
                //                             //   path: 'man-1.png',
                //                             //   height: 30,
                //                             //   width: 30,
                //                             // ),
                //                           );
                //                         },
                //                         point: item.points!.last,
                //                       ),
                //                     ],
                //                   ),
                //                   // ***************************
                //                   PolylineLayer(
                //                     polylineCulling: false,
                //                     polylines: [
                //                       Polyline(
                //                         points: item.points!,
                //                         // points: [
                //                         //   LatLng(13.035606, 77.562381),
                //                         // ],
                //                         color: Colors.green,
                //                         isDotted: true,
                //                         borderColor: Colors.amber,
                //                         strokeCap: StrokeCap.round,
                //                         strokeWidth: 5,
                //                         borderStrokeWidth: 5,
                //                       ),
                //                     ],
                //                   ),

                //                   PolygonLayer(
                //                     polygonCulling: false,
                //                     polygons: [
                //                       Polygon(
                //                         points: [
                //                           LatLng(0, 0),
                //                           LatLng(5, 5),
                //                           LatLng(10, 10),
                //                         ],
                //                         color: hexToColor('#63FF7C')
                //                             .withOpacity(0.5),
                //                         isDotted: true,
                //                         isFilled: true,
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(height: 6),
                //           Row(
                //             children: [
                //               SizedBox(
                //                 height: 15,
                //                 width: 15,
                //                 child: TextButton(
                //                   onPressed: () {
                //                     print('object');
                //                   },
                //                   style: ButtonStyle(
                //                     backgroundColor: MaterialStateProperty.all(
                //                         hexToColor('#007BEC')),
                //                     shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                       RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(0),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Text(''),
                //                 ),
                //               ),
                //               SizedBox(width: 7),
                //               KText(text: 'Starting'),
                //               SizedBox(width: 7),
                //               SizedBox(
                //                 height: 15,
                //                 width: 15,
                //                 child: TextButton(
                //                   onPressed: () {
                //                     print('object');
                //                   },
                //                   style: ButtonStyle(
                //                     backgroundColor: MaterialStateProperty.all(
                //                         hexToColor('#FFA133')),
                //                     shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                       RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(0),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Text(''),
                //                 ),
                //               ),
                //               SizedBox(width: 7),
                //               KText(text: 'Drop'),
                //               SizedBox(width: 7),
                //               SizedBox(
                //                 height: 15,
                //                 width: 15,
                //                 child: TextButton(
                //                   onPressed: () {
                //                     print('object');
                //                   },
                //                   style: ButtonStyle(
                //                     backgroundColor: MaterialStateProperty.all(
                //                         hexToColor('#00D8A0')),
                //                     shape: MaterialStateProperty.all<
                //                         RoundedRectangleBorder>(
                //                       RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(0),
                //                       ),
                //                     ),
                //                   ),
                //                   child: Text(''),
                //                 ),
                //               ),
                //               SizedBox(width: 7),
                //               KText(
                //                 text: 'Destination',
                //               ),
                //               SizedBox(width: 7),
                //             ],
                //           ),
                //         ],
                //       ),
                //     );
                //   }),
                // SizedBox(height: 12),
                // TextFieldWidget(
                //   avatar: false,
                //   title: 'Remarks',
                //   srchText: 'Remarks Here',
                //   color: hexToColor('#D9D9D9'),
                // ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  height: 40,
                  width: Get.width,

                  // margin: EdgeInsets.symmetric(vertical: .5),

                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          back();
                          // showTopSnackBar(
                          //   context,
                          //   CustomSnackBar.error(
                          //     message: 'Rejected',
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: hexToColor('#FFA133'),
                          ),
                          child: Center(
                            child: KText(
                              text: 'Cancel',
                              color: Colors.white,
                              bold: true,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: assignVehicleAndDriverC.modelList.isNotEmpty &&
                                assignVehicleAndDriverC
                                    .modelList[0].driverFullname!.isNotEmpty
                            ? () {
                                assignVehicleAndDriverC
                                    .postAssignVehicleDriver();
                              }
                            : () {
                                Get.snackbar(
                                  'Status',
                                  'Please add vehicle and driver.',
                                  colorText: AppTheme.black,
                                  backgroundColor: AppTheme.appHomePageColor,
                                  snackPosition: SnackPosition.BOTTOM,
                                );

                                // assignVehicleAndDriverC
                                //     .postAssignVehicleDriver();
                              },
                        // onTap: () {
                        //   assignVehicleAndDriverC.postAssignVehicleDriver();

                        //   Get.snackbar(
                        //     'Status',
                        //     'Logistics Assigned',
                        //     colorText: AppTheme.black,
                        //     backgroundColor: AppTheme.appHomePageColor,
                        //     snackPosition: SnackPosition.BOTTOM,
                        //   );
                        // },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color:
                                assignVehicleAndDriverC.modelList.isNotEmpty &&
                                        assignVehicleAndDriverC.modelList[0]
                                            .driverFullname!.isNotEmpty
                                    ? hexToColor('#007BEC')
                                    : hexToColor('#007BEC').withOpacity(.5),
                          ),
                          child: Center(
                            child: assignVehicleAndDriverC.isLoading.value
                                ? Loading(
                                    color: Colors.white,
                                  )
                                : KText(
                                    text: 'Confirm',
                                    color: Colors.white,
                                    bold: true,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
    );
  }
}

class Materials extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => assignVehicleAndDriverC.transportOrderLines.isEmpty
          ? Center(child: Loading())
          : Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: assignVehicleAndDriverC.transportOrderLines.length,
                itemBuilder: (BuildContext context, int index) {
                  final item =
                      assignVehicleAndDriverC.transportOrderLines[index];
                  return Obx(
                    () => GestureDetector(
                      onTap: () => materialC.isExpanded.toggle(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12),
                        // height: materialC.isExpanded.value ? 200 : 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: hexToColor('#DBECFB'), width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: Get.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(12),
                                  // border: Border.all(),
                                  color: hexToColor('#DBECFB')),
                              child: Row(
                                children: [
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.check_box_outlined,
                                    color: hexToColor('#84BEF3'),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    flex: 5,
                                    child: KText(
                                      text:
                                          '${item!.productName} (${item.productCode})',
                                      bold: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: Icon(
                                      materialC.isExpanded.value
                                          ? EvaIcons.arrowIosUpwardOutline
                                          : EvaIcons.arrowIosDownwardOutline,
                                      color: hexToColor('#80939D'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      KText(
                                        text: 'Serial Number',
                                        color: hexToColor('#80939D'),
                                      ),
                                      KText(
                                        text: 'Weight',
                                        color: hexToColor('#80939D'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //  KText(text: '${item.productSerial}'),
                                      KText(
                                        text: item.productSerial != null
                                            ? '${item.productSerial} '
                                            : '',
                                      ),
                                      KText(text: '${item.weightKg}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: hexToColor('#DBECFB')),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: 'Quantity',
                                    color: hexToColor('#80939D'),
                                  ),
                                  Row(
                                    children: [
                                      Text('${item.baseUomQuantity} '),
                                      Text(item.baseUom != null
                                          ? ' ${item.baseUom}'
                                          : ''),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
