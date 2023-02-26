import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/controllers/project_list_controller.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/models/project_model.dart';

import '../config/base.dart';

class ProjectListComponent extends StatelessWidget with Base {
  final projectListC = Get.put(ProjectListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => projectListC.projectList.isEmpty
          ? Container(
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
              child: DropdownButton<String>(
                value: '',
                underline: SizedBox(),
                isExpanded: true,
                elevation: 4,
                items: ['']
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: '',
                        alignment: AlignmentDirectional.centerStart,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: KText(
                            text: '',
                            bold: true,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (item) {},
              ),
            )
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
              child: DropdownButton<ProjectModel?>(
                  value: projectListC.selectedProject.value,
                  underline: SizedBox(),
                  isExpanded: true,
                  elevation: 4,
                  items: projectListC.projectList
                      .map(
                        (e) => DropdownMenuItem<ProjectModel?>(
                          value: e,
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: KText(
                              text: e.projectName,
                              bold: true,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (item) {
                    projectListC.selectedProject.value = item;
                  }),
            ),
    );
  }
}
