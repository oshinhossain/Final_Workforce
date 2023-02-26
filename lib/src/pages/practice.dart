// import 'package:flutter/material.dart';
// import 'package:workforce/src/components/k_appbar.dart';

// class PracticePage extends StatelessWidget {
//   const PracticePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: KAppbar(),
//       body: SingleChildScrollView(
//         child: SizedBox(),
//       ),
//     );
//   }
// }

// class RegisterPage extends StatelessWidget  {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme:
//           ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
//       darkTheme: ThemeData(brightness: Brightness.dark),
//       home: SafeArea(
//           child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       Form(
//                         key: _formKey,
//                         child: Theme(
//                             data: ThemeData(
//                                 primaryColor: Colors.blue,
//                                 inputDecorationTheme: InputDecorationTheme(
//                                     labelStyle: TextStyle(
//                                   color: Colors.lightBlue,
//                                   fontSize: 20.0,
//                                 )), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.purple)),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     "Register",
//                                     style: TextStyle(
//                                         fontSize: 30.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Full Name",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Address",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Phone Number",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Company Name",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Email Address",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 20.0),
//                                     child: Text(
//                                       "Password",
//                                       style: TextStyle(
//                                         fontSize: 20.0,
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     style: TextStyle(color: Colors.grey),
//                                     decoration: InputDecoration(
//                                         labelStyle: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                         enabledBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.grey),
//                                         ),
//                                         focusedBorder: UnderlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.blue),
//                                         ),
//                                         border: UnderlineInputBorder()),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   Align(
//                                     alignment: Alignment.center,
//                                     child: Container(
//                                       margin: const EdgeInsets.only(top: 40.0),
//                                       child: MaterialButton(
//                                         textColor: Colors.white,
//                                         minWidth: 250.0,
//                                         padding: const EdgeInsets.all(15.0),
//                                         color: Colors.blue[400],
//                                         child: Text(
//                                           "Register",
//                                           style: TextStyle(
//                                               color: Colors.white,
// //                                    fontWeight: FontWeight.bold,
//                                               fontSize: 20.0),
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(50.0)),
//                                         onPressed: () {
//                                           if (_formKey.currentState
//                                               .validate()) {}
//                                         },
//                                         splashColor: Colors.redAccent[100],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )),
//                       )
//                     ],
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }








//   // Widget materials() {
//   //   return ListView.builder(
//   //     shrinkWrap: true,
//   //     primary: false,
//   //     itemCount: 5,
//   //     itemBuilder: (BuildContext context, int index) {
//   //       return Obx(
//   //         () => GestureDetector(
//   //           onTap: () => materialC.isExpanded.toggle(),
//   //           child: Container(
//   //             margin: EdgeInsets.only(top: 12),
//   //             height: materialC.isExpanded.value ? 200 : 150,
//   //             width: double.infinity,
//   //             decoration: BoxDecoration(
//   //                 border: Border.all(color: hexToColor('#DBECFB'), width: 2)),
//   //             child: Column(
//   //               children: [
//   //                 Container(
//   //                   width: Get.width,
//   //                   height: 40,
//   //                   decoration: BoxDecoration(
//   //                       // borderRadius: BorderRadius.circular(12),
//   //                       // border: Border.all(),
//   //                       color: hexToColor('#DBECFB')),
//   //                   child: Row(
//   //                     children: [
//   //                       SizedBox(
//   //                         width: 10,
//   //                       ),
//   //                       Icon(
//   //                         Icons.check_box_outlined,
//   //                         color: hexToColor('#84BEF3'),
//   //                       ),
//   //                       SizedBox(
//   //                         width: 5,
//   //                       ),
//   //                       KText(
//   //                         text: 'Item Name 01 (Code)',
//   //                         bold: true,
//   //                       ),
//   //                       Spacer(),
//   //                       SizedBox(
//   //                         width: 8,
//   //                       ),
//   //                       Icon(
//   //                         materialC.isExpanded.value
//   //                             ? EvaIcons.arrowIosUpwardOutline
//   //                             : EvaIcons.arrowIosDownwardOutline,
//   //                         color: hexToColor('#80939D'),
//   //                       ),
//   //                       SizedBox(
//   //                         width: 12,
//   //                       )
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 SizedBox(
//   //                   height: 12,
//   //                 ),
//   //                 Padding(
//   //                   padding:   EdgeInsets.only(left: 10, right: 10),
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                     children: [
//   //                       Text('Serial No.'),
//   //                       Text('Weight'),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 SizedBox(
//   //                   height: 5,
//   //                 ),
//   //                 materialC.isExpanded.value
//   //                     ? Column(
//   //                         children: [
//   //                           Padding(
//   //                             padding:
//   //                                   EdgeInsets.only(left: 10, right: 10),
//   //                             child: Row(
//   //                               mainAxisAlignment:
//   //                                   MainAxisAlignment.spaceBetween,
//   //                               children: [
//   //                                 Row(
//   //                                   mainAxisAlignment:
//   //                                       MainAxisAlignment.spaceBetween,
//   //                                   children: [
//   //                                     Text('26345634'),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Text('-'),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Text('21741273'),
//   //                                   ],
//   //                                 ),
//   //                                 Text('155 Kg'),
//   //                               ],
//   //                             ),
//   //                           ),
//   //                           SizedBox(
//   //                             height: 16,
//   //                           ),
//   //                           Padding(
//   //                             padding:
//   //                                   EdgeInsets.only(left: 10, right: 10),
//   //                             child: Row(
//   //                               mainAxisAlignment:
//   //                                   MainAxisAlignment.spaceBetween,
//   //                               children: [
//   //                                 Row(
//   //                                   mainAxisAlignment:
//   //                                       MainAxisAlignment.spaceBetween,
//   //                                   children: [
//   //                                     Text('26345634'),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Text('-'),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Text('21741273'),
//   //                                   ],
//   //                                 ),
//   //                                 Text('155 Kg'),
//   //                               ],
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       )
//   //                     : Column(
//   //                         children: [
//   //                           Padding(
//   //                             padding:
//   //                                   EdgeInsets.only(left: 10, right: 10),
//   //                             child: Row(
//   //                               mainAxisAlignment:
//   //                                   MainAxisAlignment.spaceBetween,
//   //                               children: [
//   //                                 Row(
//   //                                   mainAxisAlignment:
//   //                                       MainAxisAlignment.spaceBetween,
//   //                                   children: [
//   //                                     Text('26345634'),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Container(
//   //                                         height: 20,
//   //                                         width: 20,
//   //                                         decoration: BoxDecoration(
//   //                                             borderRadius:
//   //                                                 BorderRadius.circular(5),
//   //                                             border: Border.all(
//   //                                                 color:
//   //                                                     hexToColor('#DBECFB'))),
//   //                                         child: Center(child: Text('-'))),
//   //                                     SizedBox(
//   //                                       width: 10,
//   //                                     ),
//   //                                     Text('21741273'),
//   //                                   ],
//   //                                 ),
//   //                                 Text('155 Kg'),
//   //                               ],
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                 Padding(
//   //                   padding:   EdgeInsets.only(left: 10),
//   //                   child: Row(
//   //                     children: [
//   //                       Container(
//   //                           height: 1, width: 50, color: hexToColor('#DBECFB')),
//   //                       SizedBox(
//   //                         width: 50,
//   //                       ),
//   //                       Container(
//   //                           height: 1, width: 60, color: hexToColor('#DBECFB')),
//   //                       SizedBox(
//   //                         width: 120,
//   //                       ),
//   //                       Container(
//   //                           height: 1, width: 50, color: hexToColor('#DBECFB'))
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 Divider(color: hexToColor('#DBECFB')),
//   //                 Padding(
//   //                   padding:   EdgeInsets.only(left: 10, right: 10),
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                     children: [
//   //                       Text('Quantity'),
//   //                       Text('450 PCs'),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
