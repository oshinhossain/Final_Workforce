import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/models/agency_model.dart';
import '../config/base.dart';

class AgencyListComponent extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => agencyC.agencies.isEmpty
          ? Container()
          : Container(
              width: Get.width,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButton<AgencyModel>(
                  value: agencyC.selectedAgency,
                  underline: SizedBox(),
                  isExpanded: true,
                  elevation: 4,
                  items: agencyC.agencies
                      .map(
                        (e) => DropdownMenuItem<AgencyModel>(
                          value: e,
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: KText(
                              text: e.agencyName,
                              bold: true,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (x) async {
                    agencyC.setSelectedAgency = x;
                    attendanceC.location.value = '';
                    attendanceC.controllerDestino.clear();
                    attendanceC.selectedKnownLocation.value = null;
                    attendanceC.stopWatchTimer.value = StopWatchTimer(
                      mode: StopWatchMode.countUp,
                      presetMillisecond:
                          StopWatchTimer.getMilliSecFromSecond(0),
                    );
                    agencyC.putSelectedAgency(x);
                    await attendanceC.getAttendaneHistory();
                  }),
            ),
    );
  }
}
