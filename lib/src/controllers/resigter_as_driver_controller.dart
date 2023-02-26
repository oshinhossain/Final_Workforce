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
