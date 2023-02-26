import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RequestSiteLocationsController extends GetxController {
  final kMapControllerSiteLocation = MapController();
  final isPlotingEnable = RxBool(true);
  final isDrag = RxBool(false);

  final isPop = RxBool(false);
  final isWifi = RxBool(false);
  final isnewPole = RxBool(false);
  final isEPole = RxBool(false);
  final islightPost = RxBool(false);
  final isTelPole = RxBool(false);
  final isBts = RxBool(false);
  final isBuilding = RxBool(false);
  final isOther = RxBool(false);
  final isFootPrint = RxBool(false);

  final addDriver = RxBool(false);

  //Evidence Tab
  final ImagePicker imgpicker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final imagefiles = RxList<XFile>([]);

  // Evidence Image picker
  Future<void> pickMultiImage() async {
    try {
      var pickedfile = await imgpicker.pickImage(source: ImageSource.camera);
      //you can use ImageCourse.camera for Camera capture
      if (pickedfile != null) {
        // imagefiles.value = pickedfile;
        pickedImage.value = pickedfile;
        imagefiles.add(pickedfile);
        // back();
      } else {
        print('No image is selected.');
      }
    } catch (e) {
      print('error while picking file.');
    }
  }
  //-------------------------------------

  void getCurrentLocation() async {
    try {
      // final location = await getLocation();
      // print('Location: ${location.latitude}, ${location.longitude}');
      // kMapController.move(
      //     LatLng(
      //       location.latitude!,
      //       location.longitude!,
      //     ),
      //     10);
    } catch (e) {
      print(e);
    }
  }

  //////////////////////////////
  // It is mandatory initialize with one value from listType
  final selected = 'some book type'.obs;

  void setSelected(String value) {
    selected.value = value;
  }
}
