import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workforce/src/components/k_appbar.dart';

import '../../config/base.dart';

class RingingPage extends StatefulWidget {
  const RingingPage({super.key});

  @override
  State<RingingPage> createState() => _RingingPageState();
}

class _RingingPageState extends State<RingingPage> with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          TextField(
            onChanged: socketS.userName,
          ),
          SizedBox(
            height: 40,
          ),
          TextField(onChanged: socketS.room),
          SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () {
              socketS.initializeSocket();
              // if (socketS.userName.value != null &&
              //     socketS.room.value != null) {
              //   socketS.initializeSocket();
              // }
            },
            child: Text('call'),
          ),
        ]),
      ),
    );
  }
}
