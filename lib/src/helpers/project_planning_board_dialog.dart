// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hex_color.dart';

class ProjectPlanningDialogHelper {
  ProjectPlanningDialogHelper._();
  //show error dialog
  static projectPlanningInputDialog({
    required String title,
    required String inputLabel,
    required Function onChanged,
    required VoidCallback? onPressed,
    // required String inputValue,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 13, bottom: 13),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hexToColor('#0465BF'),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  border: Border.all(color: hexToColor('#FFFFFF'), width: 1),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: hexToColor('#FFFFFF'),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show error dialog

//====================================================

}

  //hide loading







// class ProjectPlanningDialogHelper {
//   ProjectPlanningDialogHelper._();
//   //show error dialog
//   static void aleartDialog(String message) async {
//     return Get.generalDialog( 
//         barrierDismissible: true,
//         pageBuilder: (BuildContext context, Animation<double> animation,
//             Animation<double> secondaryAnimation) {
//           return SizedBox(
//             height: 200,
//             width: 380,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                     height: 40,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: hexToColor('#FFB661'),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(6),
//                         topRight: Radius.circular(6),
//                       ),
//                     ),
//                     child: KText(
//                       text: 'Go to Group Planning Board',
//                       bold: true,
//                       fontSize: 18,
//                     )),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: 10,
//                   ),
//                   child: Dropdown(),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

// class Dropdown extends StatelessWidget with Base {
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CustomTextFieldProjectdashboard(
//         title: 'Bucket',
//         isTooltipRequired: false,
//         suffix: DropdownButton(
//           value: projectPlanningC.selectprojecBucketType.value,
//           underline: Container(),
//           icon: Icon(
//             Icons.keyboard_arrow_down,
//             color: hexToColor('#80939D'),
//           ),
//           items: projectPlanningC.projecBucket.map((item) {
//             return DropdownMenuItem(
//               value: item,
//               child: SizedBox(
//                 width: Get.width / 1.2,
//                 child: KText(
//                   text: item,
//                   fontSize: 15,
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             projectPlanningC.selectprojecBucketType.value = newValue!;
//           },
//         ),
//       ),
//     );
//   }
// }

// //show success Dialog







//-----------------------------------------