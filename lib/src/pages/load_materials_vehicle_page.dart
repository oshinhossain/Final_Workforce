// ignore_for_file: unused_local_variable, duplicate_ignore

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/user_avatar.dart';

import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../config/base.dart';
import '../config/constants.dart';
import '../controllers/location_controller.dart';
import '../controllers/user_controller.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/load_materials_to_vehicle.dart';

class LoadMaterialsVehiclePage extends StatefulWidget {
  final String? transportOrderNo;
  final bool? isFromNotification;

  LoadMaterialsVehiclePage({this.transportOrderNo, this.isFromNotification});

  @override
  // ignore: library_private_types_in_public_api
  _LoadMaterialsVehiclePageState createState() =>
      _LoadMaterialsVehiclePageState();
}

class _LoadMaterialsVehiclePageState extends State<LoadMaterialsVehiclePage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  //TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );

    //***************************************//
    if (widget.transportOrderNo != null && widget.isFromNotification! != null) {
      loadMaterialsToVehicleC.getTransportOrder(
        transportOrderNo: widget.transportOrderNo!,
      );
      loadMaterialsToVehicleC.getTransportOrderVehicle(
        transportOrderNo: widget.transportOrderNo!,
      );
      loadMaterialsToVehicleC.getItemListByTransportOrderNo(
        transportOrderNo: widget.transportOrderNo!,
      );
    } else {
      // loadMaterialsToVehicleC.getTransportOrder(
      //   transportOrderNo: '221026.00005',
      // );
      // loadMaterialsToVehicleC.getTransportOrderVehicle(
      //   transportOrderNo: '221026.00005',
      // );
      // loadMaterialsToVehicleC.getItemListByTransportOrderNo(
      //   transportOrderNo: '221026.00005',
      // );
    }
  }

  @override
  void dispose() {
    super.dispose();
    loadMaterialsToVehicleC.data.clear();
    loadMaterialsToVehicleC.loadMaterialsVehicleItems.clear();
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
            text: 'Load Materials to Vehicle',
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
            Evidence(),
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
                  : _activeIndex == 2
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
                  left: BorderSide(width: 1, color: hexToColor('#EEF0F6'))),
            ),
            child: Tab(text: 'Materials'),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 1,
                  color: hexToColor('#EEF0F6'),
                ),
              ),
            ),
            child: Tab(text: 'Evidence'),
          ),
        ],
      );
}

Widget searchTransportOrder() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 2,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          child: KText(
            text: 'Data',
            fontSize: 15,
            bold: true,
            color: hexToColor('#515D64'),
          ),
        ),
      ),
      Divider(
        color: hexToColor('#DBECFB'),
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 15,
          left: 10,
        ),
        child: KText(
          text: 'Source Location',
          fontSize: 15,
          bold: true,
          color: hexToColor('#515D64'),
        ),
      ),
      Divider(
        color: hexToColor('#DBECFB'),
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 15,
          left: 10,
        ),
        child: KText(
          text: 'Destination Location',
          fontSize: 15,
          bold: true,
          color: hexToColor('#515D64'),
        ),
      ),
      Divider(
        color: hexToColor('#DBECFB'),
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 15,
          left: 10,
        ),
        child: KText(
          text: 'Transport Party',
          fontSize: 15,
          bold: true,
          color: hexToColor('#515D64'),
        ),
      ),
      Divider(
        color: hexToColor('#DBECFB'),
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 15,
          left: 10,
        ),
        child: KText(
          text: 'Receiving Party',
          fontSize: 15,
          bold: true,
          color: hexToColor('#515D64'),
        ),
      ),
      Divider(
        color: hexToColor('#DBECFB'),
        height: 2,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 5,
          top: 15,
          left: 10,
        ),
      ),
    ],
  );
}

void openBottomSheet() {
  Get.bottomSheet(
    isScrollControlled: true,

    //persistent: true,
    SingleChildScrollView(
      child: Container(
        height: 600,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: KText(
                text: 'Select Transport Order by',
                fontSize: 16,
                bold: true,
                color: hexToColor('#41525A'),
              ),
            ),

            TextField(
              enabled: true,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: 7,
                    width: 7,
                    child: SvgPicture.asset(
                      '${Constants.svgPath}/icon_search_elements.svg',
                      height: 5,
                      width: 5,
                      fit: BoxFit.scaleDown,
                      color: hexToColor('#66A1D9'),
                    ),
                  ),
                ),
                focusedBorder: InputBorder.none,
                errorText: '',
                hintText: 'Show Transport Order by',
              ),
            ),

            // OutlinedButton(
            //   onPressed: () {
            //     Get.back();
            //   },
            //   child: Text('Close'),
            // ),

            //SerchReceivingPartyComponent(),
            searchTransportOrder(),
          ],
        ),
      ),
    ),

    //backgroundColor: Colors.white,
    elevation: 0,
  );
}

class TextFieldWidget extends StatefulWidget {
  final String title;
  final bool searchIcon;
  final bool avatar;
  final bool hasCheckbox;
  final String srchText;
  final Color? color;

  TextFieldWidget({
    super.key,
    this.searchIcon = true,
    this.avatar = true,
    required this.title,
    //this.enabled = false,
    this.hasCheckbox = false,
    this.color,
    required this.srchText,
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
      padding: EdgeInsets.only(left: 15, right: 15),
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
                              child: RenderSvg(path: 'avatar_placeholder'),
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
          Divider(color: Colors.black),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BasicData extends StatelessWidget with Base {
  final username = Get.put(UserController()).username;
  // ignore: annotate_overrides, overridden_fields
  final locationC = Get.put(LocationController());
  final _listViewKey = GlobalKey();
  final ScrollController _scroller = ScrollController();
  bool isDragging = false;
  @override
  Widget build(BuildContext context) {
    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Obx(
      () => loadMaterialsToVehicleC.transportOrderVehicle.isEmpty &&
              loadMaterialsToVehicleC.transportOrder.value == null &&
              loadMaterialsToVehicleC.transportOrderItemList.isEmpty
          ? Center(child: Loading())
          : ListView(
              key: _listViewKey,
              controller: _scroller,
              children: [
                SizedBox(
                  height: 22,
                ),
                if (loadMaterialsToVehicleC.transportOrder.value != null)
                  Builder(builder: (context) {
                    final item = loadMaterialsToVehicleC.transportOrder.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          color: hexToColor('#FFFFFF'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'Transport Order',
                                        fontSize: 14,
                                        color: hexToColor('#80939D'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  KText(
                                    text: '${item!.transportOrderNo}',
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  KText(
                                    text: 'Date',
                                    fontSize: 14,
                                    color: hexToColor('#80939D'),
                                  ),
                                  SizedBox(height: 5),
                                  KText(
                                    text: formatDate(
                                        date: item.transportOrderDate!),
                                  ),
                                ],
                              ),
                            ],
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
                          title: 'Receiving Party',
                          srchText: '${item.transporterAgencyName}',
                        ),
                        TextFieldWidget(
                          avatar: false,
                          title: 'Source Location (Loading point)',
                          srchText: '${item.sourceLocName}',
                        ),
                        // TextFieldWidget(
                        //   hasCheckbox: false,
                        //   title: 'Goods Inspector at the Loading Point',
                        //   srchText: '${item.inspectorAtLoadingPointFullname}',
                        //   // searchIcon: false,
                        // ),

                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: KText(
                            text: 'Goods Inspector at the Loading Point',
                            fontSize: 13,
                            color: hexToColor('#80939D'),
                          ),
                        ),
                        if (item.inspectorAtLoadingPointFullname != null &&
                            item.inspectorAtLoadingPointFullname!.isNotEmpty)
                          Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              item.inspectorAtLoadingPointUsername != null
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
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.inspectorAtLoadingPointUsername}&appCode=KYC&fileCategory=photo&countryCode=BD',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : UserAvatar(),
                              SizedBox(
                                width: 10,
                              ),
                              KText(
                                text: item.inspectorAtLoadingPointFullname,
                                fontSize: 15,
                                color: AppTheme.textColor,
                              )
                            ],
                          ),

                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Divider(color: Colors.black),
                        ),
                      ],
                    );
                  }),
                if (loadMaterialsToVehicleC.transportOrderVehicle.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                                '${Constants.svgPath}/trucklogo.svg'),
                            SizedBox(
                              width: 5,
                            ),
                            KText(
                              text: 'Load Vehicles',
                              fontSize: 14,
                              color: hexToColor('#41525A'),
                              bold: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        DottedLine(
                          lineThickness: 0.1,
                          dashColor: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: loadMaterialsToVehicleC
                              .transportOrderVehicle.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = loadMaterialsToVehicleC
                                .transportOrderVehicle[index];
                            return Obx(
                              () => Container(
                                // height: 148,
                                // width: double.infinity,
                                margin: EdgeInsets.only(bottom: 15),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: hexToColor('#FFFFFF'),
                                  border: Border.all(
                                    width: 1,
                                    color: hexToColor('#FFE9CF'),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 34,
                                      width: double.infinity,
                                      // color: hexToColor('#FFE9CF'),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        color: hexToColor('#FFE9CF'),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 5, left: 15, top: 5),
                                            child: KText(
                                              text: '${item.registrationNo}',
                                              fontSize: 16,
                                              color: hexToColor('#41525A'),
                                              bold: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: 'Type: ',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#80939D'),
                                                      bold: false,
                                                    ),
                                                    Expanded(
                                                      child: KText(
                                                        text:
                                                            '${item.vehicleType}',
                                                        fontSize: 14,
                                                        color: hexToColor(
                                                            '#41525A'),
                                                        bold: false,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: 'Capacity: ',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#80939D'),
                                                      bold: false,
                                                      maxLines: 2,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          KText(
                                                            text: item.weightCapacity !=
                                                                    null
                                                                ? '${item.weightCapacity} '
                                                                : '',
                                                            fontSize: 14,
                                                            color: hexToColor(
                                                                '#41525A'),
                                                            bold: false,
                                                            maxLines: 2,
                                                          ),
                                                          KText(
                                                            text: item.weightCapacityUnit !=
                                                                    null
                                                                ? '${item.weightCapacityUnit}'
                                                                : '',
                                                            fontSize: 14,
                                                            color: hexToColor(
                                                                '#41525A'),
                                                            bold: false,
                                                            maxLines: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: 'Brand: ',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#80939D'),
                                                      bold: false,
                                                    ),
                                                    Expanded(
                                                      child: KText(
                                                        text: '${item.brand}',
                                                        fontSize: 14,
                                                        color: hexToColor(
                                                            '#41525A'),
                                                        bold: false,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    KText(
                                                      text: 'Driver: ',
                                                      fontSize: 14,
                                                      color:
                                                          hexToColor('#80939D'),
                                                      bold: false,
                                                    ),
                                                    Expanded(
                                                      child: KText(
                                                        text:
                                                            '${item.driverFullname}',
                                                        fontSize: 14,
                                                        color: hexToColor(
                                                            '#41525A'),
                                                        bold: false,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   padding: EdgeInsets.only(
                                          //       top: 10, left: 5, right: 16),
                                          //   decoration: BoxDecoration(
                                          //       borderRadius:
                                          //           BorderRadius.circular(8),
                                          //       color: Colors.white60),
                                          //   child: SizedBox(
                                          //       height: 100,
                                          //       width: 140,
                                          //       child: ClipRRect(
                                          //         borderRadius:
                                          //             BorderRadius.circular(5),
                                          //         child: assignVehicleAndDriverC
                                          //                     .vechileImageCount[assignVehicleAndDriverC
                                          //                         .vechileImageCount
                                          //                         .indexWhere((element) =>
                                          //                             element
                                          //                                 .regNo ==
                                          //                             item.registrationNo)]
                                          //                     .imageCount ==
                                          //                 '0'
                                          //             ? RenderSvg(
                                          //                 path: 'image_vehicle',
                                          //               )
                                          //             : Image.network(
                                          //                 '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=${locationC.latLng}&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item.id}&originalFileNameNeeded=&registrationNo=${item.registrationNo}&status=&flag=1',

                                          //                 // '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}',
                                          //                 fit: BoxFit.cover,
                                          //                 height: 100,
                                          //                 width: 140,
                                          //               ),
                                          //       )

                                          //       //// kLog("snapshot.data paichi ");
                                          //       //kLog(snapshot.data);
                                          //       // if (snapshot
                                          //       //         .data.statusCode ==
                                          //       //     '200') {
                                          //       //   return ClipRRect(
                                          //       //     borderRadius:
                                          //       //         BorderRadius.circular(
                                          //       //             5),
                                          //       //     child: Image.network(
                                          //       //       '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=${locationC.latLng}&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&projectId=&geoLevelId=&siteId=&activityId=&supportId=&progressId=&ids=${item.id}&originalFileNameNeeded=&registrationNo=${item.registrationNo}&status=&flag=1',

                                          //       //       // '${dotenv.env['BASE_URL_WFC']}/v1/attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&appCode=ITS&countryCode=BD&latLng=23.90560,93.094535&username=$username&fileCategory=FILE_CATEGORY_VEHICLE_PHOTO&ids=&originalFileNameNeeded=&registrationNo=&status=$status&flag=${i + 1}',
                                          //       //       fit: BoxFit.cover,
                                          //       //       height: 160,
                                          //       //       width: 200,
                                          //       //     ),
                                          //       //   );
                                          //       // }
                                          //       // if (snapshot
                                          //       //         .data.statusCode ==
                                          //       //     '500') {
                                          //       //   return RenderSvg(
                                          //       //     path: 'image_vehicle',
                                          //       //   );
                                          //       // } else {
                                          //       // return RenderSvg(
                                          //       //   path: 'image_vehicle',
                                          //       // );
                                          //       // }
                                          //       ),
                                          // ),

                                          SizedBox(
                                            height: 100,
                                            width: 140,
                                            child: RenderSvg(
                                              path: 'image_vehicle',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Row(
                                        children: [
                                          RenderSvg(path: 'icon_bill'),
                                          SizedBox(width: 5),
                                          Row(
                                            children: [
                                              KText(
                                                text: 'BOQ ',
                                                fontSize: 14,
                                                color: hexToColor('#41525A'),
                                                bold: true,
                                              ),
                                              KText(
                                                text: '(Bill of Quantity)',
                                                fontSize: 14,
                                                color: hexToColor('#80939D'),
                                                bold: false,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: DottedLine(
                                        lineThickness: 0.1,
                                        dashColor: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    if (loadMaterialsToVehicleC
                                        .getListItemFormVehicleItemList(
                                            item.registrationNo!)
                                        .isNotEmpty)
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: loadMaterialsToVehicleC
                                              .getListItemFormVehicleItemList(
                                                  item.registrationNo!)
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final vehicleItem = loadMaterialsToVehicleC
                                                .getListItemFormVehicleItemList(
                                                    item.registrationNo!)[index];
                                            return
                                                // Obx(
                                                //   () =>
                                                Container(
                                              margin: EdgeInsets.only(top: 12),
                                              //
                                              // height:
                                              //     materialC.isExpanded.value
                                              //         ? 200
                                              //         : 150,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        hexToColor('#DBECFB'),
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width,
                                                    height: 40,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          hexToColor('#DBECFB'),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 6,
                                                          child: KText(
                                                            text:
                                                                '${vehicleItem.vehicleItems!.productName} (${vehicleItem.vehicleItems!.productCode})',
                                                            bold: true,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              SizedBox(
                                                                height: 30.0,
                                                                width: 30.0,
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    loadMaterialsToVehicleC
                                                                        .transportOrderItemList
                                                                        .add(
                                                                            LoadMaterialsItemList(
                                                                      id: vehicleItem
                                                                          .vehicleItems!
                                                                          .id,
                                                                      productId: vehicleItem
                                                                          .vehicleItems!
                                                                          .productId,
                                                                      productCode: vehicleItem
                                                                          .vehicleItems!
                                                                          .productCode,
                                                                      productName: vehicleItem
                                                                          .vehicleItems!
                                                                          .productName,
                                                                      weightKg: vehicleItem
                                                                          .vehicleItems!
                                                                          .weightKg,
                                                                      baseUom: vehicleItem
                                                                          .vehicleItems!
                                                                          .baseUom,
                                                                      baseUomQuantity: vehicleItem
                                                                          .vehicleItems!
                                                                          .loadedQuantity,
                                                                      lineNo: vehicleItem
                                                                          .vehicleItems!
                                                                          .lineNo,
                                                                      productSerial: vehicleItem
                                                                          .vehicleItems!
                                                                          .productSerial,
                                                                      distanceKm: vehicleItem
                                                                          .vehicleItems!
                                                                          .distanceKm,
                                                                    ));

                                                                    loadMaterialsToVehicleC
                                                                        .loadMaterialsVehicleItems
                                                                        .removeWhere((element) =>
                                                                            element.registrationNo ==
                                                                            vehicleItem.registrationNo);
                                                                  },
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0.0),
                                                                  icon: RenderSvg(
                                                                      path:
                                                                          'icon_delete'),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 3),
                                                              SizedBox(
                                                                height: 30.0,
                                                                width: 30.0,
                                                                child:
                                                                    IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0.0),
                                                                  icon: Icon(
                                                                    materialC
                                                                            .isExpanded
                                                                            .value
                                                                        ? EvaIcons
                                                                            .arrowIosUpwardOutline
                                                                        : EvaIcons
                                                                            .arrowIosDownwardOutline,
                                                                    color: hexToColor(
                                                                        '#80939D'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        KText(
                                                          text: 'Weight',
                                                          fontSize: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 70,
                                                              child:
                                                                  TextFormField(
                                                                // inputFormatters: <
                                                                //     TextInputFormatter>[
                                                                //   FilteringTextInputFormatter
                                                                //       .digitsOnly
                                                                // ],
                                                                readOnly: true,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                initialValue:
                                                                    '${vehicleItem.vehicleItems!.weightKg! == 0 ? '' : vehicleItem.vehicleItems!.weightKg!}',
                                                                onChanged:
                                                                    (value) {
                                                                  // if (value
                                                                  //     .isNotEmpty) {
                                                                  //   loadMaterialsToVehicleC
                                                                  //       .updateItem(
                                                                  //     item.id!,
                                                                  //     UpdateLoadMaterialsToVehicleInputType
                                                                  //         .quantity,
                                                                  //     double.parse(
                                                                  //         value),
                                                                  //   );
                                                                  // } else {
                                                                  //   loadMaterialsToVehicleC
                                                                  //       .updateItem(
                                                                  //     item.id!,
                                                                  //     UpdateLoadMaterialsToVehicleInputType
                                                                  //         .quantity,
                                                                  //     0.0,
                                                                  //   );
                                                                  // }
                                                                },
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  isDense: true,
                                                                  // hintText: '19',
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              hexToColor('#FF0000')),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: hexToColor(
                                                                          '#DBECFB'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // KText(
                                                            //   text: 'Kg',
                                                            //   fontSize: 15,
                                                            // ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                      color: hexToColor(
                                                          '#DBECFB')),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 8,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        KText(
                                                          text: 'Quantity',
                                                          fontSize: 15,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 70,
                                                              child:
                                                                  TextFormField(
                                                                // inputFormatters: <
                                                                //     TextInputFormatter>[
                                                                //   FilteringTextInputFormatter
                                                                //       .digitsOnly
                                                                // ],
                                                                readOnly: true,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                onChanged:
                                                                    (v) {},
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                initialValue: vehicleItem
                                                                    .vehicleItems!
                                                                    .loadedQuantity!
                                                                    .toString(),
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  isDense: true,
                                                                  // hintText: '19',
                                                                  labelStyle:
                                                                      TextStyle(
                                                                          color:
                                                                              hexToColor('#FF0000')),
                                                                  enabledBorder:
                                                                      UnderlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: hexToColor(
                                                                          '#DBECFB'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // KText(
                                                            //   text: 'Pcs',
                                                            //   fontSize: 15,
                                                            // ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // ),
                                            );
                                          },
                                        ),
                                      ),
                                    Container(
                                      padding: EdgeInsets.all(15),
                                      child: DragTarget<LoadMaterialsItemList>(
                                        onAccept: (data) {
                                          // kLog(item.registrationNo);
                                          loadMaterialsToVehicleC
                                              .addListItemToVehicle(
                                            regId: item.registrationNo!,
                                            item: data,
                                          );

                                          loadMaterialsToVehicleC
                                              .transportOrderItemList
                                              .removeWhere(
                                                  (e) => e.id == data.id);
                                          //// kLog(item);
                                        },
                                        builder: (context, candidateData,
                                                rejectedData) =>
                                            DottedBorder(
                                          color: candidateData.isNotEmpty
                                              ? Colors.blueAccent
                                              : hexToColor('#FFE1BF'),
                                          strokeWidth: 2,
                                          dashPattern: [4, 4],
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(5),
                                          child: Container(
                                            height: 130,
                                            width: double.infinity,
                                            color: candidateData.isNotEmpty
                                                ? Colors.blueAccent
                                                    .withOpacity(.2)
                                                : hexToColor('#FFFBF7'),
                                            child: Center(
                                              child: KText(
                                                text: '(Drop Items Here)',
                                                color: hexToColor('#9BA9B3'),
                                              ),
                                            ),

                                            //background color of inner container
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 5),
                if (loadMaterialsToVehicleC.transportOrderItemList.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            RenderSvg(path: 'icon_product_list'),
                            SizedBox(width: 5),
                            KText(
                              text: 'List of Items',
                              fontSize: 14,
                              color: Colors.black87,
                              bold: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        DottedLine(
                          lineThickness: 0.1,
                          dashColor: Colors.black,
                        ),
                        SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: loadMaterialsToVehicleC
                              .transportOrderItemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = loadMaterialsToVehicleC
                                .transportOrderItemList[index];
                            return Obx(
                              () => Listener(
                                onPointerMove: (PointerMoveEvent event) {
                                  print(
                                      'x: ${event.position.dx}, y: ${event.position.dy}');

                                  if (!isDragging) {
                                    return;
                                  }
                                  RenderBox render = _listViewKey.currentContext
                                      ?.findRenderObject() as RenderBox;
                                  Offset position =
                                      render.localToGlobal(Offset.zero);
                                  double topY = position.dy;
                                  double bottomY = topY + render.size.height;

                                  print('x: ${position.dy}, '
                                      'y: ${position.dy}, '
                                      'height: ${render.size.width}, '
                                      'width: ${render.size.height}');

                                  const detectedRange = 100;
                                  const moveDistance = 3;

                                  if (event.position.dy <
                                      topY + detectedRange) {
                                    var to = _scroller.offset - moveDistance;
                                    to = (to < 0) ? 0 : to;
                                    _scroller.jumpTo(to);
                                  }
                                  if (event.position.dy >
                                      bottomY - detectedRange) {
                                    _scroller.jumpTo(
                                        _scroller.offset + moveDistance);
                                  }
                                },
                                child: LongPressDraggable(
                                  data: item,
                                  onDragStarted: () => isDragging = true,
                                  onDragEnd: (details) => isDragging = false,
                                  onDraggableCanceled: (velocity, offset) =>
                                      isDragging = false,
                                  childWhenDragging: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: DottedBorder(
                                      color: Colors.grey[200]!,
                                      strokeWidth: 2,
                                      dashPattern: [4, 4],
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(5),
                                      child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        color: Colors.grey[100]!,
                                      ),
                                    ),
                                  ),
                                  feedback: Container(
                                    width: Get.width / 1.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: hexToColor('#DBECFB'),
                                          width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width,
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: hexToColor('#DBECFB'),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: KText(
                                                  text:
                                                      '${item.productName} (${item.productCode})',
                                                  bold: true,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        print('object');
                                                      },
                                                      child: RenderSvg(
                                                          path: 'icon_copy'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      materialC.isExpanded.value
                                                          ? EvaIcons
                                                              .arrowIosUpwardOutline
                                                          : EvaIcons
                                                              .arrowIosDownwardOutline,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(text: 'Serial No.'),
                                                  KText(
                                                      text: item.productSerial !=
                                                              null
                                                          ? '${item.productSerial}'
                                                          : ''),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(text: 'Weight'),
                                                  KText(
                                                      text: '${item.weightKg}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(color: hexToColor('#DBECFB')),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              KText(text: 'Quantity'),
                                              Row(
                                                children: [
                                                  KText(
                                                      text: item.baseUomQuantity !=
                                                              null
                                                          ? '${item.baseUomQuantity} '
                                                          : ''),
                                                  KText(
                                                      text: item.baseUom != null
                                                          ? '${item.baseUom}'
                                                          : ''),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12),
                                    // height:
                                    //     materialC.isExpanded.value ? 200 : 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: hexToColor('#DBECFB'),
                                          width: 2),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width,
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: hexToColor('#DBECFB'),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: KText(
                                                  text:
                                                      '${item.productName} (${item.productCode})',
                                                  bold: true,
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        print('object');
                                                      },
                                                      child: RenderSvg(
                                                          path: 'icon_copy'),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      materialC.isExpanded.value
                                                          ? EvaIcons
                                                              .arrowIosUpwardOutline
                                                          : EvaIcons
                                                              .arrowIosDownwardOutline,
                                                      color:
                                                          hexToColor('#80939D'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(text: 'Serial No.'),
                                                  KText(
                                                      text: item.productSerial !=
                                                              null
                                                          ? '${item.productSerial}'
                                                          : ''),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  KText(text: 'Weight'),
                                                  KText(
                                                      text: '${item.weightKg}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(color: hexToColor('#DBECFB')),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Quantity'),
                                              Row(
                                                children: [
                                                  Text(
                                                      '${item.baseUomQuantity} '),
                                                  Text(item.baseUom != null
                                                      ? '${item.baseUom}'
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
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(text: 'Remarks'),
                      TextField(
                        onChanged: loadMaterialsToVehicleC.remarks,
                        decoration: InputDecoration(
                          hintText: 'Remarks Here..',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                      Divider(color: Colors.black),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
                          // showTopSnackBar(
                          //   context,
                          //   CustomSnackBar.error(
                          //     message: 'Canceled',
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
                        onTap: loadMaterialsToVehicleC
                                .loadMaterialsVehicleItems.isNotEmpty
                            ? () {
                                // loadMaterialsToVehicleC.postLoadMaterialsVehicles();

                                final vehcleItem = loadMaterialsToVehicleC
                                    .loadMaterialsVehicleItems
                                    .map((item) => item.vehicleItems);
                                if (vehcleItem.isNotEmpty) {
                                  loadMaterialsToVehicleC
                                      .postLoadMaterialsVehicles();
                                  for (var element in loadMaterialsToVehicleC
                                      .transportOrderVehicle) {
                                    loadMaterialsToVehicleC
                                        .postEvidenceAttachment(
                                            registrationNo:
                                                element.registrationNo!,
                                            id: element.transportOrderId!);
                                  }
                                } else {
                                  // push(ConfirmTransportPage());

                                  Get.snackbar(
                                    'Status',
                                    'Loaded',
                                    colorText: AppTheme.black,
                                    backgroundColor: AppTheme.appHomePageColor,
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                }
                              }
                            : () {
                                print('object');
                              },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: loadMaterialsToVehicleC
                                    .loadMaterialsVehicleItems.isNotEmpty
                                ? hexToColor('#007BEC')
                                : hexToColor('#007BEC').withOpacity(.5),
                          ),
                          child: Center(
                            child: loadMaterialsToVehicleC.isLoading.value
                                ? Loading(color: Colors.white)
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
                Container(
                  height: 50,
                )
              ],
            ),
    );
  }
}

// class BasicData2 extends StatelessWidget with Base {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => loadMaterialsToVehicleC.transportOrderVehicle.isEmpty &&
//               loadMaterialsToVehicleC.transportOrder.value == null &&
//               loadMaterialsToVehicleC.transportOrderItemList.isEmpty
//           ? Center(child: Loading())
//           : ListView(
//               children: [
//                 SizedBox(
//                   height: 22,
//                 ),
//                 if (loadMaterialsToVehicleC.transportOrder.value != null)
//                   Builder(builder: (context) {
//                     final item = loadMaterialsToVehicleC.transportOrder.value;

//                     return Column(
//                       children: [
//                         Container(
//                           width: Get.width,
//                           padding: EdgeInsets.symmetric(horizontal: 15),
//                           color: hexToColor('#FFFFFF'),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       KText(
//                                         text: 'Transport Order',
//                                         fontSize: 14,
//                                         color: hexToColor('#80939D'),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 5),
//                                   KText(
//                                     text: '${item!.transportOrderNo}',
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   KText(
//                                     text: 'Date',
//                                     fontSize: 14,
//                                     color: hexToColor('#80939D'),
//                                   ),
//                                   SizedBox(height: 5),
//                                   KText(
//                                     text: formatDate(
//                                         date: item.transportOrderDate!),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Container(
//                           color: hexToColor('#EBEBEC'),
//                           height: 1,
//                           width: Get.width,
//                         ),
//                         SizedBox(height: 10),
//                         TextFieldWidget(
//                           avatar: false,
//                           title: 'Receiving Party',
//                           srchText: '${item.transporterAgencyName}',
//                         ),
//                         TextFieldWidget(
//                           avatar: false,
//                           title: 'Source Location (Loading point)',
//                           srchText: '${item.sourceLocName}',
//                         ),
//                         // TextFieldWidget(
//                         //   hasCheckbox: false,
//                         //   title: 'Goods Inspector at the Loading Point',
//                         //   srchText: '${item.inspectorAtLoadingPointFullname}',
//                         //   // searchIcon: false,
//                         // ),
//                         KText(
//                           text: 'Goods Inspector at the Loading Point',
//                           fontSize: 18,
//                           color: hexToColor('#80939D'),
//                         ),
//                         if (item.inspectorAtLoadingPointFullname != null &&
//                             item.inspectorAtLoadingPointFullname!.isNotEmpty)
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               item.inspectorAtLoadingPointFullname != null
//                                   ? Container(
//                                       height: 38,
//                                       width: 38,
//                                       padding: EdgeInsets.all(2),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.grey,
//                                               offset: Offset(0, 0),
//                                               blurRadius: 2.0,
//                                             ),
//                                           ]),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(50),
//                                         child: Image.network(
//                                           '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=23.90560,93.094535&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${item.inspectorAtLoadingPointFullname}&appCode=KYC&fileCategory=photo&countryCode=BD',
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     )
//                                   : CircleAvatar(
//                                       backgroundColor: AppTheme.color4,
//                                       radius: 45,
//                                       child:
//                                           RenderSvg(path: 'avatar_placeholder'),
//                                     ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               KText(
//                                 text: item.inspectorAtLoadingPointFullname,
//                                 fontSize: 15,
//                                 color: AppTheme.textColor,
//                               )
//                             ],
//                           ),
//                       ],
//                     );
//                   }),
//                 if (loadMaterialsToVehicleC.transportOrderVehicle.isNotEmpty)
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             SvgPicture.asset(
//                                 '${Constants.svgPath}/trucklogo.svg'),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             KText(
//                               text: 'Load Vehicles',
//                               fontSize: 14,
//                               color: hexToColor('#41525A'),
//                               bold: true,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 6),
//                         DottedLine(
//                           lineThickness: 0.1,
//                           dashColor: Colors.black,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           primary: false,
//                           itemCount: loadMaterialsToVehicleC
//                               .transportOrderVehicle.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final item = loadMaterialsToVehicleC
//                                 .transportOrderVehicle[index];
//                             return Obx(
//                               () => Container(
//                                 // height: 148,
//                                 // width: double.infinity,
//                                 margin: EdgeInsets.only(bottom: 15),
//                                 decoration: BoxDecoration(
//                                   // borderRadius: BorderRadius.all(Radius.circular(5)),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5)),
//                                   color: hexToColor('#FFFFFF'),
//                                   border: Border.all(
//                                     width: 1,
//                                     color: hexToColor('#FFE9CF'),
//                                   ),
//                                 ),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: 34,
//                                       width: double.infinity,
//                                       // color: hexToColor('#FFE9CF'),
//                                       decoration: BoxDecoration(
//                                         // borderRadius: BorderRadius.all(Radius.circular(5)),
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(5),
//                                           topRight: Radius.circular(5),
//                                         ),
//                                         color: hexToColor('#FFE9CF'),
//                                       ),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(
//                                                 bottom: 5, left: 15, top: 5),
//                                             child: KText(
//                                               text: '${item.registrationNo}',
//                                               fontSize: 16,
//                                               color: hexToColor('#41525A'),
//                                               bold: true,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 15),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     KText(
//                                                       text: 'Type: ',
//                                                       fontSize: 14,
//                                                       color:
//                                                           hexToColor('#80939D'),
//                                                       bold: false,
//                                                     ),
//                                                     Expanded(
//                                                       child: KText(
//                                                         text:
//                                                             '${item.vehicleType}',
//                                                         fontSize: 14,
//                                                         color: hexToColor(
//                                                             '#41525A'),
//                                                         bold: false,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 2),
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     KText(
//                                                       text: 'Capacity: ',
//                                                       fontSize: 14,
//                                                       color:
//                                                           hexToColor('#80939D'),
//                                                       bold: false,
//                                                       maxLines: 2,
//                                                     ),
//                                                     Expanded(
//                                                       child: Row(
//                                                         children: [
//                                                           KText(
//                                                             text: item.weightCapacity !=
//                                                                     null
//                                                                 ? '${item.weightCapacity} '
//                                                                 : '',
//                                                             fontSize: 14,
//                                                             color: hexToColor(
//                                                                 '#41525A'),
//                                                             bold: false,
//                                                             maxLines: 2,
//                                                           ),
//                                                           KText(
//                                                             text: item.weightCapacityUnit !=
//                                                                     null
//                                                                 ? '${item.weightCapacityUnit}'
//                                                                 : '',
//                                                             fontSize: 14,
//                                                             color: hexToColor(
//                                                                 '#41525A'),
//                                                             bold: false,
//                                                             maxLines: 2,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 2),
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     KText(
//                                                       text: 'Brand: ',
//                                                       fontSize: 14,
//                                                       color:
//                                                           hexToColor('#80939D'),
//                                                       bold: false,
//                                                     ),
//                                                     Expanded(
//                                                       child: KText(
//                                                         text: '${item.brand}',
//                                                         fontSize: 14,
//                                                         color: hexToColor(
//                                                             '#41525A'),
//                                                         bold: false,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(height: 2),
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                   children: [
//                                                     KText(
//                                                       text: 'Driver: ',
//                                                       fontSize: 14,
//                                                       color:
//                                                           hexToColor('#80939D'),
//                                                       bold: false,
//                                                     ),
//                                                     Expanded(
//                                                       child: KText(
//                                                         text:
//                                                             '${item.driverFullname}',
//                                                         fontSize: 14,
//                                                         color: hexToColor(
//                                                             '#41525A'),
//                                                         bold: false,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: EdgeInsets.only(
//                                                 top: 14,
//                                                 left: 5,
//                                                 bottom: 12,
//                                                 right: 16),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 color: Colors.white60),
//                                             child: Image.asset(
//                                               '${Constants.imgPath}/truck.png',
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 20),
//                                     Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 10),
//                                       child: Row(
//                                         children: [
//                                           RenderSvg(path: 'icon_bill'),
//                                           SizedBox(width: 5),
//                                           Row(
//                                             children: [
//                                               KText(
//                                                 text: 'BOQ ',
//                                                 fontSize: 14,
//                                                 color: hexToColor('#41525A'),
//                                                 bold: true,
//                                               ),
//                                               KText(
//                                                 text: '(Bill of Quantity)',
//                                                 fontSize: 14,
//                                                 color: hexToColor('#80939D'),
//                                                 bold: false,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 15),
//                                       child: DottedLine(
//                                         lineThickness: 0.1,
//                                         dashColor: Colors.black,
//                                       ),
//                                     ),
//                                     SizedBox(height: 10),
//                                     if (loadMaterialsToVehicleC
//                                         .getListItemFormVehicleItemList(
//                                             item.registrationNo!)
//                                         .isNotEmpty)
//                                       Container(
//                                         margin: EdgeInsets.symmetric(
//                                             horizontal: 15),
//                                         child: ListView.builder(
//                                           shrinkWrap: true,
//                                           primary: false,
//                                           itemCount: loadMaterialsToVehicleC
//                                               .getListItemFormVehicleItemList(
//                                                   item.registrationNo!)
//                                               .length,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             final vehicleItem = loadMaterialsToVehicleC
//                                                 .getListItemFormVehicleItemList(
//                                                     item.registrationNo!)[index];
//                                             return Obx(
//                                               () => GestureDetector(
//                                                 onTap: () => materialC
//                                                     .isExpanded
//                                                     .toggle(),
//                                                 child: Container(
//                                                   margin:
//                                                       EdgeInsets.only(top: 12),
//                                                   //
//                                                   // height:
//                                                   //     materialC.isExpanded.value
//                                                   //         ? 200
//                                                   //         : 150,
//                                                   width: double.infinity,
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: hexToColor(
//                                                             '#DBECFB'),
//                                                         width: 2),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                   ),
//                                                   child: Column(
//                                                     children: [
//                                                       Container(
//                                                         width: Get.width,
//                                                         height: 40,
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 horizontal: 10),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: hexToColor(
//                                                               '#DBECFB'),
//                                                         ),
//                                                         child: Row(
//                                                           children: [
//                                                             Expanded(
//                                                               flex: 6,
//                                                               child: KText(
//                                                                 text:
//                                                                     '${vehicleItem.vehicleItems!.productName} (${vehicleItem.vehicleItems!.productCode})',
//                                                                 bold: true,
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               child: Icon(
//                                                                 materialC
//                                                                         .isExpanded
//                                                                         .value
//                                                                     ? EvaIcons
//                                                                         .arrowIosUpwardOutline
//                                                                     : EvaIcons
//                                                                         .arrowIosDownwardOutline,
//                                                                 color: hexToColor(
//                                                                     '#80939D'),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 12,
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                           left: 10,
//                                                           right: 10,
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             KText(
//                                                               text: 'Weight',
//                                                               fontSize: 15,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SizedBox(
//                                                                   width: 70,
//                                                                   child:
//                                                                       TextFormField(
//                                                                     // inputFormatters: <
//                                                                     //     TextInputFormatter>[
//                                                                     //   FilteringTextInputFormatter
//                                                                     //       .digitsOnly
//                                                                     // ],
//                                                                     readOnly:
//                                                                         true,
//                                                                     keyboardType:
//                                                                         TextInputType
//                                                                             .number,
//                                                                     initialValue:
//                                                                         '${vehicleItem.vehicleItems!.weightKg! == 0 ? '' : vehicleItem.vehicleItems!.weightKg!}',
//                                                                     onChanged:
//                                                                         (value) {
//                                                                       // if (value
//                                                                       //     .isNotEmpty) {
//                                                                       //   loadMaterialsToVehicleC
//                                                                       //       .updateItem(
//                                                                       //     item.id!,
//                                                                       //     UpdateLoadMaterialsToVehicleInputType
//                                                                       //         .quantity,
//                                                                       //     double.parse(
//                                                                       //         value),
//                                                                       //   );
//                                                                       // } else {
//                                                                       //   loadMaterialsToVehicleC
//                                                                       //       .updateItem(
//                                                                       //     item.id!,
//                                                                       //     UpdateLoadMaterialsToVehicleInputType
//                                                                       //         .quantity,
//                                                                       //     0.0,
//                                                                       //   );
//                                                                       // }
//                                                                     },
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     decoration:
//                                                                         InputDecoration(
//                                                                       contentPadding:
//                                                                           EdgeInsets.all(
//                                                                               0),
//                                                                       isDense:
//                                                                           true,
//                                                                       // hintText: '19',
//                                                                       labelStyle:
//                                                                           TextStyle(
//                                                                               color: hexToColor('#FF0000')),
//                                                                       enabledBorder:
//                                                                           UnderlineInputBorder(
//                                                                         borderSide:
//                                                                             BorderSide(
//                                                                           color:
//                                                                               hexToColor('#DBECFB'),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 // KText(
//                                                                 //   text: 'Kg',
//                                                                 //   fontSize: 15,
//                                                                 // ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Divider(
//                                                           color: hexToColor(
//                                                               '#DBECFB')),
//                                                       Padding(
//                                                         padding:
//                                                             EdgeInsets.only(
//                                                           left: 10,
//                                                           right: 10,
//                                                           bottom: 8,
//                                                         ),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             KText(
//                                                               text: 'Quantity',
//                                                               fontSize: 15,
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 SizedBox(
//                                                                   width: 70,
//                                                                   child:
//                                                                       TextFormField(
//                                                                     // inputFormatters: <
//                                                                     //     TextInputFormatter>[
//                                                                     //   FilteringTextInputFormatter
//                                                                     //       .digitsOnly
//                                                                     // ],
//                                                                     readOnly:
//                                                                         true,
//                                                                     keyboardType:
//                                                                         TextInputType
//                                                                             .number,
//                                                                     onChanged:
//                                                                         (v) {},
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     initialValue: vehicleItem
//                                                                         .vehicleItems!
//                                                                         .loadedQuantity!
//                                                                         .toString(),
//                                                                     decoration:
//                                                                         InputDecoration(
//                                                                       contentPadding:
//                                                                           EdgeInsets.all(
//                                                                               0),
//                                                                       isDense:
//                                                                           true,
//                                                                       // hintText: '19',
//                                                                       labelStyle:
//                                                                           TextStyle(
//                                                                               color: hexToColor('#FF0000')),
//                                                                       enabledBorder:
//                                                                           UnderlineInputBorder(
//                                                                         borderSide:
//                                                                             BorderSide(
//                                                                           color:
//                                                                               hexToColor('#DBECFB'),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 // KText(
//                                                                 //   text: 'Pcs',
//                                                                 //   fontSize: 15,
//                                                                 // ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     Container(
//                                       padding: EdgeInsets.all(15),
//                                       child: DottedBorder(
//                                         color: hexToColor('#FFE1BF'),
//                                         strokeWidth: 2,
//                                         dashPattern: [4, 4],
//                                         borderType: BorderType.RRect,
//                                         radius: Radius.circular(5),
//                                         child: Container(
//                                           height: 130,
//                                           width: double.infinity,
//                                           color: hexToColor('#FFFBF7'),
//                                           child: Center(
//                                             child: KText(
//                                               text: '(Drop Items Here)',
//                                               color: hexToColor('#9BA9B3'),
//                                             ),
//                                           ),

//                                           //background color of inner container
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 SizedBox(height: 5),
//                 if (loadMaterialsToVehicleC.transportOrderItemList.isNotEmpty)
//                   Padding(
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             RenderSvg(path: 'icon_product_list'),
//                             SizedBox(width: 5),
//                             KText(
//                               text: 'List of Items',
//                               fontSize: 14,
//                               color: Colors.black87,
//                               bold: true,
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         DottedLine(
//                           lineThickness: 0.1,
//                           dashColor: Colors.black,
//                         ),
//                         SizedBox(height: 8),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           primary: false,
//                           itemCount: loadMaterialsToVehicleC
//                               .transportOrderItemList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final item = loadMaterialsToVehicleC
//                                 .transportOrderItemList[index];
//                             return Obx(
//                               () => GestureDetector(
//                                 onTap: () {
//                                   Get.dialog(
//                                     barrierDismissible: false,
//                                     Dialog(
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.vertical,
//                                         child: Obx(
//                                           () => Column(
//                                             children: [
//                                               Container(
//                                                 padding: EdgeInsets.only(
//                                                     top: 13, bottom: 13),
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   color: hexToColor('#0465BF'),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topLeft: Radius.circular(5),
//                                                     topRight:
//                                                         Radius.circular(5),
//                                                   ),
//                                                   border: Border.all(
//                                                       color:
//                                                           hexToColor('#FFFFFF'),
//                                                       width: 1),
//                                                 ),
//                                                 child: Text(
//                                                   'Select Vehicle',
//                                                   style: TextStyle(
//                                                       fontFamily: 'Manrope',
//                                                       color: Colors.white,
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   color: hexToColor('#FFFFFF'),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     bottomLeft:
//                                                         Radius.circular(5),
//                                                     bottomRight:
//                                                         Radius.circular(5),
//                                                   ),
//                                                 ),
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 15,
//                                                     horizontal: 0),
//                                                 child: Column(
//                                                   children: [
//                                                     Obx(
//                                                       () => Column(
//                                                         children: List.generate(
//                                                           loadMaterialsToVehicleC
//                                                               .transportOrderVehicle
//                                                               .length,
//                                                           (index) => ListTile(
//                                                             title: Row(
//                                                               children: [
//                                                                 SizedBox(
//                                                                   height: 25,
//                                                                   child: Radio(
//                                                                     value: loadMaterialsToVehicleC
//                                                                         .transportOrderVehicle[
//                                                                             index]
//                                                                         .registrationNo!,
//                                                                     groupValue:
//                                                                         loadMaterialsToVehicleC
//                                                                             .vehicleRegNo
//                                                                             .value,
//                                                                     onChanged:
//                                                                         (value) {
//                                                                       loadMaterialsToVehicleC
//                                                                               .vehicleRegNo
//                                                                               .value =
//                                                                           value
//                                                                               as String;
//                                                                     },
//                                                                     activeColor:
//                                                                         Colors
//                                                                             .green,
//                                                                     fillColor: MaterialStateProperty
//                                                                         .all(Colors
//                                                                             .amber),
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   loadMaterialsToVehicleC
//                                                                       .transportOrderVehicle[
//                                                                           index]
//                                                                       .registrationNo
//                                                                       .toString(),
//                                                                   style: Theme.of(
//                                                                           context)
//                                                                       .textTheme
//                                                                       .caption!
//                                                                       .merge(
//                                                                           TextStyle(
//                                                                         color: Colors
//                                                                             .black87,
//                                                                         fontWeight:
//                                                                             FontWeight.w400,
//                                                                         fontSize:
//                                                                             12,
//                                                                       )),
//                                                                 )
//                                                               ],
//                                                             ),
//                                                             dense: true,
//                                                             onTap: () {
//                                                               loadMaterialsToVehicleC
//                                                                       .vehicleRegNo
//                                                                       .value =
//                                                                   loadMaterialsToVehicleC
//                                                                       .transportOrderVehicle[
//                                                                           index]
//                                                                       .registrationNo!;
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 10),
//                                                     Padding(
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal: 15),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .end,
//                                                         children: [
//                                                           Expanded(
//                                                             child:
//                                                                 ElevatedButton(
//                                                               style:
//                                                                   ButtonStyle(
//                                                                 backgroundColor:
//                                                                     MaterialStateProperty.all<
//                                                                             Color>(
//                                                                         hexToColor(
//                                                                             '#FFA133')),
//                                                                 shape: MaterialStateProperty
//                                                                     .all<
//                                                                         RoundedRectangleBorder>(
//                                                                   RoundedRectangleBorder(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             4.0),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               onPressed: () {
//                                                                 loadMaterialsToVehicleC
//                                                                     .vehicleRegNo
//                                                                     .value = '';
//                                                                 Navigator.of(
//                                                                         context)
//                                                                     .pop();
//                                                               },
//                                                               child: Text(
//                                                                 'Cancel ',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Manrope',
//                                                                     fontSize:
//                                                                         16.0,
//                                                                     color: Colors
//                                                                         .white),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(width: 40),
//                                                           Expanded(
//                                                             child:
//                                                                 ElevatedButton(
//                                                               key: Key(
//                                                                   'unique_identifier_submit_button'),
//                                                               style:
//                                                                   ButtonStyle(
//                                                                 backgroundColor: loadMaterialsToVehicleC
//                                                                         .vehicleRegNo
//                                                                         .value
//                                                                         .isNotEmpty
//                                                                     ? MaterialStateProperty.all<
//                                                                             Color>(
//                                                                         hexToColor(
//                                                                             '#007BEC'))
//                                                                     : MaterialStateProperty.all<
//                                                                         Color>(hexToColor(
//                                                                             '#007BEC')
//                                                                         .withOpacity(
//                                                                             0.3)),
//                                                                 shape: MaterialStateProperty
//                                                                     .all<
//                                                                         RoundedRectangleBorder>(
//                                                                   RoundedRectangleBorder(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             5.0),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               onPressed: () {
//                                                                 loadMaterialsToVehicleC
//                                                                     .addListItemToVehicle(
//                                                                   regId: loadMaterialsToVehicleC
//                                                                       .vehicleRegNo
//                                                                       .value,
//                                                                   item: item,
//                                                                 );

//                                                                 loadMaterialsToVehicleC
//                                                                     .vehicleRegNo
//                                                                     .value = '';

//                                                                 loadMaterialsToVehicleC
//                                                                     .transportOrderItemList
//                                                                     .removeWhere((e) =>
//                                                                         e.id ==
//                                                                         item.id);
//                                                                 back();
//                                                               },
//                                                               child: Text(
//                                                                 'Add',
//                                                                 style: TextStyle(
//                                                                     fontFamily:
//                                                                         'Manrope',
//                                                                     fontSize:
//                                                                         16.0,
//                                                                     color: Colors
//                                                                         .white),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 // onTap: () => materialC.isExpanded.toggle(),
//                                 child: Container(
//                                   margin: EdgeInsets.only(top: 12),
//                                   // height:
//                                   //     materialC.isExpanded.value ? 200 : 150,
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(
//                                         color: hexToColor('#DBECFB'), width: 2),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: Get.width,
//                                         height: 40,
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         decoration: BoxDecoration(
//                                           color: hexToColor('#DBECFB'),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 4,
//                                               child: KText(
//                                                 text:
//                                                     '${item.productName} (${item.productCode})',
//                                                 bold: true,
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.end,
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       print('object');
//                                                     },
//                                                     child: RenderSvg(
//                                                         path: 'icon_copy'),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Icon(
//                                                     materialC.isExpanded.value
//                                                         ? EvaIcons
//                                                             .arrowIosUpwardOutline
//                                                         : EvaIcons
//                                                             .arrowIosDownwardOutline,
//                                                     color:
//                                                         hexToColor('#80939D'),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 12,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 10, right: 16),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 KText(text: 'Serial No.'),
//                                                 KText(
//                                                     text: item.productSerial !=
//                                                             null
//                                                         ? '${item.productSerial}'
//                                                         : ''),
//                                               ],
//                                             ),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 KText(text: 'Weight'),
//                                                 KText(text: '${item.weightKg}'),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Divider(color: hexToColor('#DBECFB')),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 10, right: 10, bottom: 8),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text('Quantity'),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                     '${item.baseUomQuantity} '),
//                                                 Text(item.baseUom != null
//                                                     ? '${item.baseUom}'
//                                                     : ''),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFieldWidget(
//                   avatar: false,
//                   title: 'Remarks',
//                   srchText: 'Remarks Here',
//                   color: hexToColor('#D9D9D9'),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
//                   height: 40,
//                   width: Get.width,
//                   // margin: EdgeInsets.symmetric(vertical: .5),

//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),

//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           showTopSnackBar(
//                             context,
//                             CustomSnackBar.error(
//                               message: 'Canceled',
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6),
//                             color: hexToColor('#FFA133'),
//                           ),
//                           child: Center(
//                             child: KText(
//                               text: 'Cancel',
//                               color: Colors.white,
//                               bold: true,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: loadMaterialsToVehicleC
//                                 .loadMaterialsVehicleItems.isNotEmpty
//                             ? () {
//                                 // loadMaterialsToVehicleC.postLoadMaterialsVehicles();

//                                 final vehcleItem = loadMaterialsToVehicleC
//                                     .loadMaterialsVehicleItems
//                                     .map((item) => item.vehicleItems);
//                                 if (vehcleItem.isNotEmpty) {
//                                   loadMaterialsToVehicleC
//                                       .postLoadMaterialsVehicles();
//                                   for (var element in loadMaterialsToVehicleC
//                                       .transportOrderVehicle) {
//                                     loadMaterialsToVehicleC
//                                         .postEvidenceAttachment(
//                                             registrationNo:
//                                                 element.registrationNo!,
//                                             id: element.transportOrderId!);
//                                   }
//                                 } else {
//                                   // push(ConfirmTransportPage());

//                                   Get.snackbar(
//                                     'Status',
//                                     'Loaded',
//                                     colorText: AppTheme.black,
//                                     backgroundColor: AppTheme.appHomePageColor,
//                                     snackPosition: SnackPosition.BOTTOM,
//                                   );
//                                 }
//                               }
//                             : () {
//                                 print('object');
//                               },
//                         child: Container(
//                           height: 40,
//                           width: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(6),
//                             color: loadMaterialsToVehicleC
//                                     .loadMaterialsVehicleItems.isNotEmpty
//                                 ? hexToColor('#007BEC')
//                                 : hexToColor('#007BEC').withOpacity(.5),
//                           ),
//                           child: Center(
//                             child: loadMaterialsToVehicleC.isLoading.value
//                                 ? Loading(color: Colors.white)
//                                 : KText(
//                                     text: 'Confirm',
//                                     color: Colors.white,
//                                     bold: true,
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 50,
//                 )
//               ],
//             ),
//     );
//   }
// }

class Materials extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => loadMaterialsToVehicleC.transportOrderItemList.isEmpty
          ? loadMaterialsToVehicleC.isLoading.value
              ? SizedBox(
                  height: Get.height / 1.5,
                  child: Center(
                    child: Loading(),
                  ),
                )
              : SizedBox(
                  height: Get.height / 1.5,
                  child: Center(child: KText(text: 'No data found')),
                )
          : Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount:
                    loadMaterialsToVehicleC.transportOrderItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  final item =
                      loadMaterialsToVehicleC.transportOrderItemList[index];
                  return GestureDetector(
                    onTap: () => materialC.isExpanded.toggle(),
                    child: Container(
                      margin: EdgeInsets.only(top: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: hexToColor('#DBECFB'),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Get.width,
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: hexToColor('#DBECFB'),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: KText(
                                    text:
                                        '${item.productName} (${item.productCode})',
                                    bold: true,
                                  ),
                                ),
                                // Spacer(),
                                Row(
                                  children: [
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     // loadMaterialsToVehicleC
                                    //     //     .addTransportOrderItemList
                                    //     //     .add(item);
                                    //     // loadMaterialsToVehicleC
                                    //     //     .transportOrderItemList
                                    //     //     .removeAt(index);
                                    //   },
                                    //   child: RenderSvg(path: 'icon_copy'),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Icon(
                                    //   materialC.isExpanded.value
                                    //       ? EvaIcons.arrowIosUpwardOutline
                                    //       : EvaIcons.arrowIosDownwardOutline,
                                    //   color: hexToColor('#80939D'),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Serial No.'),
                                    KText(
                                        text: item.productSerial != null
                                            ? '${item.productSerial}'
                                            : ''),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Weight'),
                                    Text('${item.weightKg}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(color: hexToColor('#DBECFB')),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity'),
                                Row(
                                  children: [
                                    Text('${item.baseUomQuantity} '),
                                    Text(item.baseUom != null
                                        ? '${item.baseUom}'
                                        : ''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class Evidence extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Obx(
          () => Column(
            children: [
              ListView.builder(
                itemCount: loadMaterialsToVehicleC.transportOrderVehicle.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  final item =
                      loadMaterialsToVehicleC.transportOrderVehicle[index];
                  return Obx(
                    () => Container(
                      margin: EdgeInsets.only(bottom: 15),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border:
                            Border.all(width: 1, color: hexToColor('#FFE9CF')),
                        color: hexToColor('#FFFFFF'),
                      ),
                      child: Column(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 14,
                                        ),
                                        RenderSvg(path: 'trucklogo'),
                                        // SvgPicture.asset(
                                        //     '${Constants.svgPath}/trucklogo.svg'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        KText(
                                          text: '${item.registrationNo}',
                                          fontSize: 16,
                                          color: hexToColor('#41525A'),
                                          bold: true,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          loadMaterialsToVehicleC
                                              .pickEvidenceImageByRegNo(
                                                  regNo: item.registrationNo!);
                                        },
                                        child: RenderSvg(path: 'icon_add_box'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              loadMaterialsToVehicleC
                                      .getEvidenceByRegNo(
                                          regNo: item.registrationNo!)
                                      .isEmpty
                                  ? SizedBox()
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: loadMaterialsToVehicleC
                                          .getEvidenceByRegNo(
                                              regNo: item.registrationNo
                                                  .toString())
                                          .length,
                                      primary: false,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final image = loadMaterialsToVehicleC
                                            .getEvidenceByRegNo(
                                                regNo: item.registrationNo
                                                    .toString())
                                            .elementAt(index);
                                        return Stack(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image.file(
                                                  File(image.imagePath!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: InkWell(
                                                onTap: () {
                                                  Global.confirmDialog(
                                                    onConfirmed: () {
                                                      loadMaterialsToVehicleC
                                                          .loadMaterialsEvidence
                                                          .removeWhere((item) =>
                                                              item.id ==
                                                              image.id);
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  ),
                                                  child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.redAccent,
                                                    size: 25,
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
