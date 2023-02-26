import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/left_sidebar_component.dart';
import 'package:workforce/src/components/right_sidebar_component.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/global_helper.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/apply_for_advance_edit_page.dart';

class AdvanceApplicationWorkbenchPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    advanceC.advanceGet('');
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
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    back();
                  },
                ),
                Center(
                  child: KText(
                    text: 'Advance Application Workbench',
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
      body: SingleChildScrollView(
        child: Obx(
          () => advanceC.isLoading.value
              ? Center(
                  child: Loading(),
                )
              : advanceC.advanceList.isEmpty
                  ? SizedBox(
                      height: 400,
                      width: 400,
                      child: Center(child: KText(text: 'No Data Found')))
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: advanceC.advanceList.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemBuilder: (context, index) {
                        final item = advanceC.advanceList[index];
                        return Stack(children: [
                          GestureDetector(
                            onTap: () {
                              advanceC.advanceDetailsModal(item.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1,
                                        color: hexToColor('#EBEBEC'))),
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
                                                  text:
                                                      '${item!.applicationRefno}, ${item.applicationDate != null ? formatDate(date: item.applicationDate!) : ''}'),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                advanceC
                                                    .advanceDetailsViewModal(
                                                        item.id);
                                              },
                                              icon: Icon(
                                                Icons.visibility,
                                                color: Colors.blue,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          KText(
                                            text: item.transactionType,
                                            bold: true,
                                            color: hexToColor('#FFA133'),
                                          ),
                                          KText(
                                            text: item.amount.toString(),
                                            bold: true,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
                                        ? hexToColor('#00D8A0')
                                        : item.status == 'Not Approved'
                                            ? hexToColor('#FF3C3C')
                                            : item.status == 'Pending'
                                                ? hexToColor('#007BEC')
                                                : hexToColor('#80939D'),
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: item.status == 'Approved'
                                      ? hexToColor('#DAFFF5')
                                      : item.status == 'Not Approved'
                                          ? hexToColor('#FFEFEF')
                                          : item.status == 'Pending'
                                              ? hexToColor('#DAF2FF')
                                              : hexToColor('#F8F8F8'),
                                  // color: hexToColor('#DAFFF5'),
                                ),
                                child: Center(
                                  child: KText(
                                    text: item.status,
                                    color: item.status == 'Approved'
                                        ? hexToColor('#00D8A0')
                                        : item.status == 'Not Approved'
                                            ? hexToColor('#FF3C3C')
                                            : item.status == 'Pending'
                                                ? hexToColor('#007BEC')
                                                : hexToColor('#80939D'),
                                  ),
                                ),
                              ))
                        ]);
                      }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            push(ApplyForAdvanceEditPage());
          },
          shape: StadiumBorder(),
          child: Icon(Icons.add)),
    );
  }
}
