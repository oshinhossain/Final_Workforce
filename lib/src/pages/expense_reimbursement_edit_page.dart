import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:workforce/src/widgets/custom_textfield_with_dropdown.dart';
import 'expense_reimbursement_submit_page.dart';

class ExpenseReimbursementEditPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    expenseRWC.expenseReimbursementSearch.value = null;
    expenseRWC.amount.value = 0.0;
    expenseRWC.getTotalBalance();
    return WillPopScope(
      onWillPop: () {
        expenseRWC.expenseReimbursementSearch.value = null;
        //    expenseRWC.getTotalBalance().isBlank;

        return Future(
          () {
            return true;
          },
        );
      },
      child: Scaffold(
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
                    onPressed: () {
                      back();
                      expenseRWC.expenseReimbursementSearch.value = null;
                      expenseRWC.getTotalBalance();
                    },
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
                  CustomTextFieldWithDropdown(
                    borderColor: hexToColor('#EBEBEC'),
                    suffix: DropdownButton(
                      value: expenseRWC.selectedPurposeType.value,
                      underline: Container(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: hexToColor('#80939D'),
                      ),
                      items: expenseRWC.purposeTypes.map((item) {
                        return DropdownMenuItem(
                          onTap: () {
                            expenseRWC.selectedPurposeType.value = item;
                          },
                          value: item,
                          child: SizedBox(
                            width: Get.width / 1.2,
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
                  SizedBox(height: 8),
                  KText(
                    text: 'Description',
                    color: hexToColor('#80939D'),
                  ),
                  TextFormField(
                    onChanged: expenseRWC.description,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 40),
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  KText(
                    text: 'Amount (BDT)',
                    color: hexToColor('#80939D'),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        expenseRWC.amount.value = num.parse(value);
                      } else {
                        expenseRWC.amount.value = 0.0;
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxHeight: 40),
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: hexToColor('#EBEBEC'),
                          width: .5,
                        ),
                      ),
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 20),
                  expenseRWC.expenseReimbursementSearch.value?.claimRefno ==
                          null
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              KText(
                                text: 'Advance Payment to Adjust',
                                fontSize: 14,
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  // kLog('value');
                                  expenseRWC.searchLocationBottomSheet();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child:
                                      RenderSvg(path: 'icon_search_elements'),
                                ),
                              ),
                            ],
                          ),
                        )
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
                                          if (expenseRWC
                                                  .expenseReimbursementSearch
                                                  .value
                                                  ?.claimRefno !=
                                              null)
                                            KText(
                                              text: 'Ref. No.',
                                              color: hexToColor('#80939D'),
                                            ),
                                          KText(
                                              text: expenseRWC
                                                          .expenseReimbursementSearch
                                                          .value
                                                          ?.claimRefno !=
                                                      null
                                                  ? '${expenseRWC.expenseReimbursementSearch.value?.claimRefno}'
                                                  : ''),
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
                                                  .value
                                                  ?.claimDate !=
                                              null)
                                            KText(
                                                text: formatDate(
                                                    date:
                                                        '${expenseRWC.expenseReimbursementSearch.value?.claimDate}')),
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
                                                            .value
                                                            ?.amount !=
                                                        null
                                                    ? expenseRWC
                                                        .expenseReimbursementSearch
                                                        .value
                                                        ?.amount
                                                        .toString()
                                                    : '0.0'),
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
                                                          .value
                                                          ?.expensePurposeType !=
                                                      null
                                                  ? expenseRWC
                                                      .expenseReimbursementSearch
                                                      .value
                                                      ?.expensePurposeType
                                                  : '',
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
                                width: Get.width / 1.7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    KText(
                                      text: 'Advance Payment to Adjust',
                                      fontSize: 12,
                                    ),
                                    SizedBox(width: 5),
                                    InkWell(
                                      onTap: () {
                                        // kLog('value');
                                        expenseRWC.searchLocationBottomSheet();
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: RenderSvg(
                                            path: 'icon_search_elements'),
                                      ),
                                    ),
                                  ],
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
                  SizedBox(
                    height: 10,
                  ),
                  KText(
                    text: '${expenseRWC.getTotalBalance()}',
                    fontSize: 14,
                  ),
                  Divider(),

                  // TextFormField(
                  //   onChanged: expenseRWC.balanceAmount,
                  //   decoration: InputDecoration(
                  //     constraints: BoxConstraints(maxHeight: 40),
                  //     contentPadding: EdgeInsets.zero,
                  //     enabledBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: hexToColor('#EBEBEC'),
                  //         width: .5,
                  //       ),
                  //     ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: hexToColor('#EBEBEC'),
                  //         width: .5,
                  //       ),
                  //     ),
                  //     border: UnderlineInputBorder(
                  //       borderSide: BorderSide(
                  //         color: hexToColor('#EBEBEC'),
                  //         width: .5,
                  //       ),
                  //     ),
                  //     isDense: true,
                  //   ),
                  // ),

                  SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          expenseRWC.pickMultiImage();
                        },
                        child: RenderSvg(
                          path: 'icon_add_box',
                          width: 22.0,
                          color: hexToColor('#FFA133'),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      KText(
                        text: 'Attachments',
                        color: hexToColor('#80939D'),
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
                                          onPressed: () =>
                                              expenseRWC.pickMultiImage(),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                expenseRWC.imagefiles
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
                          text: 'Cancel',
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
                          push(ExpenseReimbursementSubmitPage());
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
      ),
    );
  }
}
