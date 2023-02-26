import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/render_svg.dart';
import 'package:workforce/src/helpers/route.dart';

class DefineGoodsDeliveryLocationGeographiesPage extends StatelessWidget with Base {
  final String? id;
  final String? levelFullCode;
  // final MaterialLocationPlanning item;

  DefineGoodsDeliveryLocationGeographiesPage({
    this.id,
    this.levelFullCode,
  });
  @override
  Widget build(BuildContext context) {
    deliveryLocPlaningC.getGeograpphyDataById(id: id!)!.isEmpty && levelFullCode != ''
        ? deliveryLocPlaningC.getDeliveryGeographyLocation(id: id!, levelFullCode: levelFullCode!)
        : null;
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          leading: GestureDetector(
            onTap: () {
              //  deliveryLocPlaningC.updateGeophaphy(id: id, geographyNum: deliveryLocPlaningC.geographyList.length);
              //  defineGoodDeliveryLocC.delGeographyList(id: id);
              back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: hexToColor('#9BA9B3'),
            ),
          ),
          title: KText(
            text: 'Define Goods Delivery Locations for Geographies',
            fontSize: 16,
            bold: true,
            maxLines: 2,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
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
                        Spacer(),
                        KText(
                          text: 'Add ',
                          fontSize: 16,
                          color: hexToColor('#41525A'),
                          bold: true,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('object');
                            deliveryLocPlaningC.geographiesBottomSheet(id: id!);
                          },
                          child: RenderSvg(path: 'icon_add_box'),
                        ),
                      ],
                    ),
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
                        bottom: BorderSide(width: 1, color: AppTheme.borderColor3),
                      ),
                      color: AppTheme.areaColor,
                    ),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [KText(text: 'Area Type'), KText(text: 'Level')],
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
                  deliveryLocPlaningC.getGeograpphyDataById(id: id!)!.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                          itemCount: deliveryLocPlaningC.getGeograpphyDataById(id: id!)!.length,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: ((context, index) {
                            final item = deliveryLocPlaningC.getGeograpphyDataById(id: id!)![index];
                            return Container(
                              height: 113,
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5), border: Border.all(width: 1, color: AppTheme.searchColor)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            KText(text: 'Level 2'),
                                            KText(
                                              text: item.geoLevel2Name,
                                              bold: true,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            deliveryLocPlaningC.deleteupdateGeophaphyList(id: id!, x: item);
                                          },
                                          child: SvgPicture.asset(
                                            '${Constants.svgPath}/icon_delete.svg',
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: AppTheme.searchColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              KText(text: 'Level 3'),
                                              KText(
                                                text: item.geoLevel3Name,
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              KText(text: 'Level 4'),
                                              KText(
                                                text: item.geoLevel4Name,
                                                bold: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: GestureDetector(
                        onTap: () {
                          deliveryLocPlaningC.updateLocationCount(id: id!);
                          back();
                        },
                        child: Container(
                          height: 34,
                          width: 109,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppTheme.primaryColor),
                          child: Center(
                              child: KText(
                            text: 'Confrim',
                            color: Colors.white,
                            bold: true,
                          )),
                        )),
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
