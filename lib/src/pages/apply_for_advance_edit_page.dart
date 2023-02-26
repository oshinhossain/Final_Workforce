import 'dart:io';
import 'package:flutter/material.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/apply_for_advance_page.dart';
import 'package:workforce/src/widgets/custom_textfield_with_dropdown.dart';

class ApplyForAdvanceEditPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [Container()],
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
                    onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
                Center(
                  child: KText(
                    text: 'Apply for Advance',
                    bold: true,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: 'Ref. No.',
                      color: hexToColor('#80939D'),
                      fontSize: 16,
                    ),
                    KText(
                      text: ' Date',
                      color: hexToColor('#80939D'),
                      fontSize: 16,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: '(Auto)',
                    ),
                    KText(
                      text: formatDate(date: DateTime.now().toString()),
                    ),
                  ],
                ),
                Divider(),
                KText(
                  text: 'Type',
                  color: hexToColor('#80939D'),
                  fontSize: 16,
                ),
                CustomTextFieldWithDropdown(
                  suffix: DropdownButton(
                    value: advanceC.selectedAdvanceType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: advanceC.advanceTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          advanceC.selectedAdvanceType.value = item;
                        },
                        value: item,
                        child: SizedBox(
                          width: Get.width * .8,
                          child: KText(
                            text: item,
                            fontSize: 13,
                            maxLines: 2,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (item) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: KText(
                    text: 'Purpose',
                    color: hexToColor('#80939D'),
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  onChanged: advanceC.purpose,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#EEF0F6'), width: 1),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: .5),
                    // ),
                    // border: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: .5),
                    // ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: KText(
                    text: 'Amount (BDT)',
                    color: hexToColor('#80939D'),
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  onChanged: advanceC.amount,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: hexToColor('#EEF0F6'), width: 1),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: hexToColor('#EEF0F6')),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'Ref. No.',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(text: advanceC.refNo.value),
                            SizedBox(
                              height: 10,
                            ),
                            KText(
                              text: 'Type',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(text: advanceC.tRType.value),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            KText(
                              text: 'Date',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(text: advanceC.trDate.value),
                            SizedBox(
                              height: 10,
                            ),
                            KText(
                              text: 'Estimated Cost (BDT)',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            KText(text: advanceC.trCost.value.toString()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      top: 12,
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            KText(
                              text: 'Approved TR',
                              color: hexToColor('#80939D'),
                              fontSize: 16,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  advanceC.approvedTRModal();
                                },
                                child: RenderSvg(path: 'icon_search_elements'))
                          ],
                        ),
                      ))
                ]),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        advanceC.pickMultiImage();
                      },
                      child: RenderSvg(
                        path: 'icon_add_box',
                        width: 25.0,
                        color: hexToColor('#FFA133'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    KText(
                      text: 'Attachments',
                      color: hexToColor('#80939D'),
                      fontSize: 16,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      advanceC.imagefiles.isEmpty
                          ? SizedBox()
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: advanceC.imagefiles.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final item = advanceC.imagefiles[index];
                                return Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          File(item.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      child: InkWell(
                                        onTap: () {
                                          Global.confirmDialog(
                                            onConfirmed: () {
                                              advanceC.imagefiles
                                                  .removeAt(index);
                                              back();
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(60),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                            size: 30,
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
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor('#FFA133'),
                        ),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        back();
                      },
                      child: KText(
                        text: 'Cancel',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size?>(Size(109, 35)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            // hexToColor('#007BEC'),
                            hexToColor('#007BEC')),
                        visualDensity: VisualDensity(horizontal: 2),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      onPressed: () {
                        push(ApplyForAdvancePage());
                      },
                      child: KText(
                        text: 'Save',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
