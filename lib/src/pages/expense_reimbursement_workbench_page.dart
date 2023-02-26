import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/expense_reimbursement_edit_page.dart';
import '../config/app_theme.dart';
import '../config/base.dart';

import '../helpers/global_helper.dart';
import '../helpers/loading.dart';

class ExpenseReimbursementWorkbenchPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    expenseRWC.getExpenseReimbursement();
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
                    text: 'Expense Reimbursement Workbench',
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
      body: SingleChildScrollView(
        child: Obx(
          () => expenseRWC.expenseReimbursementGetList.isEmpty
              ? expenseRWC.isLoading.value
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
                  itemCount: expenseRWC.expenseReimbursementGetList.length,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemBuilder: (context, index) {
                    final item = expenseRWC.expenseReimbursementGetList[index];
                    return Stack(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: hexToColor('#EBEBEC')),
                            color: AppTheme.white,
                            boxShadow: [
                              BoxShadow(
                                color: hexToColor('#EBEBEC'),
                                spreadRadius: 1,
                                blurRadius: 2,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(text: 'Ref. No.'),
                                        KText(
                                            text: item.claimRefno != null
                                                ? '${item.claimRefno}'
                                                : ''),
                                        if (item.claimDate != null)
                                          KText(
                                              text: formatDate(
                                                  date: item.claimDate!)),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        expenseRWC
                                            .viewExpenseReimbursementDialog(
                                                item);
                                        // if (item.status == 'Approved') {
                                        //   GlobalDialog.addSiteDialog(
                                        //     title: 'Expense Reimbursement',
                                        //     widget:
                                        //         // Obx(
                                        //         //   () =>
                                        //         SizedBox(
                                        //       height: Get.height * .9,
                                        //       child: SingleChildScrollView(
                                        //         child: Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               horizontal: 15),
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment
                                        //                     .start,
                                        //             children: [
                                        //               SizedBox(height: 10),
                                        //               Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceBetween,
                                        //                 children: [
                                        //                   Column(
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .start,
                                        //                     children: [
                                        //                       KText(
                                        //                         text:
                                        //                             'Ref. No.',
                                        //                         color: hexToColor(
                                        //                             '#80939D'),
                                        //                       ),
                                        //                       KText(
                                        //                         text: item.claimRefno !=
                                        //                                 null
                                        //                             ? '${item.claimRefno}'
                                        //                             : '',
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                   Column(
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .end,
                                        //                     children: [
                                        //                       KText(
                                        //                         text: 'Date',
                                        //                         color: hexToColor(
                                        //                             '#80939D'),
                                        //                       ),
                                        //                       if (item.claimDate !=
                                        //                           null)
                                        //                         KText(
                                        //                           text: formatDate(
                                        //                               date: item
                                        //                                   .claimDate!),
                                        //                         ),
                                        //                     ],
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               KText(
                                        //                 text: 'Purpose Type',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.expensePurposeType !=
                                        //                         null
                                        //                     ? '${item.expensePurposeType}'
                                        //                     : '',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text: 'Description',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.expenseDescription !=
                                        //                         null
                                        //                     ? '${item.expenseDescription}'
                                        //                     : '',
                                        //                 maxLines: 3,
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text: 'Amount (BDT)',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.amount !=
                                        //                         null
                                        //                     ? '${item.amount}'
                                        //                     : '',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 20),
                                        //               Stack(
                                        //                 clipBehavior: Clip.none,
                                        //                 children: [
                                        //                   Container(
                                        //                     padding: EdgeInsets
                                        //                         .symmetric(
                                        //                             horizontal:
                                        //                                 10,
                                        //                             vertical:
                                        //                                 8),
                                        //                     decoration:
                                        //                         BoxDecoration(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5),
                                        //                       border:
                                        //                           Border.all(
                                        //                         color: hexToColor(
                                        //                             '#EEF0F6'),
                                        //                       ),
                                        //                     ),
                                        //                     child: Column(
                                        //                       children: [
                                        //                         SizedBox(
                                        //                             height: 8),
                                        //                         Row(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .spaceBetween,
                                        //                           children: [
                                        //                             Column(
                                        //                               crossAxisAlignment:
                                        //                                   CrossAxisAlignment
                                        //                                       .start,
                                        //                               children: [
                                        //                                 KText(
                                        //                                   text:
                                        //                                       'Ref. No.',
                                        //                                   color:
                                        //                                       hexToColor('#80939D'),
                                        //                                 ),
                                        //                                 KText(
                                        //                                     text:
                                        //                                         ''),
                                        //                               ],
                                        //                             ),
                                        //                             Column(
                                        //                               crossAxisAlignment:
                                        //                                   CrossAxisAlignment
                                        //                                       .end,
                                        //                               children: [
                                        //                                 KText(
                                        //                                   text:
                                        //                                       'Date',
                                        //                                   color:
                                        //                                       hexToColor('#80939D'),
                                        //                                 ),
                                        //                                 KText(
                                        //                                     text:
                                        //                                         ''),
                                        //                               ],
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                             height: 8),
                                        //                         Row(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .spaceBetween,
                                        //                           children: [
                                        //                             Expanded(
                                        //                               child:
                                        //                                   Column(
                                        //                                 crossAxisAlignment:
                                        //                                     CrossAxisAlignment.start,
                                        //                                 children: [
                                        //                                   KText(
                                        //                                     text:
                                        //                                         'Amount (BDT)',
                                        //                                     color:
                                        //                                         hexToColor('#80939D'),
                                        //                                   ),
                                        //                                   KText(
                                        //                                     text:
                                        //                                         '',
                                        //                                     maxLines:
                                        //                                         2,
                                        //                                   ),
                                        //                                 ],
                                        //                               ),
                                        //                             ),
                                        //                             SizedBox(
                                        //                               width: 10,
                                        //                             ),
                                        //                             Expanded(
                                        //                               child:
                                        //                                   Column(
                                        //                                 crossAxisAlignment:
                                        //                                     CrossAxisAlignment.end,
                                        //                                 children: [
                                        //                                   KText(
                                        //                                     text:
                                        //                                         'Advance Type',
                                        //                                     color:
                                        //                                         hexToColor('#80939D'),
                                        //                                   ),
                                        //                                   KText(
                                        //                                     text:
                                        //                                         '',
                                        //                                     maxLines:
                                        //                                         2,
                                        //                                   ),
                                        //                                 ],
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                   Positioned(
                                        //                     left: 12,
                                        //                     top: -12,
                                        //                     child: Container(
                                        //                       width: Get.width /
                                        //                           1.9,
                                        //                       padding: EdgeInsets
                                        //                           .only(
                                        //                               left: 5),
                                        //                       decoration:
                                        //                           BoxDecoration(
                                        //                         color: Colors
                                        //                             .white,
                                        //                       ),
                                        //                       child: KText(
                                        //                         text:
                                        //                             'Advance Payment to Adjust',
                                        //                         fontSize: 12,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text:
                                        //                     'Balance Amount to Pay (BDT)',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.amount !=
                                        //                         null
                                        //                     ? '${item.amount}'
                                        //                     : '',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 20),
                                        //               KText(
                                        //                 text: 'Attachments',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 5,
                                        //               ),
                                        //               Container(
                                        //                 padding:
                                        //                     EdgeInsets.all(10),
                                        //                 child: Column(
                                        //                   mainAxisAlignment:
                                        //                       MainAxisAlignment
                                        //                           .center,
                                        //                   children: [
                                        //                     expenseRWC
                                        //                             .imagefiles
                                        //                             .isEmpty
                                        //                         ? GridView
                                        //                             .builder(
                                        //                             gridDelegate:
                                        //                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                        //                               crossAxisCount:
                                        //                                   2,
                                        //                               crossAxisSpacing:
                                        //                                   15,
                                        //                             ),
                                        //                             itemCount:
                                        //                                 2,
                                        //                             primary:
                                        //                                 false,
                                        //                             shrinkWrap:
                                        //                                 true,
                                        //                             itemBuilder:
                                        //                                 (BuildContext
                                        //                                         context,
                                        //                                     int index) {
                                        //                               return DottedBorder(
                                        //                                 color: hexToColor(
                                        //                                     '#FFE1BF'),
                                        //                                 strokeWidth:
                                        //                                     2,
                                        //                                 dashPattern: [
                                        //                                   4,
                                        //                                   4
                                        //                                 ],
                                        //                                 borderType:
                                        //                                     BorderType.RRect,
                                        //                                 radius:
                                        //                                     Radius.circular(5),
                                        //                                 child:
                                        //                                     Container(
                                        //                                   // height: 130,
                                        //                                   width:
                                        //                                       double.infinity,
                                        //                                   color:
                                        //                                       hexToColor('#FFFBF7'),
                                        //                                   child:
                                        //                                       Center(
                                        //                                     child:
                                        //                                         IconButton(
                                        //                                       onPressed: () {},
                                        //                                       icon: Icon(
                                        //                                         Icons.add,
                                        //                                         color: Colors.grey,
                                        //                                         size: 15,
                                        //                                       ),
                                        //                                     ),
                                        //                                   ),

                                        //                                   //background color of inner container
                                        //                                 ),
                                        //                               );
                                        //                             },
                                        //                           )
                                        //                         : GridView
                                        //                             .builder(
                                        //                             gridDelegate:
                                        //                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                        //                               crossAxisCount:
                                        //                                   2,
                                        //                             ),
                                        //                             itemCount: expenseRWC
                                        //                                 .imagefiles
                                        //                                 .length,
                                        //                             primary:
                                        //                                 false,
                                        //                             shrinkWrap:
                                        //                                 true,
                                        //                             itemBuilder:
                                        //                                 (BuildContext
                                        //                                         context,
                                        //                                     int index) {
                                        //                               final item =
                                        //                                   expenseRWC
                                        //                                       .imagefiles[index];
                                        //                               return Stack(
                                        //                                 children: [
                                        //                                   Container(
                                        //                                     width:
                                        //                                         double.infinity,
                                        //                                     margin:
                                        //                                         EdgeInsets.all(5),
                                        //                                     decoration:
                                        //                                         BoxDecoration(
                                        //                                       borderRadius: BorderRadius.circular(5),
                                        //                                     ),
                                        //                                     child:
                                        //                                         ClipRRect(
                                        //                                       borderRadius: BorderRadius.circular(5),
                                        //                                       child: Image.file(
                                        //                                         File(item.path),
                                        //                                         fit: BoxFit.cover,
                                        //                                       ),
                                        //                                     ),
                                        //                                   ),
                                        //                                   Positioned(
                                        //                                     top:
                                        //                                         0,
                                        //                                     right:
                                        //                                         0,
                                        //                                     left:
                                        //                                         0,
                                        //                                     bottom:
                                        //                                         0,
                                        //                                     child:
                                        //                                         InkWell(
                                        //                                       onTap: () {},
                                        //                                       child: Container(
                                        //                                         margin: EdgeInsets.all(60),
                                        //                                         decoration: BoxDecoration(
                                        //                                           borderRadius: BorderRadius.circular(50),
                                        //                                           color: Colors.white.withOpacity(0.5),
                                        //                                         ),
                                        //                                         child: Icon(
                                        //                                           Icons.delete,
                                        //                                           color: Colors.redAccent,
                                        //                                           size: 30,
                                        //                                         ),
                                        //                                       ),
                                        //                                     ),
                                        //                                   )
                                        //                                 ],
                                        //                               );
                                        //                             },
                                        //                           ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 15,
                                        //               ),
                                        //               Center(
                                        //                 child: ElevatedButton(
                                        //                   style: ButtonStyle(
                                        //                     minimumSize:
                                        //                         MaterialStateProperty
                                        //                             .all<Size?>(
                                        //                                 Size(
                                        //                                     109,
                                        //                                     35)),
                                        //                     backgroundColor:
                                        //                         MaterialStateProperty
                                        //                             .all<Color>(
                                        //                       hexToColor(
                                        //                           '#FFA133'),
                                        //                     ),
                                        //                     visualDensity:
                                        //                         VisualDensity(
                                        //                             horizontal:
                                        //                                 2),
                                        //                     shape: MaterialStateProperty
                                        //                         .all<
                                        //                             RoundedRectangleBorder>(
                                        //                       RoundedRectangleBorder(
                                        //                         borderRadius:
                                        //                             BorderRadius
                                        //                                 .circular(
                                        //                                     5.0),
                                        //                         // side: BorderSide(color: Colors.red),
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                   onPressed: () {
                                        //                     back();
                                        //                   },
                                        //                   child: KText(
                                        //                     text: 'Close',
                                        //                     fontSize: 16.0,
                                        //                     bold: true,
                                        //                     color: Colors.white,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               SizedBox(height: 30),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),

                                        //     // ),
                                        //   );
                                        // } else {
                                        //   GlobalDialog.addSiteDialog(
                                        //     title: 'View Details',
                                        //     widget:
                                        //         // Obx(
                                        //         //   () =>
                                        //         SizedBox(
                                        //       height: Get.height * .9,
                                        //       child: SingleChildScrollView(
                                        //         child: Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               horizontal: 15),
                                        //           child: Column(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment
                                        //                     .start,
                                        //             children: [
                                        //               SizedBox(height: 10),
                                        //               Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceBetween,
                                        //                 children: [
                                        //                   Column(
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .start,
                                        //                     children: [
                                        //                       KText(
                                        //                         text:
                                        //                             'Ref. No.',
                                        //                         color: hexToColor(
                                        //                             '#80939D'),
                                        //                       ),
                                        //                       KText(
                                        //                         text: item.claimRefno !=
                                        //                                 null
                                        //                             ? '${item.claimRefno}'
                                        //                             : '',
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                   Column(
                                        //                     crossAxisAlignment:
                                        //                         CrossAxisAlignment
                                        //                             .end,
                                        //                     children: [
                                        //                       KText(
                                        //                         text: 'Date',
                                        //                         color: hexToColor(
                                        //                             '#80939D'),
                                        //                       ),
                                        //                       if (item.claimDate !=
                                        //                           null)
                                        //                         KText(
                                        //                           text: formatDate(
                                        //                               date: item
                                        //                                   .claimDate!),
                                        //                         ),
                                        //                     ],
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               KText(
                                        //                 text: 'Purpose Type',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: 'Other',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text: 'Description',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.expenseDescription !=
                                        //                         null
                                        //                     ? '${item.expenseDescription}'
                                        //                     : '',
                                        //                 maxLines: 3,
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text: 'Amount (BDT)',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: item.amount !=
                                        //                         null
                                        //                     ? '${item.amount}'
                                        //                     : '',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 20),
                                        //               Stack(
                                        //                 clipBehavior: Clip.none,
                                        //                 children: [
                                        //                   Container(
                                        //                     padding: EdgeInsets
                                        //                         .symmetric(
                                        //                             horizontal:
                                        //                                 10,
                                        //                             vertical:
                                        //                                 8),
                                        //                     decoration:
                                        //                         BoxDecoration(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5),
                                        //                       border:
                                        //                           Border.all(
                                        //                         color: hexToColor(
                                        //                             '#EEF0F6'),
                                        //                       ),
                                        //                     ),
                                        //                     child: Column(
                                        //                       children: [
                                        //                         SizedBox(
                                        //                             height: 8),
                                        //                         Row(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .spaceBetween,
                                        //                           children: [
                                        //                             Column(
                                        //                               crossAxisAlignment:
                                        //                                   CrossAxisAlignment
                                        //                                       .start,
                                        //                               children: [
                                        //                                 KText(
                                        //                                   text:
                                        //                                       'Ref. No.',
                                        //                                   color:
                                        //                                       hexToColor('#80939D'),
                                        //                                 ),
                                        //                                 KText(
                                        //                                     text:
                                        //                                         ''),
                                        //                               ],
                                        //                             ),
                                        //                             Column(
                                        //                               crossAxisAlignment:
                                        //                                   CrossAxisAlignment
                                        //                                       .end,
                                        //                               children: [
                                        //                                 KText(
                                        //                                   text:
                                        //                                       'Date',
                                        //                                   color:
                                        //                                       hexToColor('#80939D'),
                                        //                                 ),
                                        //                                 KText(
                                        //                                     text:
                                        //                                         ''),
                                        //                               ],
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                         SizedBox(
                                        //                             height: 8),
                                        //                         Row(
                                        //                           mainAxisAlignment:
                                        //                               MainAxisAlignment
                                        //                                   .spaceBetween,
                                        //                           children: [
                                        //                             Expanded(
                                        //                               child:
                                        //                                   Column(
                                        //                                 crossAxisAlignment:
                                        //                                     CrossAxisAlignment.start,
                                        //                                 children: [
                                        //                                   KText(
                                        //                                     text:
                                        //                                         'Amount (BDT)',
                                        //                                     color:
                                        //                                         hexToColor('#80939D'),
                                        //                                   ),
                                        //                                   KText(
                                        //                                     text:
                                        //                                         '',
                                        //                                     maxLines:
                                        //                                         2,
                                        //                                   ),
                                        //                                 ],
                                        //                               ),
                                        //                             ),
                                        //                             SizedBox(
                                        //                               width: 10,
                                        //                             ),
                                        //                             Expanded(
                                        //                               child:
                                        //                                   Column(
                                        //                                 crossAxisAlignment:
                                        //                                     CrossAxisAlignment.end,
                                        //                                 children: [
                                        //                                   KText(
                                        //                                     text:
                                        //                                         'Advance Type',
                                        //                                     color:
                                        //                                         hexToColor('#80939D'),
                                        //                                   ),
                                        //                                   KText(
                                        //                                     text:
                                        //                                         '',
                                        //                                     maxLines:
                                        //                                         2,
                                        //                                   ),
                                        //                                 ],
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                   Positioned(
                                        //                     left: 12,
                                        //                     top: -12,
                                        //                     child: Container(
                                        //                       width: Get.width /
                                        //                           1.9,
                                        //                       padding: EdgeInsets
                                        //                           .only(
                                        //                               left: 5),
                                        //                       decoration:
                                        //                           BoxDecoration(
                                        //                         color: Colors
                                        //                             .white,
                                        //                       ),
                                        //                       child: KText(
                                        //                         text:
                                        //                             'Advance Payment to Adjust',
                                        //                         fontSize: 12,
                                        //                       ),
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               SizedBox(height: 8),
                                        //               KText(
                                        //                 text:
                                        //                     'Balance Amount to Pay (BDT)',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(height: 5),
                                        //               KText(
                                        //                 text: '',
                                        //               ),
                                        //               Divider(
                                        //                   color: hexToColor(
                                        //                       '#EBEBEC')),
                                        //               SizedBox(height: 20),
                                        //               KText(
                                        //                 text: 'Attachments',
                                        //                 color: hexToColor(
                                        //                     '#80939D'),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 5,
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 80,
                                        //                 width: Get.width * .8,
                                        //                 child: Obx(
                                        //                     () => expenseRWC
                                        //                                 .fileCount
                                        //                                 .value ==
                                        //                             ''
                                        //                         ? Container(
                                        //                             alignment:
                                        //                                 Alignment
                                        //                                     .center,
                                        //                             width:
                                        //                                 Get.width *
                                        //                                     .8,
                                        //                             height: 20,
                                        //                             child: Text(
                                        //                                 'No Image Found'))
                                        //                         : expenseRWC.fileCount
                                        //                                     .value ==
                                        //                                 '0'
                                        //                             ? Container(
                                        //                                 alignment:
                                        //                                     Alignment
                                        //                                         .center,
                                        //                                 width: Get.width *
                                        //                                     .8,
                                        //                                 height:
                                        //                                     20,
                                        //                                 child: Text(
                                        //                                     'No Image Found'))
                                        //                             : ListView(
                                        //                                 shrinkWrap:
                                        //                                     true,
                                        //                                 scrollDirection:
                                        //                                     Axis.horizontal,
                                        //                                 children: expenseRWC
                                        //                                     .evedenceImages[expenseRWC.evedenceImages.indexWhere((e) =>
                                        //                                         e.progressId ==
                                        //                                         expenseRWC.expenseReimbursementSearch.value!.claimRefno)]
                                        //                                     .images
                                        //                                     .map((e) => GestureDetector(
                                        //                                           onTap: () {
                                        //                                             Get.dialog(
                                        //                                               barrierDismissible: false,
                                        //                                               // backgroundColor: Colors.transparent,
                                        //                                               // contentPadding: EdgeInsets.zero,
                                        //                                               // content:
                                        //                                               Column(
                                        //                                                 children: [
                                        //                                                   Align(
                                        //                                                     alignment: Alignment.topRight,
                                        //                                                     child: GestureDetector(
                                        //                                                         onTap: () {
                                        //                                                           Get.back();
                                        //                                                         },
                                        //                                                         child: Icon(
                                        //                                                           Icons.close,
                                        //                                                           color: Colors.white,
                                        //                                                           size: 45,
                                        //                                                         )),
                                        //                                                   ),
                                        //                                                   SizedBox(
                                        //                                                     height: Get.height * .8,
                                        //                                                     width: Get.width * .7,
                                        //                                                     child: PhotoView(backgroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10)), imageProvider: NetworkImage(e)),
                                        //                                                   ),
                                        //                                                 ],
                                        //                                               ),
                                        //                                             );
                                        //                                           },
                                        //                                           child: Padding(
                                        //                                             padding: EdgeInsets.symmetric(vertical: 4.0),
                                        //                                             child: Container(
                                        //                                               height: 45,
                                        //                                               width: 80,
                                        //                                               decoration: BoxDecoration(
                                        //                                                 image: DecorationImage(
                                        //                                                   image: NetworkImage(e),
                                        //                                                 ),
                                        //                                               ),
                                        //                                             ),
                                        //                                           ),
                                        //                                         ))
                                        //                                     .toList(),
                                        //                               )
                                        //                     // : Text('data'),
                                        //                     ),
                                        //               ),

                                        //               // Container(
                                        //               //   padding:
                                        //               //       EdgeInsets.all(10),
                                        //               //   child: Column(
                                        //               //     mainAxisAlignment:
                                        //               //         MainAxisAlignment
                                        //               //             .center,
                                        //               //     children: [
                                        //               //       expenseRWC
                                        //               //               .imagefiles
                                        //               //               .isEmpty
                                        //               //           ? GridView
                                        //               //               .builder(
                                        //               //               gridDelegate:
                                        //               //                   const SliverGridDelegateWithFixedCrossAxisCount(
                                        //               //                 crossAxisCount:
                                        //               //                     2,
                                        //               //                 crossAxisSpacing:
                                        //               //                     15,
                                        //               //               ),
                                        //               //               itemCount:
                                        //               //                   2,
                                        //               //               primary:
                                        //               //                   false,
                                        //               //               shrinkWrap:
                                        //               //                   true,
                                        //               //               itemBuilder:
                                        //               //                   (BuildContext
                                        //               //                           context,
                                        //               //                       int index) {
                                        //               //                 return DottedBorder(
                                        //               //                   color: hexToColor(
                                        //               //                       '#FFE1BF'),
                                        //               //                   strokeWidth:
                                        //               //                       2,
                                        //               //                   dashPattern: [
                                        //               //                     4,
                                        //               //                     4
                                        //               //                   ],
                                        //               //                   borderType:
                                        //               //                       BorderType.RRect,
                                        //               //                   radius:
                                        //               //                       Radius.circular(5),
                                        //               //                   child:
                                        //               //                       Container(
                                        //               //                     // height: 130,
                                        //               //                     width:
                                        //               //                         double.infinity,
                                        //               //                     color:
                                        //               //                         hexToColor('#FFFBF7'),
                                        //               //                     child:
                                        //               //                         Center(
                                        //               //                       child:
                                        //               //                           IconButton(
                                        //               //                         onPressed: () {},
                                        //               //                         icon: Icon(
                                        //               //                           Icons.add,
                                        //               //                           color: Colors.grey,
                                        //               //                           size: 15,
                                        //               //                         ),
                                        //               //                       ),
                                        //               //                     ),

                                        //               //                     //background color of inner container
                                        //               //                   ),
                                        //               //                 );
                                        //               //               },
                                        //               //             )
                                        //               //           : GridView
                                        //               //               .builder(
                                        //               //               gridDelegate:
                                        //               //                   const SliverGridDelegateWithFixedCrossAxisCount(
                                        //               //                 crossAxisCount:
                                        //               //                     2,
                                        //               //               ),
                                        //               //               itemCount: expenseRWC
                                        //               //                   .imagefiles
                                        //               //                   .length,
                                        //               //               primary:
                                        //               //                   false,
                                        //               //               shrinkWrap:
                                        //               //                   true,
                                        //               //               itemBuilder:
                                        //               //                   (BuildContext
                                        //               //                           context,
                                        //               //                       int index) {
                                        //               //                 final item =
                                        //               //                     expenseRWC
                                        //               //                         .imagefiles[index];
                                        //               //                 return Stack(
                                        //               //                   children: [
                                        //               //                     Container(
                                        //               //                       width:
                                        //               //                           double.infinity,
                                        //               //                       margin:
                                        //               //                           EdgeInsets.all(5),
                                        //               //                       decoration:
                                        //               //                           BoxDecoration(
                                        //               //                         borderRadius: BorderRadius.circular(5),
                                        //               //                       ),
                                        //               //                       child:
                                        //               //                           ClipRRect(
                                        //               //                         borderRadius: BorderRadius.circular(5),
                                        //               //                         child: Image.file(
                                        //               //                           File(item.path),
                                        //               //                           fit: BoxFit.cover,
                                        //               //                         ),
                                        //               //                       ),
                                        //               //                     ),
                                        //               //                     Positioned(
                                        //               //                       top:
                                        //               //                           0,
                                        //               //                       right:
                                        //               //                           0,
                                        //               //                       left:
                                        //               //                           0,
                                        //               //                       bottom:
                                        //               //                           0,
                                        //               //                       child:
                                        //               //                           InkWell(
                                        //               //                         onTap: () {},
                                        //               //                         child: Container(
                                        //               //                           margin: EdgeInsets.all(60),
                                        //               //                           decoration: BoxDecoration(
                                        //               //                             borderRadius: BorderRadius.circular(50),
                                        //               //                             color: Colors.white.withOpacity(0.5),
                                        //               //                           ),
                                        //               //                           child: Icon(
                                        //               //                             Icons.delete,
                                        //               //                             color: Colors.redAccent,
                                        //               //                             size: 30,
                                        //               //                           ),
                                        //               //                         ),
                                        //               //                       ),
                                        //               //                     )
                                        //               //                   ],
                                        //               //                 );
                                        //               //               },
                                        //               //             ),
                                        //               //     ],
                                        //               //   ),
                                        //               // ),

                                        //               SizedBox(
                                        //                 height: 15,
                                        //               ),
                                        //               Row(
                                        //                 mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .spaceEvenly,
                                        //                 children: [
                                        //                   ElevatedButton(
                                        //                     style: ButtonStyle(
                                        //                       minimumSize:
                                        //                           MaterialStateProperty.all<
                                        //                                   Size?>(
                                        //                               Size(109,
                                        //                                   35)),
                                        //                       backgroundColor:
                                        //                           MaterialStateProperty
                                        //                               .all<
                                        //                                   Color>(
                                        //                         hexToColor(
                                        //                             '#FFA133'),
                                        //                       ),
                                        //                       visualDensity:
                                        //                           VisualDensity(
                                        //                               horizontal:
                                        //                                   2),
                                        //                       shape: MaterialStateProperty
                                        //                           .all<
                                        //                               RoundedRectangleBorder>(
                                        //                         RoundedRectangleBorder(
                                        //                           borderRadius:
                                        //                               BorderRadius
                                        //                                   .circular(
                                        //                                       5.0),
                                        //                           // side: BorderSide(color: Colors.red),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     onPressed: () {
                                        //                       back();
                                        //                     },
                                        //                     child: KText(
                                        //                       text: 'Close',
                                        //                       fontSize: 16.0,
                                        //                       bold: true,
                                        //                       color:
                                        //                           Colors.white,
                                        //                     ),
                                        //                   ),
                                        //                   // Spacer(),
                                        //                   ElevatedButton(
                                        //                     style: ButtonStyle(
                                        //                       minimumSize:
                                        //                           MaterialStateProperty.all<
                                        //                                   Size?>(
                                        //                               Size(109,
                                        //                                   35)),
                                        //                       backgroundColor:
                                        //                           MaterialStateProperty.all<
                                        //                                   Color>(
                                        //                               // hexToColor('#007BEC'),
                                        //                               hexToColor(
                                        //                                   '#007BEC')),
                                        //                       visualDensity:
                                        //                           VisualDensity(
                                        //                               horizontal:
                                        //                                   2),
                                        //                       shape: MaterialStateProperty
                                        //                           .all<
                                        //                               RoundedRectangleBorder>(
                                        //                         RoundedRectangleBorder(
                                        //                           borderRadius:
                                        //                               BorderRadius
                                        //                                   .circular(
                                        //                                       5.0),
                                        //                           // side: BorderSide(color: Colors.red),
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                     onPressed: () {
                                        //                       // kLog('Edit');
                                        //                       back();
                                        //                       expenseRWC
                                        //                           .editExpenseReimbursementDialog();
                                        //                     },
                                        //                     child: KText(
                                        //                       text: 'Edit',
                                        //                       fontSize: 16.0,
                                        //                       bold: true,
                                        //                       color:
                                        //                           Colors.white,
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //               SizedBox(height: 30),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),

                                        //     // ),
                                        //   );
                                        // }
                                      },
                                      icon: Icon(
                                        Icons.visibility,
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: hexToColor('#EBEBEC'),
                                thickness: 1.5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    KText(
                                      text: item.expensePurposeType != null
                                          ? '${item.expensePurposeType}'
                                          : '',
                                      bold: true,
                                      color: hexToColor('#FFA133'),
                                    ),
                                    KText(
                                      text: item.amount != null
                                          ? '${item.amount}'
                                          : '',
                                      bold: true,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: 20,
                          top: 10,
                          child: Container(
                            width: 90,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: item.status == 'Approved'
                                      ? hexToColor('#81FFDE')
                                      : item.status == 'Draft'
                                          ? hexToColor('#E6E6E6')
                                          : item.status == 'Rejected'
                                              ? hexToColor('#FFEFEF')
                                              : hexToColor('#9ACFFF')),
                              borderRadius: BorderRadius.circular(50),
                              color: item.status == 'Approved'
                                  ? hexToColor('#CAFDF0')
                                  : item.status == 'Draft'
                                      ? hexToColor('#F8F8F8')
                                      : item.status == 'Rejected'
                                          ? hexToColor('#FFEFEF')
                                          : hexToColor('#DAF2FF'),
                            ),
                            child: Center(
                              child: KText(
                                bold: true,
                                text:
                                    item.status != null ? '${item.status}' : '',
                                color: item.status == 'Approved'
                                    ? hexToColor('#00D8A0')
                                    : item.status == 'Draft'
                                        ? hexToColor('#80939D')
                                        : item.status == 'Rejected'
                                            ? hexToColor('#FF3C3C')
                                            : hexToColor('#007BEC'),
                              ),
                            ),
                          ))
                    ]);
                  }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(ExpenseReimbursementEditPage());
        },
        backgroundColor: Colors.white,
        shape: StadiumBorder(),
        child: CircleAvatar(radius: 27, child: Icon(Icons.add)),
      ),
    );
  }
}
