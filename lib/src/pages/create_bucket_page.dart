import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';

class CreateBucketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        flexibleSpace: KAppbar(),
        bottom: PreferredSize(
            preferredSize: Size(Get.width, 50),
            child: AppBar(
              title: KText(
                text: 'Create Milestone',
                bold: true,
                fontSize: 16,
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                onPressed: back,
              ),
            )),
      ),
      body: Column(children: [
        Container(
          height: 47,
          width: Get.width,
          padding: EdgeInsets.only(left: 15),
          color: hexToColor('#EEF0F6'),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
            KText(text: 'Project Name'),
            KText(
              text: 'BTCL Haor-Baor Project',
              fontSize: 14,
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: 'Milestone ID',
                fontSize: 14,
              ),
              TextFormField(
                initialValue: '02',
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              KText(
                text: 'Milestone Name',
                fontSize: 13,
              ),
              TextFormField(
                initialValue: 'Milestone Name 1 ',
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              KText(
                text: 'Weight Percentage',
                fontSize: 13,
              ),
              TextFormField(
                initialValue: '20',
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              KText(
                text: 'Deadline',
                fontSize: 13,
              ),
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              KText(
                text: 'Description',
                fontSize: 13,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Write advice here',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 34,
              width: 109,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#9BA9B3')),
              child: Center(
                child: KText(
                  text: 'Cancel',
                  bold: true,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 34,
              width: 109,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: hexToColor('#449EF1')),
              child: Center(
                child: KText(
                  text: 'Create',
                  bold: true,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
