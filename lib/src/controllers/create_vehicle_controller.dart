import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateVehicleController extends GetxController {
//   final vehicleItems = RxList<String>([
//     'Truck',
//     'Pickup',
//     'Car',
//     'Others',
//   ]);
//   final selectedVehicleItem = RxString('Truck');
// //....................................................

//   final brandItems = RxList<String>([
//     'Toyota',
//     'BMW',
//     'Tata',
//     'Others',
//   ]);
//   final selectedBrandItem = RxString('Toyota');
//   //.....................................................

//   final modelItems = RxList<String>([
//     'Tundra',
//     'Hyundai.',
//     'Tata Motors',
//     'Others',
//   ]);
//   final selectedModelItem = RxString('Tata Motors');
//   //...........................................................

//   final yearRegItem = RxList<String>([
//     '2017',
//     '2018',
//     '2019',
//     '2020',
//     '2021',
//     '2022',
//   ]);
//   final selectedyearRegItem = RxString('2022');
  //.......................................................
  //..........................................
  // Capacity Checkbox
  //..........................................

  final isChecked = RxBool(false);
  final isWeightChecked = RxBool(false);
  final isVolumeChecked = RxBool(false);
  final isSeatChecked = RxBool(false);

  //.............................................

  //..........................................
  // Capacity Radio button
  //..........................................
  final capacity = RxString('male');
  //......................................

  final isStar = RxBool(false);
  // --------------------------------------------

  // Zillur Rahman
  final ImagePicker _picker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final pickedImageMemory = Rx<Uint8List?>(null);

  // Select Vechile Image
  Future<void> vehicleImage({required ImageSource imageSource}) async {
    pickedImage.value = null;
    pickedImageMemory.value = null;

    final image = await _picker.pickImage(source: imageSource);

    if (image!.path.isNotEmpty) {
      pickedImage.value = image;
      pickedImageMemory.value = await image.readAsBytes();
    }
  }

  //.................................................

}
