import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/app.dart';
import 'package:workforce/src/controllers/config_controller.dart';

late List<CameraDescription> cameras;
void main() async {
  await Get.put(ConfigController()).initAppConfig();
  cameras = await availableCameras();
  runApp(App());
}
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Time Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String? _timeString;

//   @override
//   void initState() {
//     _timeString = DateFormat('d MMM y hh:mm:ss a').format(DateTime.now());
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Time Demo'),
//       ),
//       body: Center(
//         child: Text(_timeString!),
//       ),
//     );
//   }

//   void _getTime() {
//     final String formattedDateTime =
//         DateFormat('d MMM y hh:mm:ss a').format(DateTime.now());
//     setState(() {
//       _timeString = formattedDateTime;
//     });
//   }
// }

