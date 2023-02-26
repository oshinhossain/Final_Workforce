//search_agency_office_location_by_username
// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';

import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/models/office_location_model.dart';

import '../config/base.dart';
//import 'package:thecitizen/screens/search_known_location/bloc/search_known_location_bloc.dart';
//import 'package:thecitizen/screens/search_known_location/search_known_location_model.dart';

class SearchAgencyOfficeLocation extends StatefulWidget with Base {
  final String title;
  final int uiCodes;

  SearchAgencyOfficeLocation({
    required this.title,
    required this.uiCodes,
  });

  @override
  State<SearchAgencyOfficeLocation> createState() =>
      _SearchAgencyOfficeLocationState();
}

class _SearchAgencyOfficeLocationState
    extends State<SearchAgencyOfficeLocation> {
  late List<OfficeLocationModel> list;
  late Box<OfficeLocationModel> locationBox;

  @override
  void initState() {
    locationBox = Hive.box<OfficeLocationModel>('office');
    if (widget.attendanceC.officeLocList.isNotEmpty) {
      list = widget.attendanceC.officeLocList;
    } else {
      list = [];
    }

    // TODO: implement initState

    super.initState();
  }

  searchLocation(String value) {
    setState(() {
      list = widget.attendanceC.officeLocList
          .where((OfficeLocationModel location) => location.locationName!
              .toLowerCase()
              .startsWith(value.toLowerCase()))
          .toList();
      print('length ${list.length}');
    });
    widget.attendanceC.searchValue.value = value;
  }

  // checkE() {
  //  // kLog('called...');
  //   final selectedLoc =
  //       locationBox.get(widget.agencyC.selectedAgency!.agencyName);
  //  // kLog(selectedLoc!.officeloc!.id);

  //   if (selectedLoc.officeloc != null) {
  //     widget.attendanceC.selectedOfficeLocation.value = selectedLoc.officeloc;
  //    // kLog(
  //         'hi==> ${widget.attendanceC.selectedOfficeLocation.value!.locationName!}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // checkE();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                onChanged: searchLocation,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Search Location...',
                  suffix: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => list.isNotEmpty
                  ? SizedBox(
                      height: Get.height * .75,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                await locationBox.put(
                                    widget.agencyC.selectedAgency!.agencyName,
                                    item);
                                final selectedLoc = locationBox.get(
                                    widget.agencyC.selectedAgency!.agencyName);
                                selectedLoc!.locationName;
                                // kLog(selectedLoc.locationName);
                                widget.attendanceC.location.value =
                                    item.locationName!;
                                widget.attendanceC.controllerDestino.text =
                                    item.locationName!;
                                widget.attendanceC.selectedOfficeLocation
                                    .value = item;
                                widget.attendanceC.selectedKnownLocation.value =
                                    null;

                                back();
                                // Navigator.pop(context, selectedList);
                              },
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${item.locationName} , ${item.address!}',
                                      overflow: TextOverflow.visible,
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
                    )
                  : widget.attendanceC.searchValue.value != ''
                      ? Center(
                          child: KText(
                          text: 'No Location Found',
                        ))
                      : Center(
                          child: Center(
                            child: KText(
                              text: 'No Location Found',
                            ),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
