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
import 'package:workforce/src/helpers/route.dart';

class ApplyForLoanPage extends StatelessWidget with Base {
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
          child: Column(
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
              KText(text: loanC.selectedLoanType.value),
              Divider(),
              KText(text: 'Description'),
              KText(
                text: loanC.description.value,
                maxLines: 3,
              ),
              Divider(),
              KText(text: 'Amount (BDT)'),
              KText(text: loanC.amount.value),
              Divider(),
              KText(text: 'Interest Amount (BDT)'),
              KText(text: loanC.interest.value),
              Divider(),
              KText(text: 'Total Payable (BDT)'),
              KText(text: loanC.totalPayable.value),
              Divider(),
              KText(text: 'Monthly Installment Amount (BDT)'),
              KText(text: loanC.installment.value),
              Divider(),
              KText(text: 'Repayment to Start From'),
              KText(text: 'January 2023'),
              Divider(),
              KText(text: 'Attachments'),
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
                        return Container(
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
                        );
                      },
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size?>(Size(109, 35)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          // hexToColor('#007BEC'),
                          hexToColor('#007BEC')),
                      visualDensity: VisualDensity(horizontal: 2),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          // side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    onPressed: () {
                      loanC.loanAdd('add');
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
    );
  }
}
