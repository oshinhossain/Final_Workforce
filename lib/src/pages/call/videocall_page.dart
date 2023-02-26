import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:workforce/main.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/call/CameraView.dart';
import 'package:workforce/src/pages/call/VideoView.dart';

import '../../helpers/hex_color.dart';
import '../../helpers/k_text.dart';

// late List<CameraDescription> cameras;

class VideoCallPage extends StatefulWidget {
  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.
  late CameraController _cameraController;
  Future<void>? cameraValue;
  bool isRecoring = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() async {
    super.dispose();
    _cameraController.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!_cameraController.value.isInitialized) {
    //   return Container();
    // }
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         flash ? Icons.flash_on : Icons.flash_off,
      //         color: Colors.white,
      //         size: 25,
      //       ),
      //       highlightColor: Colors.grey.withOpacity(.5),
      //       onPressed: () {
      //         setState(() {
      //           flash = !flash;
      //         });
      //         flash
      //             ? _cameraController.setFlashMode(FlashMode.torch)
      //             : _cameraController.setFlashMode(FlashMode.off);
      //       },
      //     ),
      //     SizedBox(width: 10)
      //   ],
      // ),
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_cameraController),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          ),
          Positioned(
              top: 50.0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        back();
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: 15,
                  ),
                  KText(
                    text: 'Nahid',
                    color: Colors.white,
                    fontSize: 16,
                    bold: true,
                  )
                ],
              )),
          // if (isRecoring)
          // Positioned(
          //   top: 80.0,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(50),
          //             border: Border.all(
          //               width: 2,
          //               color: Colors.white,
          //             )),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Icon(
          //               Icons.circle,
          //               size: 14,
          //               color: Colors.red,
          //             ),
          //             SizedBox(width: 8),
          //             KText(
          //               text: '0.0',
          //               color: Colors.white,
          //             ),
          //           ],
          //         ),
          //       ),

          //     ],
          //   ),
          // ),

          Positioned(
            top: 140.0,
            right: 10,
            child: Container(
              height: 220,
              width: 180,
              decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CameraPreview(_cameraController),
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.video_call, color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.mic, color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.image_sharp, color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          iscamerafront = !iscamerafront;
                          transform = transform + pi;
                        });
                        int cameraPos = iscamerafront ? 0 : 1;
                        _cameraController = CameraController(
                          cameras[cameraPos],
                          ResolutionPreset.high,
                        );
                        cameraValue = _cameraController.initialize();
                      },
                      child: Icon(Icons.flip_camera_ios_rounded,
                          color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.call, color: Colors.white),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.redAccent),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        shape: MaterialStateProperty.all(CircleBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 0.0,
          //   child: Container(
          //     // color: Colors.black,
          //     padding: EdgeInsets.only(top: 5, bottom: 5),
          //     width: MediaQuery.of(context).size.width,
          //     child: Column(
          //       children: [
          //         Row(
          //           mainAxisSize: MainAxisSize.max,
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             IconButton(
          //                 icon: Icon(
          //                   Icons.image,
          //                   color: Colors.white,
          //                   size: 25,
          //                 ),
          //                 highlightColor: Colors.grey.withOpacity(.5),
          //                 onPressed: () {
          //                   setState(() {
          //                     flash = !flash;
          //                   });
          //                   flash
          //                       ? _cameraController
          //                           .setFlashMode(FlashMode.torch)
          //                       : _cameraController.setFlashMode(FlashMode.off);
          //                 }),
          //             GestureDetector(
          //               onLongPress: () async {
          //                 await _cameraController.startVideoRecording();
          //                 setState(() {
          //                   isRecoring = true;
          //                 });
          //               },
          //               onLongPressUp: () async {
          //                 XFile videopath =
          //                     await _cameraController.stopVideoRecording();
          //                 setState(() {
          //                   isRecoring = false;
          //                 });
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (builder) => VideoViewPage(
          //                       path: videopath.path,
          //                     ),
          //                   ),
          //                 );
          //               },
          //               onTap: () {
          //                 if (!isRecoring) takePhoto(context);
          //               },
          //               child: isRecoring
          //                   ? Icon(
          //                       Icons.radio_button_on,
          //                       color: Colors.red,
          //                       size: 80,
          //                     )
          //                   : Icon(
          //                       Icons.panorama_fish_eye,
          //                       color: Colors.white,
          //                       size: 70,
          //                     ),
          //             ),
          //             IconButton(
          //               icon: Transform.rotate(
          //                 angle: transform,
          //                 child: Icon(
          //                   Icons.flip_camera_ios,
          //                   color: Colors.white,
          //                   size: 25,
          //                 ),
          //               ),
          //               highlightColor: Colors.blueAccent,
          //               onPressed: () async {
          //                 setState(() {
          //                   iscamerafront = !iscamerafront;
          //                   transform = transform + pi;
          //                 });
          //                 int cameraPos = iscamerafront ? 0 : 1;
          //                 _cameraController = CameraController(
          //                   cameras[cameraPos],
          //                   ResolutionPreset.high,
          //                 );
          //                 cameraValue = _cameraController.initialize();
          //               },
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 4,
          //         ),
          //         KText(
          //           text: 'Hold for Video, tap for photo',
          //           color: Colors.white,
          //           fontSize: 12,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => CameraViewPage(
          path: file.path,
        ),
      ),
    );
  }
}
