// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:workforce/src/background/services/background_task_service.dart';
// import 'package:workforce/src/components/k_appbar.dart';
// import 'package:workforce/src/helpers/k_text.dart';

// class TestPage extends StatelessWidget {
//   final _ = Get.put(BackgroundTaskService());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: KAppbar(),
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             await _.startForegroundTask();
//           },
//           child: KText(
//             text: 'IN',
//             fontSize: 30,
//             bold: true,
//           ),
//         ),
//       ),
//     );
//   }
// }
