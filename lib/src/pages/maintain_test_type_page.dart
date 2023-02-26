import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';

import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import 'package:workforce/src/pages/define_test_acceptance_criteria_page.dart';
import '../helpers/global_helper.dart';
import '../helpers/hex_color.dart';
import '../helpers/loading.dart';
import '../helpers/maintain_dialog.dart';
import '../helpers/route.dart';

import '../widgets/custom_textfield_with_dropdown.dart';

class MaintainTestTypePage extends StatefulWidget {
  @override
  State<MaintainTestTypePage> createState() => _MaintainTestTypePagePageState();
}

class _MaintainTestTypePagePageState extends State<MaintainTestTypePage>
    with Base {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    maintainTestTypeCreateC.maintainTestTypeList.clear();
  }

  @override
  Widget build(BuildContext context) {
    networkTopologyC.getProjectName();
    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 0, right: 10, top: 3, bottom: 3),
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
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          back();
                        },
                      ),
                    ),
                    KText(
                      text: 'Maintain Test Types',
                      fontSize: 16,
                      color: hexToColor('#41525A'),
                      bold: true,
                    ),
                    SizedBox()
                  ],
                ),
              ),

              // Others parts

              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
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
              SizedBox(
                height: 5,
              ),

              if (networkTopologyC.projectNameList.isNotEmpty)
                Obx(
                  () => Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    child: CustomTextFieldWithDropdown(
                      suffix: DropdownButton(
                        value: networkTopologyC.selectedProject.value!.id,
                        underline: Container(),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: hexToColor('#80939D'),
                        ),
                        items: networkTopologyC.projectNameList.map((item) {
                          return DropdownMenuItem(
                            onTap: () {
                              networkTopologyC.selectedProject.value = item;
                              //   print(networkTopologyC.selectedProject.value!.id);
                            },
                            value: item.id,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 35,
                              ),
                              child: SizedBox(
                                width: Get.width / 1.3,
                                child: KText(
                                  text: item.projectName,
                                  fontSize: 13,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (item) async {
                          // kLog(item);
                          maintainTestTypeCreateC.maintainTestTypeList.clear();

                          // networkTopologyC.selectedProject.value =
                          //     networkTopologyC.projectNameList[networkTopologyC
                          //         .projectNameList
                          //         .indexWhere((element) =>
                          //             element.projectName == item)];

                          maintainTestTypeCreateC.projectId.value = item!;
                          // kLog(maintainTestTypeCreateC.projectId.value);
                          // maintainTestTypeCreateC.getMaintainTestType(item);
                          await maintainTestTypeCreateC.getMaintainTestType();
                        },
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Obx(
                () => maintainTestTypeCreateC.maintainTestTypeList.isEmpty
                    ? maintainTestTypeCreateC.isLoading.value
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
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount:
                            maintainTestTypeCreateC.maintainTestTypeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = maintainTestTypeCreateC
                              .maintainTestTypeList[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: Container(
                                width: 360,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  border: Border.all(color: AppTheme.nBorderC1),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10.0,
                                      color: Colors.black12,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Type Code',
                                                color: hexToColor('#80939D'),
                                              ),
                                              KText(
                                                text: item.testTypeCode,
                                                color: hexToColor('#41525A'),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              MaintainDialog
                                                  .editTestCriteriaInputDialog(
                                                title: 'Edit Test Type',
                                                labelText: 'Test Type Name:',
                                                controller:
                                                    maintainTestTypeCreateC,
                                                item: item,
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,

                                              //  padding: EdgeInsets.only(right: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: hexToColor(
                                                          '#00D8A0'))),
                                              child: Center(
                                                child: RenderSvg(
                                                    path: 'pen_color'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,

                                            //  padding: EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    width: 1,
                                                    color:
                                                        hexToColor('#FF8A00'))),
                                            child: Center(
                                              child: RenderSvg(path: 'Union '),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Global.confirmDialog(
                                                onConfirmed: () {
                                                  maintainTestTypeCreateC
                                                      .deleteMaintainTestTypeList(
                                                          id: item.id!,
                                                          item: item);
                                                  maintainTestTypeCreateC
                                                      .maintainTestTypeList
                                                      .removeWhere((element) =>
                                                          element.id ==
                                                          item.id);
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,

                                              //  padding: EdgeInsets.only(right: 15),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: hexToColor(
                                                          '#FE0101'))),
                                              child: Center(
                                                child: RenderSvg(
                                                    path: 'cross_color'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Type Name',
                                                color: hexToColor('#80939D'),
                                              ),
                                              KText(
                                                text: item.testTypeName,
                                                color: hexToColor('#41525A'),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              maintainTestTypeCreateC
                                                      .testTypeName.value =
                                                  maintainTestTypeCreateC
                                                          .projectId.value =
                                                      maintainTestTypeCreateC
                                                          .maintainTestTypeList[
                                                              index]
                                                          .testTypeName!;

                                              // maintainTestTypeCreateC
                                              //         .projectId.value =
                                              //     maintainTestTypeCreateC
                                              //         .maintainTestTypeList[
                                              //             index]
                                              //         .projectId!;

                                              await maintainTestTypeCreateC
                                                  .getCreateCriteriaGroup(
                                                      maintainTestTypeCreateC
                                                              .projectId.value =
                                                          maintainTestTypeCreateC
                                                              .maintainTestTypeList[
                                                                  index]
                                                              .projectId!,
                                                      maintainTestTypeCreateC
                                                              .projectId.value =
                                                          maintainTestTypeCreateC
                                                              .maintainTestTypeList[
                                                                  index]
                                                              .id!);

                                              maintainTestTypeCreateC
                                                      .testTypeId.value =
                                                  maintainTestTypeCreateC
                                                          .projectId.value =
                                                      maintainTestTypeCreateC
                                                          .maintainTestTypeList[
                                                              index]
                                                          .id!;
                                              await maintainTestTypeCreateC
                                                  .getScenario();

                                              push(
                                                DefineTestAcceptancecriteriaPage(
                                                  pId: maintainTestTypeCreateC
                                                      .maintainTestTypeList[
                                                          index]
                                                      .projectId,
                                                  id: maintainTestTypeCreateC
                                                      .maintainTestTypeList[
                                                          index]
                                                      .id,
                                                  pName: networkTopologyC
                                                      .selectedProject
                                                      .value!
                                                      .projectName,
                                                  tName: item.testTypeName,
                                                  scenarioName: '',
                                                  groupId: '',
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 24,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                border: Border.all(
                                                  color: hexToColor('#84BEF3'),
                                                ),
                                              ),
                                              child: Center(
                                                child: KText(
                                                  text: 'Criteria',
                                                  bold: true,
                                                  color: hexToColor('#007BEC'),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaintainDialog.creatTestTypeDialog(
            controller: maintainTestTypeCreateC,
            title: 'Create Test Type',
            labelText: 'Test Type Name:',
            pName: networkTopologyC.selectedProject.value!.projectName!,
            tName: '',
          );
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
