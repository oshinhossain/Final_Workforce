import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import '../components/left_sidebar_component.dart';
import '../components/right_sidebar_component.dart';
import '../config/app_theme.dart';
import '../helpers/global_helper.dart';
import '../helpers/loading.dart';

import '../helpers/maintain_dialog.dart';
import '../widgets/custom_textfield_projectdashboard.dart';

class DefineTestAcceptancecriteriaPage extends StatefulWidget {
  final String? id;
  final String? pId;
  final String? pName;
  final String? tName;
  final String? scenarioName;
  final String? groupId;

  DefineTestAcceptancecriteriaPage({
    required this.id,
    required this.pId,
    required this.pName,
    required this.tName,
    required this.scenarioName,
    required this.groupId,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DefineTestAcceptancecriteriaPageState createState() =>
      _DefineTestAcceptancecriteriaPageState();
}

class _DefineTestAcceptancecriteriaPageState
    extends State<DefineTestAcceptancecriteriaPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 3,
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          switch (_activeIndex) {
            case 0:
              MaintainDialog.createCriteriaGroupInputDialog(
                controller: maintainTestTypeCreateC,
                title: 'Create Criteria ',
                labelText: 'Criteria group name will be here',
                projectId: widget.pId!,
                pName: widget.pName!,
                // tName: widget.tName!,
                id: widget.id!,
              );
              break;
            case 1:
              print(widget.id);
              MaintainDialog.createTestCriteriaInputDialog(
                controller: maintainTestTypeCreateC,
                title: 'Create Test Criteria',
                labelText: 'Test Criteria group name will be here',
                pName: widget.pName!,
                groupName:
                    maintainTestTypeCreateC.selectedGroupName.value!.groupName!,
                id: maintainTestTypeCreateC.testTypeId.value,
              );
              print(maintainTestTypeCreateC.testTypeId.value);
              break;

            default:
              MaintainDialog.createScenarioInputDialog(
                controller: maintainTestTypeCreateC,
                title: 'Create Scenario',
                labelText: 'Scenario group name will be here',
                pName: widget.pName!,
                // tName: widget.tName!,
                id: widget.id!,
              );

              break;
          }
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => back(),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                back();
              },
            ),
          ),
          title: KText(
            text: 'Define Test Acceptance Criteria',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
          bottom: PreferredSize(
            //   preferredSize: _tabBar.preferredSize,
            preferredSize: Size(Get.width, 70),
            child: Material(
              color: hexToColor('#EEF0F6'),
              child: Obx(
                () => Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    KText(
                      text:
                          '${networkTopologyC.selectedProject.value!.projectName!} > ${maintainTestTypeCreateC.testTypeName.value}',
                      color: hexToColor('#80939D'),
                      fontSize: 13,
                      maxLines: 3,
                    ),
                    Container(
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
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            CriteriaGroup(
              pName: widget.pName,
              id: widget.id,
              tName: widget.tName,
            ),
            TestCriteria(
              pName: widget.pName,
              id: widget.id,
              tName: widget.tName,
              groupId: widget.groupId,
            ),
            Scenario(
              pName: widget.pName,
              id: widget.id,
              tName: widget.tName,
              scenarioName: widget.scenarioName,
            ),
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
          Tab(text: 'Criteria Group'),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(width: 1, color: hexToColor('#EEF0F6'))),
            ),
            child: Tab(text: 'Test Criteria'),
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
            child: Tab(text: 'Scenario'),
          ),
        ],
      );
}

class CriteriaGroup extends StatelessWidget with Base {
  final String? pName;
  final String? id;

  final String? tName;
  CriteriaGroup({
    required this.id,
    required this.pName,
    required this.tName,
  });
  @override
  Widget build(BuildContext context) {
    //  maintainTestTypeCreateC.getCreateCriteriaGroup();
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: hexToColor('#9BA9B3'),
          ),
          maintainTestTypeCreateC.criteriaGroupList.isEmpty
              ? maintainTestTypeCreateC.isLoading.value
                  ? SizedBox(
                      height: Get.height / 1.5,
                      child: Center(
                        child: Loading(),
                      ))
                  : SizedBox(
                      height: Get.height / 1.5,
                      child: Center(child: KText(text: 'No data found')),
                    )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: maintainTestTypeCreateC.criteriaGroupList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item =
                        maintainTestTypeCreateC.criteriaGroupList[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Container(
                          width: 360,
                          height: 120,
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
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          text: 'Group Code',
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: item.groupCode,
                                          color: hexToColor('#41525A'),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        MaintainDialog
                                            .editCriteriaGroupInputDialog(
                                          title: 'Edit Criteria Group',
                                          labelText: 'Criteria Group Name:',
                                          controller: maintainTestTypeCreateC,
                                          item: item,
                                          pName: pName!,
                                          grouptypeName: tName!,
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
                                                color: hexToColor('#00D8A0'))),
                                        child: Center(
                                          child: RenderSvg(path: 'pen_color'),
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
                                              color: hexToColor('#FF8A00'))),
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
                                                .deleteCriteriaTestTypeList(
                                                    id: item.id!, item: item);
                                            maintainTestTypeCreateC
                                                .criteriaGroupList
                                                .removeWhere((element) =>
                                                    element.id == item.id);
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
                                                color: hexToColor('#FE0101'))),
                                        child: Center(
                                          child: RenderSvg(path: 'cross_color'),
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
                                          text: 'Group Name',
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: item.groupName,
                                          color: hexToColor('#41525A'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ],
      ),
    ));
  }
}

class TestCriteria extends StatelessWidget with Base {
  final String? pName;
  final String? id;
  final String? groupId;
  final String? tName;
  TestCriteria({
    required this.id,
    required this.pName,
    required this.tName,
    required this.groupId,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              maintainTestTypeCreateC.criteriaGroupList.isEmpty
                  ? Center(
                      child: Loading(),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: CustomTextFieldProjectdashboard(
                        title: 'Criteria Group',
                        isTooltipRequired: false,
                        suffix: DropdownButton(
                          isExpanded: true,
                          value: maintainTestTypeCreateC
                              .selectedGroupName.value!.id,
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: hexToColor('#80939D'),
                          ),
                          items: maintainTestTypeCreateC.criteriaGroupList
                              .map((item) {
                            return DropdownMenuItem(
                              onTap: () async {
                                // kLog('test type id');

                                // kLog(item.testTypeId);
                                maintainTestTypeCreateC.testcriteriaGroupList
                                    .clear();

                                //   print('frhfhrh');
                                maintainTestTypeCreateC.groupId.value =
                                    item.id!;
                                maintainTestTypeCreateC
                                    .selectedGroupName.value = item;
                                maintainTestTypeCreateC.testTypeId.value =
                                    item.testTypeId!;
                                // kLog(maintainTestTypeCreateC.testTypeId.value);
                                await maintainTestTypeCreateC.getTestCriteria();
                                await maintainTestTypeCreateC.getScenario();
                              },
                              value: item.id,
                              child: SizedBox(
                                child: KText(
                                  text: item.groupName,
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (item) async {
                            // maintainTestTypeCreateC.groupId.value = item!;
                            //// kLog(maintainTestTypeCreateC.groupId.value);
                            // maintainTestTypeCreateC.getTestCriteria(item);

                            maintainTestTypeCreateC.selectedIndex.value = item!;
                            // kLog(maintainTestTypeCreateC.selectedIndex.value);
                            maintainTestTypeCreateC.groupId.value =
                                maintainTestTypeCreateC
                                    .criteriaGroupList[maintainTestTypeCreateC
                                        .criteriaGroupList
                                        .indexWhere((element) =>
                                            element.groupName == item)]
                                    .id!;
                          },
                        ),
                      ),
                    ),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    maintainTestTypeCreateC.testcriteriaGroupList.isEmpty
                        ? maintainTestTypeCreateC.isLoading.value
                            ? SizedBox(
                                height: Get.height / 1.5,
                                child: Center(
                                  child: Loading(),
                                ))
                            : SizedBox(
                                height: Get.height / 1.5,
                                child:
                                    Center(child: KText(text: 'No data found')),
                              )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: maintainTestTypeCreateC
                                .testcriteriaGroupList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = maintainTestTypeCreateC
                                  .testcriteriaGroupList[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Container(
                                    width: 360,
                                    height: 190,
                                    decoration: BoxDecoration(
                                      color: AppTheme.white,
                                      border:
                                          Border.all(color: AppTheme.nBorderC1),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    text: 'Criteria Code',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                    text: item.criterionCode,
                                                    color:
                                                        hexToColor('#41525A'),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  MaintainDialog
                                                      .edittestCriteria(
                                                    title: 'Edit Test Criteria',
                                                    labelText:
                                                        'Test Criteria Name:',
                                                    controller:
                                                        maintainTestTypeCreateC,
                                                    item: item,
                                                    pName: pName!,
                                                    grouptypeName: tName!,
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
                                                        color: hexToColor(
                                                            '#FF8A00'))),
                                                child: Center(
                                                  child:
                                                      RenderSvg(path: 'Union '),
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
                                                          .deleteTestCriteriaTypeList(
                                                              id: item.id!,
                                                              item: item);
                                                      maintainTestTypeCreateC
                                                          .testcriteriaGroupList
                                                          .removeWhere(
                                                              (element) =>
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
                                                    text: 'Criteria Name ',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                    text: item.criterionName !=
                                                            null
                                                        ? '${item.criterionName}'
                                                        : '',
                                                    color:
                                                        hexToColor('#515D64'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height: 1,
                                              width: 100,
                                              color: AppTheme.nBorderC1,
                                              child: Divider(
                                                thickness: .5,
                                                color: AppTheme.nBorderC1,
                                              )),
                                          SizedBox(
                                            height: 20,
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
                                                    text: 'Expected Value: ',
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                    text: item.expectedResult !=
                                                            null
                                                        ? '${item.expectedResult}'
                                                        : '',
                                                    color:
                                                        hexToColor('#515D64'),
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height: 1,
                                              width: 100,
                                              color: AppTheme.nBorderC1,
                                              child: Divider(
                                                thickness: .5,
                                                color: AppTheme.nBorderC1,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class Scenario extends StatelessWidget with Base {
  final String? pName;
  final String? id;
  final String? scenarioName;

  final String? tName;
  Scenario({
    required this.id,
    required this.pName,
    required this.tName,
    required this.scenarioName,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 1,
            color: hexToColor('#9BA9B3'),
          ),
          maintainTestTypeCreateC.scenarioGroupList.isEmpty
              ? maintainTestTypeCreateC.isLoading.value
                  ? SizedBox(
                      height: Get.height / 1.5,
                      child: Center(
                        child: Loading(),
                      ))
                  : SizedBox(
                      height: Get.height / 1.5,
                      child: Center(child: KText(text: 'No data found')),
                    )
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: maintainTestTypeCreateC.scenarioGroupList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item =
                        maintainTestTypeCreateC.scenarioGroupList[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                        child: Container(
                          width: 360,
                          height: 120,
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
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          text: 'scenario Code',
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: item.scenarioCode,
                                          color: hexToColor('#41525A'),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        MaintainDialog
                                            .editScenarioGroupInputDialog(
                                          title: 'Edit Scenario Group',
                                          labelText: 'Scenario Group Name:',
                                          controller: maintainTestTypeCreateC,
                                          item: item,
                                          scenarioName: scenarioName!,
                                          pName: pName!,
                                          grouptypeName: tName!,
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
                                                color: hexToColor('#00D8A0'))),
                                        child: Center(
                                          child: RenderSvg(path: 'pen_color'),
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
                                              color: hexToColor('#FF8A00'))),
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
                                                .deleteScenarioTestTypeList(
                                                    id: item.id!, item: item);
                                            maintainTestTypeCreateC
                                                .scenarioGroupList
                                                .removeWhere((element) =>
                                                    element.id == item.id);
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
                                                color: hexToColor('#FE0101'))),
                                        child: Center(
                                          child: RenderSvg(path: 'cross_color'),
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
                                          text: 'scenario Name',
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                          text: item.scenarioName,
                                          color: hexToColor('#41525A'),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 24,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          border: Border.all(
                                              color: hexToColor('#84BEF3')),
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
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ],
      ),
    ));
  }
}
