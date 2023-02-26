import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../../helpers/hex_color.dart';
import '../../helpers/route.dart';

// ignore: camel_case_types

class NetworkManagementSettingsPage extends StatefulWidget {
  @override
  State<NetworkManagementSettingsPage> createState() =>
      _NetworkManagementSettingsPageState();
}

class _NetworkManagementSettingsPageState
    extends State<NetworkManagementSettingsPage> with Base {
  final restrictDriversKey = GlobalKey<State<Tooltip>>();
  final restrictVehiclesKey = GlobalKey<State<Tooltip>>();

  final applyInspectorSourceKey = GlobalKey<State<Tooltip>>();
  final applyVehicleKey = GlobalKey<State<Tooltip>>();
  final applyRecipientKey = GlobalKey<State<Tooltip>>();
  final applyVehicleStartKey = GlobalKey<State<Tooltip>>();
  final applyMaterialsDropKey = GlobalKey<State<Tooltip>>();
  final applyInspectorDestinationKey = GlobalKey<State<Tooltip>>();
  final applyGeographyKey = GlobalKey<State<Tooltip>>();

  final approveKey1 = GlobalKey<State<Tooltip>>();
  final approveKey2 = GlobalKey<State<Tooltip>>();
  final approveKey3 = GlobalKey<State<Tooltip>>();

//  String? gender;

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
                SizedBox(
                  width: 30,
                ),
                Center(
                  child: KText(
                    text: 'Network Management Settings',
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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  kCheckBox(
                      'Activate SNMP-based device monitoring feature',
                      restrictDriversKey,
                      logisticPolicySettingsC.restrictDriversAgencyPool),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
              onTap: () {
                Global.confirmDialog(onConfirmed: () {
                  // kLog('done');
                  back();
                });
                // if (createTrasnportOrderC.transportOrderDate.isNotEmpty) {
                //   push(CreateTransportLineItemsPage());
                // }

                // print('dd');

                // showTopSnackBar(
                //   context,
                //   CustomSnackBar.success(
                //     message: "Submitted",
                //   ),
                // );
              },
              child: Obx(
                () => Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: hexToColor('#007BEC').withOpacity(
                        createTrasnportOrderC.transportOrderDate.isEmpty
                            ? .5
                            : 1),
                  ),
                  child: Center(
                    child: KText(
                      text: 'Save',
                      color: Colors.white,
                      bold: true,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
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
          ),
        ],
      ),
    );
  }
}
