import 'dart:typed_data';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';

class UiController extends GetxController {
  // For nahid
  final isExpanded = RxBool(false);

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

//..................................................................

}
