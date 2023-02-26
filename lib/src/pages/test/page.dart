import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'dart:ui';
import 'package:webrtc_interface/webrtc_interface.dart';

import 'dart:math';
import '../../config/base.dart';
import '../../models/activity_name_model.dart';

class ImageController extends GetxController {
  final ImagePicker imagePicker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final imagefiles = RxList<File>([]);
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imagePicker.pickImage(source: ImageSource.camera);

      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        pickedImage.value = File(pickedfile.path);
        imagefiles.add(pickedImage.value!);
      }
    } catch (e) {
      print('error while picking file.');
    }
  }
}
// final modelCalss1 = RxList<AssociatedDrug>();
// final modelCalss = RxList<Problems>();

//final _dio = Dio();

// void getData() async {
//   try {
//     final response = await _dio.get(
//       'https://run.mocky.io/v3/5c648026-c95a-4cf8-9a14-79f13cfb29d3',
//     );

//     // final data = response.data['problems'][0]['Diabetes'][0]['medications'][0]
//     //         ['medicationsClasses'][0]['className'][0]['associatedDrug']
//     final data = response.data['problems']
//         .map((json) => Problems.fromJson(json as Map<String, dynamic>))
//         .toList()
//         .cast<Problems>() as List<Problems>;
//     if (data.isNotEmpty) {
//       modelCalss.clear();
//       modelCalss.addAll(data);
//       kLog(response.data['problems'][0]['Diabetes'][0]['medications'][0]
//           ['medicationsClasses'][0]['className'][0]['associatedDrug'][0]);
//     }
//   } on DioError catch (e) {
//     print(e.message);
//   }
// }

//}

class TestPage1 extends StatelessWidget with Base {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    //imageController.getData();
    socketS.initializeSocket();
    return Scaffold(
      appBar: KAppbar(),
      body: OrientationBuilder(builder: (context, orientation) {
        return Stack(children: <Widget>[
          Positioned(
              left: 0.0,
              right: 0.0,
              top: 0.0,
              bottom: 0.0,
              child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: RTCVideoView(_remoteRenderer),
                decoration: BoxDecoration(color: Colors.black54),
              )),
          Positioned(
            left: 20.0,
            top: 20.0,
            child: Container(
              width: orientation == Orientation.portrait ? 90.0 : 120.0,
              height: orientation == Orientation.portrait ? 120.0 : 90.0,
              child: RTCVideoView(_localRenderer, mirror: true),
              decoration: BoxDecoration(color: Colors.black54),
            ),
          ),
        ]);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: 240.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FloatingActionButton(
                  child: const Icon(Icons.switch_camera),
                  tooltip: 'Camera',
                  onPressed: () {},
                ),
                // FloatingActionButton(
                //   child: const Icon(Icons.desktop_mac),
                //   tooltip: 'Screen Sharing',
                //   onPressed: () {},
                // ),
                FloatingActionButton(
                  onPressed: () {},
                  tooltip: 'Hangup',
                  child: Icon(Icons.call_end),
                  backgroundColor: Colors.pink,
                ),
                FloatingActionButton(
                  child: const Icon(Icons.mic_off),
                  tooltip: 'Mute Mic',
                  onPressed: () {
                    socketS.initializeSocket();
                  },
                )
              ])),
    );

    //   Center(
    //     child: ElevatedButton(
    //       child: const Text('Show SnackBar'),
    //       onPressed: () {
    //         final snackBar = SnackBar(
    //           content: const Text('Yay! A SnackBar!'),
    //           action: SnackBarAction(
    //             label: 'Undo',
    //             onPressed: () {},
    //           ),
    //         );
    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //       },
    //     ),
    //   ),
    // );
  }
}

class RTCVideoView extends StatelessWidget {
  RTCVideoView(
    this._renderer, {
    Key? key,
    this.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
    this.mirror = false,
    this.filterQuality = FilterQuality.low,
    this.placeholderBuilder,
  }) : super(key: key);

  final RTCVideoRenderer _renderer;
  final RTCVideoViewObjectFit objectFit;
  final bool mirror;
  final FilterQuality filterQuality;
  final WidgetBuilder? placeholderBuilder;

  RTCVideoRenderer get videoRenderer => _renderer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            _buildVideoView(context, constraints));
  }

  Widget _buildVideoView(BuildContext context, BoxConstraints constraints) {
    return Center(
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: FittedBox(
          clipBehavior: Clip.hardEdge,
          fit: objectFit == RTCVideoViewObjectFit.RTCVideoViewObjectFitContain
              ? BoxFit.contain
              : BoxFit.cover,
          child: Center(
            child: ValueListenableBuilder<RTCVideoValue>(
              valueListenable: videoRenderer,
              builder:
                  (BuildContext context, RTCVideoValue value, Widget? child) {
                return SizedBox(
                  width: constraints.maxHeight * value.aspectRatio,
                  height: constraints.maxHeight,
                  child: child,
                );
              },
              child: Transform(
                transform: Matrix4.identity()..rotateY(mirror ? -pi : 0.0),
                alignment: FractionalOffset.center,
                child: videoRenderer.renderVideo
                    ? Texture(
                        textureId: videoRenderer.textureId!,
                        filterQuality: filterQuality,
                      )
                    : placeholderBuilder?.call(context) ?? Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  final imageController = Get.put(ImageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: Obx(
        () => SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      imageController.pickMultiImage();
                    },
                    icon: Icon(Icons.add_a_photo),
                    iconSize: 40,
                  ),
                  Text(
                    'Attachments',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            imageController.imagefiles.isEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                    ),
                    itemCount: 1,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // height: 130,
                        width: double.infinity,
                        color: Colors.amber,
                        child: Center(
                          child: IconButton(
                            onPressed: () => imageController.pickMultiImage(),
                            icon: Icon(
                              Icons.add,
                              color: Colors.grey,
                              size: 15,
                            ),
                          ),
                        ),

                        //background color of inner container
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: imageController.imagefiles.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final item = imageController.imagefiles[index];
                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                File(item.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                //if you want to remove image
                                imageController.imagefiles.removeAt(index);
                              },
                              child: Container(
                                margin: EdgeInsets.all(60),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ],
        )),
      ),
    );
  }
}

Widget Test() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.amber,
            height: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text('Testing'),
            ),
          ),
        );
      },
    ),
  );
}

Widget Test1() {
  return SizedBox(
    height: 100,
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.amber,
            height: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text('Testing'),
            ),
          ),
        );
      },
    ),
  );
}

Widget firstRow() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 20,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 30, left: 15),
              child: Card(
                color: Color.fromRGBO(225, 227, 229, 100),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            '1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                elevation: 3,
              ),
            );
          },
        ),
      ],
    ),
  );
}

getColor(double value) {
  if (value < 50) {
    //kLog('100');
    return Colors.red;
  } else if (value < 75) {
    //// kLog(value);
    //// kLog('200');
    return Colors.amber;
  } else {
    //// kLog(value);
    //// kLog('300');
    return Colors.greenAccent;
  }
}


//---------//
  // Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 15),
  //               child: Row(
  //                 children: [
  //                   SizedBox(
  //                     width: 5,
  //                   ),
  //                   IconButton(
  //                     onPressed: () {
  //                       imageController.pickMultiImage();
  //                     },
  //                     icon: Icon(Icons.add_a_photo),
  //                     iconSize: 40,
  //                   ),
  //                   Text(
  //                     'Attachments',
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             imageController.imagefiles.isEmpty
  //                 ? GridView.builder(
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 2,
  //                       crossAxisSpacing: 15,
  //                     ),
  //                     itemCount: 1,
  //                     primary: false,
  //                     shrinkWrap: true,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return Container(
  //                         // height: 130,
  //                         width: double.infinity,
  //                         color: Colors.amber,
  //                         child: Center(
  //                           child: IconButton(
  //                             onPressed: () => imageController.pickMultiImage(),
  //                             icon: Icon(
  //                               Icons.add,
  //                               color: Colors.grey,
  //                               size: 15,
  //                             ),
  //                           ),
  //                         ),

  //                         //background color of inner container
  //                       );
  //                     },
  //                   )
  //                 : GridView.builder(
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 2,
  //                     ),
  //                     itemCount: imageController.imagefiles.length,
  //                     primary: false,
  //                     shrinkWrap: true,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       final item = imageController.imagefiles[index];
  //                       return Stack(
  //                         children: [
  //                           Container(
  //                             width: double.infinity,
  //                             margin: EdgeInsets.all(5),
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(5),
  //                             ),
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(5),
  //                               child: Image.file(
  //                                 File(item.path),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                           ),
  //                           Positioned(
  //                             top: 0,
  //                             right: 0,
  //                             left: 0,
  //                             bottom: 0,
  //                             child: InkWell(
  //                               onTap: () {
  //                                 //if you want to remove image
  //                                 imageController.imagefiles.removeAt(index);
  //                               },
  //                               child: Container(
  //                                 margin: EdgeInsets.all(60),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(50),
  //                                   color: Colors.white.withOpacity(0.5),
  //                                 ),
  //                                 child: Icon(
  //                                   Icons.delete,
  //                                   color: Colors.redAccent,
  //                                   size: 30,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   ),
           
           