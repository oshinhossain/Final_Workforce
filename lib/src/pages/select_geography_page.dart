import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/pages/assign_geographies_to_project_page.dart';
import '../components/k_appbar.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../helpers/hex_color.dart';
import '../helpers/k_text.dart';
import '../helpers/loading.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';
import '../models/project_area_add_model.dart';
import '../models/project_dropdown.dart';

class SelectGeographyPage extends StatefulWidget {
  final ProjectDropdown projectDropdown;
  SelectGeographyPage({required this.projectDropdown});
  @override
  State<SelectGeographyPage> createState() => _SelectGeographyPageState();
}

class _SelectGeographyPageState extends State<SelectGeographyPage> with Base {
  @override
  void dispose() {
    assignGeographiesProjectC.siteLocations.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // assignGeographiesProjectC.getAreaByIds();
    // assignGeographiesProjectC.getProjectName();
    return WillPopScope(
      onWillPop: () {
        assignGeographiesProjectC.disposeData();
        return Future(
          () => true,
        );
      },
      child: Scaffold(
        drawer: LeftSidebarComponent(),
        endDrawer: RightSidebarComponent(),
        resizeToAvoidBottomInset: true,

        appBar: KAppbar(),
        // backgroundColor: hexToColor('#EEF0F6'),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 0, right: 12, top: 3, bottom: 3),
                  height: 50,
                  width: Get.width,
                  // margin: EdgeInsets.symmetric(vertical: .5),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Colors.black12,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.black12,
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          assignGeographiesProjectC.disposeData();
                          back();
                        },
                      ),
                      Center(
                        child: KText(
                          text: 'Select Geography',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),

                  width: Get.width,
                  // margin: EdgeInsets.symmetric(vertical: .5),

                  decoration: BoxDecoration(
                    color: hexToColor('#EEF0F6'),
                    border: Border(
                      bottom: BorderSide(
                        width: 3,
                        color: Colors.black12,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: KText(
                          text: 'Search Geography',
                          fontSize: 14,
                          color: hexToColor('#41525A'),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: KText(
                      //     text: widget.projectDropdown.projectName,
                      //     fontSize: 14,
                      //     color: hexToColor('#41525A'),
                      //   ),
                      // ),
                      TextField(
                        onChanged: assignGeographiesProjectC.search,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (value) {
                          if (assignGeographiesProjectC
                              .search.value.isNotEmpty) {
                            assignGeographiesProjectC.addGeography();
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (assignGeographiesProjectC
                                  .search.value.isNotEmpty) {
                                assignGeographiesProjectC.addGeography();
                              }
                            },
                            child: RenderSvg(
                              fit: BoxFit.scaleDown,
                              path: 'icon_search_elements',
                              width: 5,
                              color: assignGeographiesProjectC
                                      .search.value.isNotEmpty
                                  ? hexToColor('#FFA133')
                                  : hexToColor('#9BA9B3'),
                            ),
                          ),
                          // focusedBorder: InputBorder.none,
                          hintText: 'Search here...',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                assignGeographiesProjectC.locationsGeo.isEmpty
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          children: [
                            KText(
                              text: 'Select All',
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              height: 23,
                              width: 23,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors
                                      .blue, //                   <--- border color
                                  width: 2.0,
                                ),
                              ),
                              child: Checkbox(
                                checkColor: Colors.blue,
                                activeColor: Colors.white,
                                side: BorderSide.none,
                                value:
                                    assignGeographiesProjectC.isSelectAll.value,
                                onChanged: (bool? value) {
                                  setState(() {
                                    for (var element
                                        in assignGeographiesProjectC
                                            .gioSelect) {
                                      element.isSelect = value;
                                    }

                                    assignGeographiesProjectC.isSelectAll
                                        .toggle();
                                    // print(
                                    //     '.....................................');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                assignGeographiesProjectC.isLoading.value
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Loading()
                          ],
                        ),
                      )
                    : assignGeographiesProjectC.locationsGeo.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 80),
                              child: RenderSvg(
                                path: 'search_list',
                                width: 60,
                                color: hexToColor('#9BA9B3'),
                              ),
                            ),
                          )
                        : assignGeographiesProjectC.locationsGeo.length !=
                                assignGeographiesProjectC.gioSelect.length
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 80),
                                  child: RenderSvg(
                                    path: 'search_list',
                                    width: 60,
                                    color: hexToColor('#9BA9B3'),
                                  ),
                                ),
                              )
                            : Obx(
                                () => ListView.builder(
                                  itemCount: assignGeographiesProjectC
                                      .locationsGeo.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item = assignGeographiesProjectC
                                        .locationsGeo[index];
                                    return Container(
                                      margin: EdgeInsets.all(12),
                                      width: Get.width,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10.0,
                                              color: Colors.black12,
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 12, top: 12),
                                                child: KText(
                                                  text: 'Select',
                                                  fontSize: 13,
                                                  color: AppTheme.appTextColor1,
                                                  bold: true,
                                                ),
                                              ),
                                              Spacer(),
                                              Obx(
                                                () => Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                  height: 23,
                                                  width: 23,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors
                                                          .blue, //                   <--- border color
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  // child: Checkbox(
                                                  //   checkColor: Colors.blue,
                                                  //   activeColor: Colors.white,
                                                  //   side: BorderSide.none,
                                                  //   value: assignGeographiesProjectC
                                                  //       .isChecked.value,
                                                  //   onChanged: (bool? value) {
                                                  //     assignGeographiesProjectC
                                                  //         .isChecked
                                                  //         .toggle();
                                                  //     assignGeographiesProjectC
                                                  //         .isChecked.value;
                                                  //   },
                                                  // ),

                                                  child: Checkbox(
                                                    checkColor: Colors.blue,
                                                    activeColor: Colors.white,
                                                    side: BorderSide.none,
                                                    value: assignGeographiesProjectC
                                                        .gioSelect[
                                                            assignGeographiesProjectC
                                                                .gioSelect
                                                                .indexWhere(
                                                                    (e) =>
                                                                        e.id ==
                                                                        item.id)]
                                                        .isSelect,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        assignGeographiesProjectC
                                                            .gioSelect[
                                                                assignGeographiesProjectC
                                                                    .gioSelect
                                                                    .indexWhere((e) =>
                                                                        e.id ==
                                                                        item.id)]
                                                            .isSelect = value;
                                                        assignGeographiesProjectC
                                                            .isSelectAll
                                                            .value = false;
                                                      });

                                                      // kLog(assignGeographiesProjectC
                                                      // .gioSelect[
                                                      //     assignGeographiesProjectC
                                                      //         .gioSelect
                                                      //         .indexWhere((e) =>
                                                      //             e.id ==
                                                      //             item.id)]
                                                      // .isSelect);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 12, bottom: 8, top: 6),
                                            child: KText(
                                              // text: '${item.level1Name} > ',
                                              text: item.level4Name!.isEmpty
                                                  ? ''
                                                  : '${item.level2Name} > ${item.level3Name} > ${item.level4Name}',
                                              fontSize: 13,
                                              color: AppTheme.appTextColor2,
                                              bold: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
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
                  assignGeographiesProjectC.disposeData();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: hexToColor('#9BA9B3')),
                  child: Center(
                    child: KText(
                      text: 'Cancel',
                      color: Colors.white,
                      bold: true,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () async {
                  // for (var element in assignGeographiesProjectC.gioSelect) {
                  //   if (element.isSelect == true) {
                  //     assignGeographiesProjectC.selectedlocations.add(
                  //         assignGeographiesProjectC.locations[
                  //             assignGeographiesProjectC.locations
                  //                 .indexWhere((e) => e.id == element.id)]);
                  //   }
                  // }

                  for (var element in assignGeographiesProjectC.gioSelect) {
                    final item = assignGeographiesProjectC.locationsGeo[
                        assignGeographiesProjectC.locationsGeo
                            .indexWhere((e) => e.id == element.id)];
                    if (element.isSelect == true) {
                      assignGeographiesProjectC.projectAreaAdd.add(
                        ProjectAreaAdd(
                          agencyId: agencyC.selectedAgency!.agencyId,
                          agencyCode: agencyC.selectedAgency!.agencyCode,
                          agencyName: agencyC.selectedAgency!.agencyName,
                          projectId: widget.projectDropdown.id,
                          projectCode: widget.projectDropdown.projectCode,
                          projectName: widget.projectDropdown.projectName,
                          verifierFullname: '',
                          verifierUsername: '',
                          verifierEmail: '',
                          verifierMobile: '',
                          assignedAgencyId: agencyC.selectedAgency!.agencyId,
                          assignedAgencyCode:
                              agencyC.selectedAgency!.agencyCode,
                          assignedAgencyName:
                              agencyC.selectedAgency!.agencyName,
                          assignedFullname: '',
                          assignedUsername: '',
                          assignedEmail: '',
                          assignedMobile: '',
                          areaType: item.areaType,
                          areaLevel: item.areaLevel,
                          countryCode: agencyC.selectedAgency!.countryCode,
                          countryName: agencyC.selectedAgency!.countryName,
                          geoLevel1Id:
                              item.level1Id != 'NA' ? item.level1Id : '',
                          geoLevel1Code: item.level1Code,
                          geoLevel1Name: item.level1Name,
                          geoLevel2Id:
                              item.level2Id != 'NA' ? item.level2Id : '',
                          geoLevel2Code: item.level2Code,
                          geoLevel2Name: item.level2Name,
                          geoLevel3Id:
                              item.level3Id != 'NA' ? item.level3Id : '',
                          geoLevel3Code: item.level3Code,
                          geoLevel3Name: item.level3Name,
                          geoLevel4Id:
                              item.level4Id != 'NA' ? item.level4Id : '',
                          geoLevel4Code: item.level4Code,
                          geoLevel4Name: item.level4Name,
                          geoLevel5Id:
                              item.level5Id != 'NA' ? item.level5Id : '',
                          geoLevel5Code: item.level5Code,
                          geoLevel5Name: item.level5Name,
                          levelType: item.levelType,
                          levelFullcode: item.level0Code! +
                              item.level1Code! +
                              item.level2Code! +
                              item.level3Code! +
                              item.level4Code! +
                              item.level5Code! +
                              item.level6Code! +
                              item.level7Code! +
                              item.level8Code! +
                              item.level9Code!,
                          digest: '',
                          testApproverUsername: '',
                          testApproverFullname: '',
                          testApproverEmail: '',
                          testApproverMobile: '',
                          siteInstallerUsername: '',
                          siteInstallerFullname: '',
                          siteInstallerEmail: '',
                          siteInstallerMobile: '',
                          siteInstallerWorkStartDate: '',
                          siteInstallerWorkCompleteDate: '',
                          siteInstallerStatusCode: '',
                          siteInstallerStatus: '',
                          siteInstallerSupportId: '',
                          siteInstallerSupportName: '',
                          siteInstallerSupportNo: '',
                          siteInspectorUsername: '',
                          siteInspectorFullname: '',
                          siteInspectorEmail: '',
                          siteInspectorMobile: '',
                          siteInspectorWorkStartDate: '',
                          siteInspectorWorkCompleteDate: '',
                          siteInspectorStatusCode: '',
                          siteInspectorStatus: '',
                          siteInspectorSupportId: '',
                          siteInspectorSupportName: '',
                          siteInspectorSupportNo: '',
                          networkInstallerUsername: '',
                          networkInstallerFullname: '',
                          networkInstallerEmail: '',
                          networkInstallerMobile: '',
                          networkInstallerWorkStartDate: '',
                          networkInstallerWorkCompleteDate: '',
                          networkInstallerStatusCode: '',
                          networkInstallerStatus: '',
                          networkInstallerSupportId: '',
                          networkInstallerSupportName: '',
                          networkInstallerSupportNo: '',
                          networkInspectorUsername: '',
                          networkInspectorFullname: '',
                          networkInspectorEmail: '',
                          networkInspectorMobile: '',
                          networkInspectorWorkStartDate: '',
                          networkInspectorWorkCompleteDate: '',
                          networkInspectorStatusCode: '',
                          networkInspectorStatus: '',
                          networkInspectorSupportId: '',
                          networkInspectorSupportName: '',
                          networkInspectorSupportNo: '',
                          equipmentInstallerUsername: '',
                          equipmentInstallerFullname: '',
                          equipmentInstallerEmail: '',
                          equipmentInstallerMobile: '',
                          equipmentInstallerWorkStartDate: '',
                          equipmentInstallerWorkCompleteDate: '',
                          equipmentInstallerStatusCode: '',
                          equipmentInstallerStatus: '',
                          equipmentInstallerSupportId: '',
                          equipmentInstallerSupportName: '',
                          equipmentInstallerSupportNo: '',
                          equipmentInspectorUsername: '',
                          equipmentInspectorFullname: '',
                          equipmentInspectorEmail: '',
                          equipmentInspectorMobile: '',
                          equipmentInspectorWorkStartDate: '',
                          equipmentInspectorWorkCompleteDate: '',
                          equipmentInspectorStatusCode: '',
                          equipmentInspectorStatus: '',
                          equipmentInspectorSupportId: '',
                          equipmentInspectorSupportName: '',
                          equipmentInspectorSupportNo: '',
                        ),
                      );
                    }
                  }

                  await assignGeographiesProjectC.projectAreaAddCreate();

                  for (var element in assignGeographiesProjectC.gioSelect) {
                    setState(() {
                      element.isSelect = false;
                    });
                  }
                  await assignGeographiesProjectC.assingProjectAreaGet();
                  offAll(AssignGeographiesToProjectPage());
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: hexToColor('#007BEC')),
                  child: Center(
                    child: KText(
                      text: 'Create',
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
}
