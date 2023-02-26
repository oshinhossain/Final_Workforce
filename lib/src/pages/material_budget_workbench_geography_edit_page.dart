import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

class MaterialBudgetingWorkbenchEditGeography extends StatelessWidget
    with Base {
  final String? levelFullCode;
  final String? projectName;
  final String? country;
  final String? geo1;
  final String? geo2;
  MaterialBudgetingWorkbenchEditGeography({
    this.levelFullCode,
    this.projectName,
    this.country,
    this.geo1,
    this.geo2,
  });
  @override
  Widget build(BuildContext context) {
    materialBudgetWorkbenchC
        .getmaterialWorkbenchGeographyDetails(levelFullCode!);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: back,
        ),
        title: Column(
          children: [
            KText(
              text: 'Materials Budgeting Workbench:',
              fontSize: 16,
            ),
            KText(
              text: 'Geography',
              bold: true,
              fontSize: 17,
            ),
          ],
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
                child: Center(
                  child: KText(
                    text: projectName,
                    bold: true,
                  ),
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: country,
                      fontSize: 14,
                      color: AppTheme.oColor1,
                      bold: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: RenderSvg(
                        path: 'icon_forward',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    KText(
                      text: geo1,
                      fontSize: 14,
                      color: AppTheme.oColor1,
                      bold: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      child: RenderSvg(
                        path: 'icon_forward',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    KText(
                      text: geo2,
                      fontSize: 14,
                      color: AppTheme.oColor1,
                      bold: true,
                    ),
                  ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          child: Checkbox(
                            checkColor: hexToColor('#84BEF3'),
                            activeColor: Colors.transparent,
                            value: materialBudgetWorkbenchC.deliveryDate.value,
                            onChanged: (_) {
                              materialBudgetWorkbenchC.deliveryDate.toggle();
                              // siteLocationsC.kMapControllerSiteLocation
                              //     .move(LatLng(23.531003989570795, 90.78254520893097), 13);
                            },
                            side: MaterialStateBorderSide.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return BorderSide(color: Colors.red);
                              } else {
                                return BorderSide(color: hexToColor('#84BEF3'));
                              }
                            }),
                          ),
                        ),
                      ),
                      KText(text: 'Same Delivery Date')
                    ]),
                    Row(
                      children: [
                        KText(
                          text: materialBudgetWorkbenchC.selectedDate.value ==
                                      null ||
                                  materialBudgetWorkbenchC.selectedDate.value ==
                                      ''
                              ? formatDate(date: DateTime.now().toString())
                              : materialBudgetWorkbenchC.selectedDate.value,
                        ),
                        GestureDetector(
                            onTap: () {
                              materialBudgetWorkbenchC.selectDate('');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.blueAccent,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        itemCount:
                            materialBudgetWorkbenchC.geoDetailList.length,
                        shrinkWrap: true,
                        primary: false,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final item =
                              materialBudgetWorkbenchC.geoDetailList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Card(
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              elevation: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
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
                                              flex: 15,
                                              child: Row(
                                                children: [
                                                  KText(
                                                    text: item.productGroupName,
                                                    bold: true,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5, left: 5),
                                                    child: RenderSvg(
                                                      path: 'icon_forward',
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ),
                                                  KText(
                                                    text: item
                                                        .productSubGroupName,
                                                    bold: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Icon(
                                                    Icons.more_vert_outlined))
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Item Name',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(text: item.productName)
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Code',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            KText(text: item.productFullcode)
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
                                          children: [
                                            KText(
                                              text: 'Quantity',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            Spacer(),
                                            SizedBox(
                                              width: 60,
                                              child: TextFormField(
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                initialValue:
                                                    '${item.quantity == 0 ? '' : item.quantity}',
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    materialBudgetWorkbenchC
                                                        .updateQuantity(
                                                      item,
                                                      double.parse(value),
                                                    );
                                                  } else {
                                                    materialBudgetWorkbenchC
                                                        .updateQuantity(
                                                      item,
                                                      0,
                                                    );
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  isDense: true,
                                                  labelStyle: TextStyle(
                                                      color: hexToColor(
                                                          '#FF0000')),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppTheme
                                                            .borderColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            KText(text: item.baseUom),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            KText(
                                              text: 'Tentative ETD',
                                              fontSize: 13,
                                              color: hexToColor('#80939D'),
                                            ),
                                            Row(
                                              children: [
                                                KText(
                                                  text:
                                                      item.tentativeEtd != null
                                                          ? formatDate(
                                                              date: item
                                                                  .tentativeEtd
                                                                  .toString())
                                                          : item.tentativeEtd,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      materialBudgetWorkbenchC
                                                          .selectDate('etd');
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ]),
                              ),
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
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        GestureDetector(
            child: Container(
          height: 34,
          width: 109,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppTheme.primaryColor),
          child: Center(
              child: KText(
            text: 'Save',
            color: Colors.white,
            bold: true,
          )),
        )),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: StadiumBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
