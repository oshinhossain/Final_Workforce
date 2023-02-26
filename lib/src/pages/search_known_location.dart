import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workforce/src/config/base.dart';

import '../helpers/k_text.dart';

import '../helpers/route.dart';
import '../models/known_office_location_model.dart';

class SearchKnownLocation extends StatefulWidget {
  final String title;
  final int uiCodes;

  SearchKnownLocation({
    required this.title,
    required this.uiCodes,
  });

  @override
  State<SearchKnownLocation> createState() => _SearchKnownLocationState();
}

class _SearchKnownLocationState extends State<SearchKnownLocation> with Base {
  List<KnownOfficeLocationModel>? list;
  late Box<KnownOfficeLocationModel> locationBox;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    locationBox = Hive.box<KnownOfficeLocationModel>('known');
    if (attendanceC.knownOfficeLocationList.isNotEmpty) {
      list = attendanceC.knownOfficeLocationList;
    } else {
      list = [];
    }
    // TODO: implement initState
    super.initState();
  }

  searchLocation(String value) {
    setState(() {
      list = attendanceC.knownOfficeLocationList
          .where((KnownOfficeLocationModel location) => location.locationName!
              .toLowerCase()
              .startsWith(value.toLowerCase()))
          .toList();
    });
    attendanceC.searchValue.value = value;
  }

  @override
  Widget build(BuildContext context) {
    //attendanceC.getKnownLocation();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(
          widget.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextField(
                onChanged: searchLocation,
                // controller: query,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search Location...',
                  suffix: IconButton(
                    icon: Icon(
                      Icons.search,
                      // color: textColor9,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => list!.isNotEmpty
                  ? SizedBox(
                      height: Get.height * .75,
                      width: Get.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: list!.length,
                        itemBuilder: (context, index) {
                          final item = list![index];
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                await locationBox.put(
                                    agencyC.selectedAgency!.agencyName, item);
                                final selectedLoc = locationBox
                                    .get(agencyC.selectedAgency!.agencyName);
                                selectedLoc!.locationName;
                                // kLog(selectedLoc.locationName);
                                attendanceC.location.value = item.locationName!;
                                attendanceC.controllerDestino.text =
                                    item.locationName!;
                                attendanceC.selectedKnownLocation.value = item;

                                attendanceC.location.value = item.locationName!;
                                attendanceC.controllerDestino.text =
                                    item.locationName!;
                                attendanceC.selectedKnownLocation.value = item;

                                back();
                                // Navigator.pop(context, selectedList);
                              },
                              title: item.locationName != ''
                                  ? KText(
                                      text:
                                          '${item.locationName!} , ${item.address!}',
                                      textOverflow: TextOverflow.visible,
                                    )
                                  : KText(text: ''),
                            ),
                          );
                        },
                      ),
                    )
                  : attendanceC.searchValue.value != ''
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
