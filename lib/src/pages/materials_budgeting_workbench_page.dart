import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/enums/enums.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/material_budget_workbench_geography_edit_page.dart';

class MaterialBudgetingWorkbenchPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    materialBudgetWorkbenchC.getProjectName();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: back,
        ),
        title: KText(
          text: 'Materials Budgeting Workbench',
          bold: true,
          fontSize: 16,
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Container(
                height: 45,
                width: 360,
                decoration: BoxDecoration(
                    color: AppTheme.appbarColor,
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(width: 1, color: AppTheme.bdrColor))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KText(
                        text: materialBudgetWorkbenchC.projectName.value.isEmpty
                            ? 'Select Project'
                            : materialBudgetWorkbenchC.projectName.value,
                        bold: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          materialBudgetWorkbenchC.projectNameDropdown();
                        },
                        child: RenderSvg(
                          path: 'dropdown',
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: 'Filter',
                      fontSize: 15,
                      bold: true,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: AppTheme.textfieldColor,
                        ))
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: AppTheme.bdrColor, width: 1))),
                child: Row(
                  children: [
                    KText(
                      text: 'View Type:',
                      bold: true,
                      fontSize: 14,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => materialBudgetWorkbenchC.viewType.value =
                          ViewType.geographies,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 28,
                            child: Radio<ViewType>(
                              value: materialBudgetWorkbenchC.viewType.value,
                              groupValue: ViewType.geographies,
                              onChanged: (value) {
                                materialBudgetWorkbenchC.viewType.value =
                                    ViewType.geographies;
                              },
                            ),
                          ),
                          KText(
                            text: 'Geographies',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () => materialBudgetWorkbenchC.viewType.value =
                          ViewType.materials,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 28,
                            child: Radio<ViewType>(
                              value: materialBudgetWorkbenchC.viewType.value,
                              groupValue: ViewType.materials,
                              onChanged: (value) {
                                materialBudgetWorkbenchC.viewType.value =
                                    ViewType.materials;
                              },
                            ),
                          ),
                          KText(
                            text: 'Materials',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RenderSvg(path: 'icon_pointer'),
                        // SvgPicture.asset(
                        //     '${Constants.svgPath}/trucklogo.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        KText(
                          text: 'Geography',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DottedLine(
                      dashGapLength: 1,
                      dashColor: AppTheme.borderColor3,
                      dashLength: 3,
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1, color: AppTheme.borderColor3),
                        ),
                        color: AppTheme.areaColor,
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(text: 'Area Type'),
                            KText(text: 'Level')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: 'Country Unit',
                              bold: true,
                            ),
                            KText(
                              text: '4',
                              bold: true,
                            )
                          ],
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Transform.rotate(
                    //   angle: -math.pi / 2,
                    //   child: ClipPath(
                    //     clipper: MessageClipper(borderRadius: 10),
                    //     child: Container(
                    //       height: 300,
                    //       width: 200,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    //         color: Colors.red,
                    //       ),
                    //       child: Transform.rotate(
                    //         angle: -math.pi / -2,
                    //         child: ClipPath(
                    //           child: Row(
                    //             children: [
                    //               IconButton(onPressed: () {}, icon: Icon(Icons.copy_rounded)),
                    //               IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    //               IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    //               IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ListView.builder(
                        itemCount: materialBudgetWorkbenchC.geoList.length,
                        shrinkWrap: true,
                        primary: false,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final item = materialBudgetWorkbenchC.geoList[index];
                          return Obx(
                            () => Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    shadowColor: Colors.grey,
                                    elevation: 2,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 25,
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: KText(
                                                            text: item
                                                                .countryName,
                                                            bold: true,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5,
                                                                  left: 5),
                                                          child: RenderSvg(
                                                            path:
                                                                'icon_forward',
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: KText(
                                                            text: item
                                                                .geoLevel1Name,
                                                            bold: true,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 5,
                                                                  left: 5),
                                                          child: RenderSvg(
                                                            path:
                                                                'icon_forward',
                                                            height: 20,
                                                            width: 20,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: KText(
                                                            text: item
                                                                .geoLevel2Name,
                                                            bold: true,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            materialBudgetWorkbenchC
                                                                .isShow
                                                                .toggle();
                                                            // kLog(materialBudgetWorkbenchC.isShow.value);
                                                          },
                                                          child: Icon(Icons
                                                              .more_vert_outlined)))
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: hexToColor('#515D64'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'No. of Items',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                      text: item.noOfProduct
                                                          .toString())
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: hexToColor('#515D64'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'BoQ',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(
                                                      text: item.boq.toString())
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: hexToColor('#515D64'),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  KText(
                                                    text: 'Delivery Timeline',
                                                    fontSize: 13,
                                                    color:
                                                        hexToColor('#80939D'),
                                                  ),
                                                  KText(text: item.etd)
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                if (materialBudgetWorkbenchC.isShow.value)
                                  Positioned(
                                      child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 200,
                                        color: Colors.white,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.copy_rounded)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.delete)),
                                            IconButton(
                                                onPressed: () {
                                                  push(
                                                      MaterialBudgetingWorkbenchEditGeography(
                                                    levelFullCode:
                                                        item.levelFullcode,
                                                    projectName:
                                                        materialBudgetWorkbenchC
                                                            .projectName.value,
                                                    country: item.countryName,
                                                    geo1: item.geoLevel1Name,
                                                    geo2: item.geoLevel2Name,
                                                  ));
                                                },
                                                icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.close)),
                                          ],
                                        ),
                                      ),
                                      // Transform.rotate(
                                      //   angle: -math.pi / 4,
                                      //   child: ClipPath(
                                      //     clipper: ArrowClipper(),
                                      //     child: Container(
                                      //       height: 100,
                                      //       width: 50,
                                      //       color: Colors.red,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ))
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // materialBudgetWorkbenchC.isShow.toggle();
          //
        },
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
