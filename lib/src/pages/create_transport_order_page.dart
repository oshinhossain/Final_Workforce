import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/components/user_avatar.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/create_transport_controller.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/pages/create_transport_line_items_page.dart';
import '../config/constants.dart';
import '../controllers/location_controller.dart';
import '../helpers/hex_color.dart';
import '../helpers/route.dart';

import '../widgets/custom_textfield_with_dropdown.dart';

class CreateTransportOrderPage extends StatefulWidget {
  @override
  State<CreateTransportOrderPage> createState() =>
      _CreateTransportOrderPageState();
}

class _CreateTransportOrderPageState extends State<CreateTransportOrderPage>
    with Base {
  final key1 = GlobalKey<State<Tooltip>>();
  final key2 = GlobalKey<State<Tooltip>>();
  final key3 = GlobalKey<State<Tooltip>>();
  final key4 = GlobalKey<State<Tooltip>>();
  final key5 = GlobalKey<State<Tooltip>>();
  final key6 = GlobalKey<State<Tooltip>>();
  final key7 = GlobalKey<State<Tooltip>>();

  @override
  void initState() {
    createTrasnportOrderC.getProjectName();
    super.initState();
  }

  @override
  void dispose() {
    createTrasnportOrderC.resetData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                height: 50,
                width: Get.width,
                // margin: EdgeInsets.symmetric(vertical: .5),

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => back(),
                      child: RenderSvg(
                        path: 'icon_back',
                        width: 13.0,
                      ),
                    ),
                    KText(
                      text: 'Create Transport Order',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                    SizedBox()
                  ],
                ),
              ),
              Container(
                height: 50,
                width: Get.width,
                color: hexToColor('#EBEBEC'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'Transport Order',
                            fontSize: 12,
                            color: hexToColor('#80939D'),
                          ),
                          KText(
                            text: '(Auto)',
                            bold: true,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          KText(
                            text: 'Date',
                            fontSize: 14,
                          ),
                          KText(
                            text: formatDate(date: DateTime.now().toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Others parts

              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    KText(
                      text: 'Project Name',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    KText(
                      text: '*',
                      bold: true,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),

              if (createTrasnportOrderC.projectNameList.isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomTextFieldWithDropdown(
                    suffix: DropdownButton(
                      value: createTrasnportOrderC
                          .selectedProject.value!.projectName,
                      underline: Container(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: hexToColor('#80939D'),
                      ),
                      items: createTrasnportOrderC.projectNameList.map((item) {
                        return DropdownMenuItem(
                          onTap: () {
                            createTrasnportOrderC.selectedProject.value = item;
                          },
                          value: item.projectName,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 35,
                            ),
                            child: SizedBox(
                              width: Get.width / 1.3,
                              child: KText(
                                text: item.projectName,
                                fontSize: 15,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (item) {
                        // createTrasnportOrderC.projectName.value = item!;

                        //// kLog(createTrasnportOrderC.projectName.value);
                      },
                    ),
                  ),
                ),

              SizedBox(height: 10),
              searchField(
                title: 'Logistics Provider (Vehicle & Driver)',
                placeholder:
                    createTrasnportOrderC.getTransportPartyName() == null
                        ? 'Logistics Provider'
                        : createTrasnportOrderC.getTransportPartyName()!,
                onTap: () async {
                  await createTrasnportOrderC.openBottomSheet(
                      'Search Transport Party', 'Transport Party');
                },
              ),
              searchField(
                title: 'Receiving Party',
                placeholder: createTrasnportOrderC.getReciverPartyName() == null
                    ? 'Receiving Party'
                    : createTrasnportOrderC.getReciverPartyName()!,
                onTap: () async {
                  await createTrasnportOrderC.openBottomSheet(
                      'Search Receiving Party', 'Receiving Party');
                },
              ),

              singleRecivingPerson(),
              searchField(
                title: 'Source Location (Loading point / Warehouse)',
                placeholder:
                    createTrasnportOrderC.getSourcelocationName() == null
                        ? 'Source Location'
                        : createTrasnportOrderC.getSourcelocationName()!,
                onTap: () {
                  createTrasnportOrderC.allLocationBottomSheet(
                    title: 'Source Location',
                    locationPoint: LocationPoint.loading,
                  );
                  createTrasnportOrderC.locationType.value =
                      LocationType.warehouse;
                },
              ),
              singleDropLocation(),

              // sourceLocation.value
              // sourceLocationWarehouse.value

              // dropLocation.value;
              // dropLocationWarehouse.value;

              // searchField(
              //   title: 'Destination Location (Unloading Point)',
              //   placeholder:
              //       createTrasnportOrderC.destinationLocName.value.isEmpty
              //           ? 'Select destination location'
              //           : createTrasnportOrderC.destinationLocName.value,
              //   onTap: () async {
              //     createTrasnportOrderC
              //         .searchLocationBottomsheet('Destination Location');
              //   },
              // ),

              goodsInspectorAtLoadingPoint(),
              singleGoodsInspectorAtDropLocation(),

              travelPath(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: 'Remarks',
                      color: hexToColor('#80939D'),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        onChanged: createTrasnportOrderC.remarks,
                        maxLines: 5,
                        minLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Remarks Here',
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: .1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 1, color: Colors.grey.withOpacity(.6))),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                      top: -10,
                      left: 14,
                      child: Container(
                        child: KText(
                          text: 'Transportation controls',
                          fontSize: 14,
                        ),
                        decoration: BoxDecoration(color: Colors.white),
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      kCheckBox('Enforce Inspector at Source', key1,
                          createTrasnportOrderC.enforceInspectorAtSource),
                      kCheckBox('Enforce Vehicle Readiness', key2,
                          createTrasnportOrderC.enforceVehicleReadiness),
                      kCheckBox('Enforce Recipient Readiness', key3,
                          createTrasnportOrderC.enforceRecipientReadiness),
                      kCheckBox('Enforce Vehicle Starting by Driver', key6,
                          createTrasnportOrderC.enforceVehicleStartingbyDriver),
                      kCheckBox(
                          'Enforce Materials Droping by Driver',
                          key7,
                          createTrasnportOrderC
                              .enforceMaterialsDropingbyDriver),
                      kCheckBox('Enforce Inspector at Destination', key4,
                          createTrasnportOrderC.enforceInspectorAtDestination),
                      kCheckBox('Enforce Receipt by Receiver', key5,
                          createTrasnportOrderC.enforceReceiptByReceiver),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.all(12),
          // height: 40,
          width: Get.width,
          // margin: EdgeInsets.symmetric(vertical: .5),

          decoration: BoxDecoration(
            color: Colors.white,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: createTrasnportOrderC.validateTrasnportOrder()
                    ? () {
                        push(CreateTransportLineItemsPage());
                      }
                    : () {
                        Get.snackbar(
                          'Status',
                          'Please enter data for all required fields',
                          colorText: AppTheme.black,
                          backgroundColor: AppTheme.appHomePageColor,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: createTrasnportOrderC.validateTrasnportOrder()
                        ? hexToColor('#007BEC')
                        : hexToColor('#007BEC').withOpacity(.5),
                  ),
                  child: Center(
                    child: KText(
                      text: 'Next',
                      color: Colors.white,
                      bold: true,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
                width: 2,
              ),
              KText(
                text: '*',
                bold: true,
                color: Colors.redAccent,
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

  Widget singleDropLocation() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                      activeColor: hexToColor('#84BEF3'),
                      value: createTrasnportOrderC.isSingleDropLocation.value,
                      onChanged: (bool? value) =>
                          createTrasnportOrderC.isSingleDropLocation.toggle()),
                ),
              ),
              KText(
                text: 'Single Drop Location (Destination)',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                bold: true,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    createTrasnportOrderC.allLocationBottomSheet(
                      locationPoint: LocationPoint.unloading,
                      title: 'Single drop location',
                    );
                    createTrasnportOrderC.locationType.value =
                        LocationType.known;
                  },
                  child: RenderSvg(
                    path: 'icon_search_elements',
                    width: 26,
                    color: hexToColor('#66A1D9'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.getDropLocationName() == null
                    ? 'Drop Location'
                    : createTrasnportOrderC.getDropLocationName(),
                fontSize: 15,
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              KText(
                text: 'Planned start date',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(width: 2),
              KText(
                text: '*',
                bold: true,
                color: Colors.redAccent,
              ),
              Container(
                padding: EdgeInsets.all(0),
                child: IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now().add(Duration(days: 1095)),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      createTrasnportOrderC.plannedStartDate.value =
                          formattedDate;
                    }
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppTheme.primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.plannedStartDate.value.isEmpty
                    ? 'Planned start date'
                    : formatDate(
                        date: createTrasnportOrderC.plannedStartDate.value),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              KText(
                text: 'ETD (Estimated Time of Delivery)',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 2,
              ),
              KText(
                text: '*',
                bold: true,
                color: Colors.redAccent,
              ),
              Container(
                padding: EdgeInsets.all(0),
                child: IconButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      //DateTime.now() - not to allow to choose before today.
                      // lastDate: DateTime.now().add(Duration(days: 1095)),
                      lastDate: DateTime.now().add(Duration(days: 1095)),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      createTrasnportOrderC.etd.value = formattedDate;
                    } else {}
                  },
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppTheme.primaryColor,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Row(
            children: [
              KText(
                text: createTrasnportOrderC.etd.value.isEmpty
                    ? 'ETD'
                    : formatDate(date: createTrasnportOrderC.etd.value),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget travelPath() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                      activeColor: hexToColor('#84BEF3'),
                      value: createTrasnportOrderC.isPrescribeTravelPath.value,
                      onChanged: (bool? value) =>
                          createTrasnportOrderC.isPrescribeTravelPath.toggle()),
                ),
              ),
              KText(
                text: 'Prescribe Travel Path',
                color: hexToColor('#80939D'),
                fontSize: 13,
              ),
              SizedBox(
                width: 3,
              ),
              // IconButton(
              //   onPressed: widget.onPressed,
              //   icon: SvgPicture.asset(
              //     '${Constants.svgPath}/icon_search_elements.svg',
              //     color: hexToColor('#66A1D9'),
              //     width: 16,
              //   ),
              // ),

              Container(
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {},
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
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: KText(
                  text: createTrasnportOrderC.prescribeTravelPath.value.isEmpty
                      ? 'Travel Path'
                      : createTrasnportOrderC.prescribeTravelPath.value,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget singleRecivingPerson() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: createTrasnportOrderC.isSingleRecivingPerson.value,
                    onChanged: (bool? _) =>
                        createTrasnportOrderC.isSingleRecivingPerson.toggle(),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    KText(
                      maxLines: 2,
                      text:
                          'Single Receiving Person\n(on behalf of Receiving Party)',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                    ),
                    SizedBox(width: 2),
                    KText(
                      text: '*',
                      bold: true,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    createTrasnportOrderC
                        .searchUserBottomsheet('Single Receiving Person');
                  },
                  child: RenderSvg(
                    path: 'icon_search_elements',
                    width: 26,
                    color: hexToColor('#66A1D9'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              createTrasnportOrderC.singleReciverPerson.value?.username != null
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
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.singleReciverPerson.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(
                width: 10,
              ),
              KText(
                text: createTrasnportOrderC.getSingleRecivingPerson() == null
                    ? 'Single Receving Party'
                    : createTrasnportOrderC.getSingleRecivingPerson(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget singleGoodsInspectorAtDropLocation() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    activeColor: hexToColor('#84BEF3'),
                    value: createTrasnportOrderC.isSinglegoodsInspector.value,
                    onChanged: (bool? _) =>
                        createTrasnportOrderC.isSinglegoodsInspector.toggle(),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    KText(
                      text: 'Single Goods Inspector at the\nDrop Location',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                    ),
                    SizedBox(width: 2),
                    KText(
                      text: '*',
                      bold: true,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    createTrasnportOrderC.searchUserBottomsheet(
                      'Single Goods Inspector at the Drop Location',
                    );
                  },
                  child: RenderSvg(
                    path: 'icon_search_elements',
                    width: 26,
                    color: hexToColor('#66A1D9'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              createTrasnportOrderC
                          .goodsInspectorAtDropLocation.value?.username !=
                      null
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
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.goodsInspectorAtDropLocation.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(width: 10),
              KText(
                text: createTrasnportOrderC
                            .getSingleGoodsInspectorAtDropLocation() ==
                        null
                    ? 'Single Goods Inspector'
                    : createTrasnportOrderC
                        .getSingleGoodsInspectorAtDropLocation(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget goodsInspectorAtLoadingPoint() {
    final locationC = Get.put(LocationController());

    final latLng =
        '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(right: 5),
              //   child: SizedBox(
              //     height: 20,
              //     width: 20,
              //     child: Checkbox(
              //       activeColor: hexToColor('#84BEF3'),
              //       value: true,
              //       onChanged: (bool? value) {},
              //     ),
              //   ),
              // ),
              Row(
                children: [
                  KText(
                    text: 'Goods Inspector at the Loading Point',
                    color: hexToColor('#80939D'),
                    fontSize: 13,
                  ),
                  KText(
                    text: '*',
                    bold: true,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(
                width: 3,
              ),
              // IconButton(
              //   onPressed: widget.onPressed,
              //   icon: SvgPicture.asset(
              //     '${Constants.svgPath}/icon_search_elements.svg',
              //     color: hexToColor('#66A1D9'),
              //     width: 16,
              //   ),
              // ),

              Container(
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: () {
                    createTrasnportOrderC.searchUserBottomsheet(
                        'Goods Inspector at the Loading Point');
                  },
                  child: RenderSvg(
                    path: 'icon_search_elements',
                    width: 26,
                    color: hexToColor('#66A1D9'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              createTrasnportOrderC
                          .goodsInspectorAtLoadingPoint.value?.username !=
                      null
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
                          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=${createTrasnportOrderC.goodsInspectorAtLoadingPoint.value?.username}&appCode=KYC&fileCategory=photo&countryCode=BD',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : UserAvatar(),
              SizedBox(width: 10),
              KText(
                text: createTrasnportOrderC.getGoodsInspectorAtLoadingPoint() ==
                        null
                    ? 'Goods Inspector'
                    : createTrasnportOrderC.getGoodsInspectorAtLoadingPoint(),
                fontSize: 15,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget searchFieldWithPic({
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
              Checkbox(value: true, onChanged: (v) {}),
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
          Row(
            children: [
              Padding(
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
              KText(
                text: placeholder,
                fontSize: 15,
              ),
            ],
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget kCheckBox(String title, GlobalKey key, RxBool v) {
    return GestureDetector(
      onTap: () {
        v.toggle();
      },
      child: Row(
        children: [
          Checkbox(
            // visualDensity: VisualDensity(
            //     horizontal: VisualDensity.minimumDensity,
            //     vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: v.value,
            onChanged: (x) {
              v.toggle();
            },
            activeColor: hexToColor('#84BEF3'),
          ),
          // SizedBox(
          //   width: 12,
          // ),
          KText(
            text: title,
            fontSize: 14,
          ),
          Tooltip(
            key: key,
            triggerMode: TooltipTriggerMode.longPress,
            message: 'Lorem Ipsum is simply dummy text',
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppTheme.appbarColor,
                border: Border.all(
                    width: 1.5, color: AppTheme.textColor.withOpacity(.1))),
            padding: EdgeInsets.all(10),
            textStyle: TextStyle(
                fontFamily: 'Manrope Regular',
                color: AppTheme.textColor,
                fontSize: 13),
            child: IconButton(
              visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              onPressed: () {
                final dynamic tooltip = key.currentState!;
                tooltip?.ensureTooltipVisible();
              },
              icon: Icon(Icons.info_outline),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
