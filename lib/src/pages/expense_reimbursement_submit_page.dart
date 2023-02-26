import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';

import '../config/base.dart';

class ExpenseReimbursementSubmitPage extends StatelessWidget with Base {
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
                Center(
                  child: KText(
                    text: 'Claim Expense Reimbursement',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Ref. No.',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: '(Auto)',
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        KText(
                          text: 'Date',
                          color: hexToColor('#80939D'),
                        ),
                        KText(
                          text: formatDate(date: DateTime.now().toString()),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(color: hexToColor('#EBEBEC')),
                KText(
                  text: 'Purpose Type',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: expenseRWC.selectedPurposeType.value,
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 8),
                KText(
                  text: 'Description',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: expenseRWC.description.value,
                  maxLines: 3,
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 8),
                KText(
                  text: 'Amount (BDT)',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: expenseRWC.amount.value.toString(),
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 20),
                expenseRWC.expenseReimbursementSearch.value?.claimRefno == null
                    ? SizedBox()
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: hexToColor('#EEF0F6'),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Ref. No.',
                                          color: hexToColor('#80939D'),
                                        ),
                                        KText(
                                            text: expenseRWC
                                                .expenseReimbursementSearch
                                                .value
                                                ?.claimRefno),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        KText(
                                          text: 'Date',
                                          color: hexToColor('#80939D'),
                                        ),
                                        if (expenseRWC
                                                .expenseReimbursementSearch
                                                .value!
                                                .claimDate !=
                                            null)
                                          KText(
                                              text: formatDate(
                                                  date: expenseRWC
                                                      .expenseReimbursementSearch
                                                      .value!
                                                      .claimDate!)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'Amount (BDT)',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                            text: expenseRWC
                                                .expenseReimbursementSearch
                                                .value!
                                                .amount
                                                .toString(),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          KText(
                                            text: 'Advance Type',
                                            color: hexToColor('#80939D'),
                                          ),
                                          KText(
                                            text: expenseRWC
                                                .expenseReimbursementSearch
                                                .value!
                                                .expensePurposeType,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: -12,
                            child: Container(
                              width: Get.width / 1.9,
                              padding: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: KText(
                                text: 'Advance Payment to Adjust',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(height: 8),
                KText(
                  text: 'Balance Amount to Pay (BDT)',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(height: 5),
                KText(
                  text: '${expenseRWC.getTotalBalance()}',
                ),
                Divider(color: hexToColor('#EBEBEC')),
                SizedBox(height: 20),
                KText(
                  text: 'Attachments',
                  color: hexToColor('#80939D'),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      expenseRWC.imagefiles.isEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                              ),
                              itemCount: 2,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return DottedBorder(
                                  color: hexToColor('#FFE1BF'),
                                  strokeWidth: 2,
                                  dashPattern: [4, 4],
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(5),
                                  child: Container(
                                    // height: 130,
                                    width: double.infinity,
                                    color: hexToColor('#FFFBF7'),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                      ),
                                    ),

                                    //background color of inner container
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: expenseRWC.imagefiles.length,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final item = expenseRWC.imagefiles[index];
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
                                        onTap: () {},
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        text: 'Edit',
                        fontSize: 16.0,
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                    // Spacer(),
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
                        expenseRWC.postExpenseReimbursement();
                      },
                      child: KText(
                        text: 'Submit',
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
