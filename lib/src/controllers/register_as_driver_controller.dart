import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterAsDriverController extends GetxController {
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

  final ImagePicker _picker = ImagePicker();
  final pickedImage = Rx<XFile?>(null);
  final pickedImageMemory = Rx<Uint8List?>(null);

  get pickedImageFont => null;

  // Select License Font Image
  Future<void> licenseFontImage({required ImageSource imageSource}) async {
    pickedImage.value = null;
    pickedImageMemory.value = null;

    final image = await _picker.pickImage(source: imageSource);

    if (image!.path.isNotEmpty) {
      pickedImage.value = image;
      pickedImageMemory.value = await image.readAsBytes();
    }
  }

  //.................................................

  final ImagePicker _pickerBack = ImagePicker();
  final pickedImageBack = Rx<XFile?>(null);
  final pickedImageMemoryBack = Rx<Uint8List?>(null);

// Select License Back Image
  Future<void> licenseBackImage({required ImageSource imageSource}) async {
    pickedImageBack.value = null;
    pickedImageMemoryBack.value = null;

    final image = await _pickerBack.pickImage(source: imageSource);

    if (image!.path.isNotEmpty) {
      pickedImageBack.value = image;
      pickedImageMemoryBack.value = await image.readAsBytes();
    }
  }

  //.................................................

}
