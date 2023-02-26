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
import 'package:workforce/src/pages/apply_for_loan_page.dart';
import 'package:workforce/src/widgets/custom_textfield_with_dropdown.dart';

class ApplyForLoanEditPage extends StatelessWidget with Base {
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
                    text: 'Apply for Loan',
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
                    ),
                    KText(
                      text: ' Date',
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
                KText(text: 'Type'),
                CustomTextFieldWithDropdown(
                  suffix: DropdownButton(
                    value: loanC.selectedLoanType.value,
                    underline: Container(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: hexToColor('#80939D'),
                    ),
                    items: loanC.loanTypes.map((item) {
                      return DropdownMenuItem(
                        onTap: () {
                          loanC.selectedLoanType.value = item;
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
                KText(text: 'Description'),
                TextFormField(
                  onChanged: loanC.description,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: .5),
                    // ),
                    // border: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.black, width: .5),
                    // ),
                  ),
                ),
                KText(text: 'Amount (BDT)'),
                TextFormField(
                  onChanged: loanC.amount,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                  ),
                ),
                KText(text: 'Interest Amount (BDT)'),
                TextFormField(
                  onChanged: loanC.interest,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                  ),
                ),
                KText(text: 'Total Payable (BDT)'),
                TextFormField(
                  onChanged: loanC.totalPayable,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                  ),
                ),
                KText(text: 'Monthly Installment Amount (BDT)'),
                TextFormField(
                  onChanged: loanC.installment,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: .5),
                    ),
                  ),
                ),
                KText(text: 'Repayment to Start From'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * .8,
                      child: Column(
                        children: [
                          KText(text: loanC.selectedDate.value),
                          Divider(
                            color: Colors.black.withOpacity(.5),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: loanC.selectDate,
                        child: Icon(Icons.calendar_month))
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        loanC.pickMultiImage();
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
                    KText(text: 'Attachments')
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
                      loanC.imagefiles.isEmpty
                          ? SizedBox()
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: loanC.imagefiles.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final item = loanC.imagefiles[index];
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
                                              loanC.imagefiles.removeAt(index);
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
                        // loanC.loanAddList.add(item)

                        push(ApplyForLoanPage());
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
