// ignore_for_file: prefer_single_quotes
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import '../helpers/log.dart';
import '../services/api_service.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/image_compress.dart';

import 'package:workforce/src/models/agency_driver_get_model.dart';
import 'package:workforce/src/models/agency_vehicle_get_model.dart';
import 'package:workforce/src/models/select_driver_model.dart';
import 'package:workforce/src/models/select_vehicle_type_model.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/models/vehicle_get_model.dart';
import 'package:workforce/src/pages/main_page.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/get_file_name.dart';
import '../helpers/hex_color.dart';
import '../helpers/route.dart';
import '../pages/add_driver_agency_page.dart';
import '../pages/add_vehicle_to_agency_page.dart';
import 'package:image_cropper/image_cropper.dart';

enum AgencyVehicle { truck, pickup }

class VehicleAndDriverController extends GetxController with ApiService {
  final isLoading = RxBool(false);
  final selectVehicleType = RxList<SelectVehicleType?>();
  final selectedVehicleType = Rx<SelectVehicleType?>(null);
  final vehicleGet = RxList<VehicleGet?>();
  final slectDriverModel = RxList<SelectDriverModel?>();
  final agencyDriverModel = RxList<AgencyDriverModel?>();
  final agencyVehicleGetModel = RxList<AgencyVehicleGetModel?>();

  final agencyVehicleGetModelname = RxList<String?>();

  final brandItems = RxList<String>([
    'Toyota',
    'BMW',
    'Tata',
    'Others',
  ]);
  final selectedBrandItem = RxString('Toyota');
  //.....................................................
  final modelItems = RxList<String>([
    'Tundra',
    'Hyundai.',
    'Tata Motors',
    'Others',
  ]);
  final selectedModelItem = RxString('Tata Motors');
  //...........................................................
  final fileImage = Rx<File?>(null);
  final fileImageLicensFront = Rx<File?>(null);
  final fileImageLicensBack = Rx<File?>(null);
  //..........................................
  // Capacity Checkbox
  //..........................................

  // final isChecked = RxBool(false);
  // final isWeightChecked = RxBool(false);
  // final isVolumeChecked = RxBool(false);
  //.............................................

  final userImage = Rx<Uint8List?>(null);
  final isStar = RxBool(false);
  // --------------------------------------------
  final ImagePicker _picker = ImagePicker();
  final pickedImage = Rx<File?>(null);
  final pickedImageMemory = Rx<Uint8List?>(null);

  // Select Vechile Image
  Future<void> vehicleImage({required ImageSource imageSource, context}) async {
    pickedImage.value = null;
    pickedImageMemory.value = null;

    final image = await _picker.pickImage(source: imageSource);

    if (image!.path.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: AppTheme.appFooterColor,
              toolbarWidgetColor: hexToColor("#ffffff"),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: '',
          ),
        ],
      );
      if (croppedFile != null) {
        fileImage.value = File(croppedFile.path);
      }

      pickedImage.value = File(croppedFile!.path);
      // File image
      fileImage.value = File(croppedFile.path);

      // Image compress function
      final img = await compressFile(
        file: fileImage.value,
      );

      // Load compress image
      fileImage.value = img;
      pickedImageMemory.value = await pickedImage.value!.readAsBytes();
    }
  }

  //..........................................
  // Register As a Driver Page
  //..........................................

  final ImagePicker _pickerFont = ImagePicker();
  final pickedImageFont = Rx<File?>(null);
  final pickedImageMemoryFont = Rx<Uint8List?>(null);

  // // Select License Font Image
  // Future<void> licenseFontImage({required ImageSource imageSource}) async {
  //   pickedImageFont.value = null;
  //   pickedImageMemoryFont.value = null;

  //   final image = await _pickerFont.pickImage(source: imageSource);

  //   // if (image!.path.isNotEmpty) {
  //   //   pickedImageFont.value = image;
  //   //   pickedImageMemoryFont.value = await image.readAsBytes();
  //   // }

  //   if (image!.path.isNotEmpty) {
  //     pickedImageFont.value = image;
  //     // File image
  //     fileImageLicensFront.value = File(image.path);

  //     // Image compress function
  //     final img = await compressFile(
  //       file: fileImageLicensFront.value,
  //     );

  //     // Load compress image
  //     fileImageLicensFront.value = img;
  //     pickedImageMemoryFont.value = await image.readAsBytes();
  //   }
  // }

  // Select License Font Image
  Future<void> licenseFontImage({required ImageSource imageSource}) async {
    pickedImageFont.value = null;
    pickedImageMemoryFont.value = null;

    final image = await _pickerFont.pickImage(source: imageSource);

    // if (image!.path.isNotEmpty) {
    //   pickedImageFont.value = image;
    //   pickedImageMemoryFont.value = await image.readAsBytes();
    // }

    if (image!.path.isNotEmpty) {
      final croppedFileFrontImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: '',
              toolbarColor: AppTheme.appFooterColor,
              toolbarWidgetColor: hexToColor("#ffffff"),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: '',
          ),
        ],
      );

      if (croppedFileFrontImage != null) {
        fileImage.value = File(croppedFileFrontImage.path);
      }

      pickedImageFont.value = File(croppedFileFrontImage!.path);
      // File image
      fileImageLicensFront.value = File(image.path);

      // Image compress function
      final img = await compressFile(
        file: fileImageLicensFront.value,
      );

      // Load compress image
      fileImageLicensFront.value = img;
      pickedImageMemoryFont.value = await pickedImageFont.value!.readAsBytes();
    }
  }

  //.................................................

  final ImagePicker _pickerBack = ImagePicker();
  final pickedImageBack = Rx<File?>(null);
  final pickedImageMemoryBack = Rx<Uint8List?>(null);

// Select License Back Image
  Future<void> licenseBackImage({required ImageSource imageSource}) async {
    pickedImageBack.value = null;
    pickedImageMemoryBack.value = null;

    final image = await _pickerBack.pickImage(source: imageSource);

    // if (image!.path.isNotEmpty) {
    //   pickedImageBack.value = image;
    //   pickedImageMemoryBack.value = await image.readAsBytes();
    // }

    final croppedFileBackImage = await ImageCropper().cropImage(
      sourcePath: image!.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: AppTheme.appFooterColor,
            toolbarWidgetColor: hexToColor("#ffffff"),
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: '',
        ),
      ],
    );

    if (croppedFileBackImage != null) {
      fileImage.value = File(croppedFileBackImage.path);
    }

    pickedImageBack.value = File(croppedFileBackImage!.path);
    // File image
    fileImageLicensBack.value = File(croppedFileBackImage.path);

    // Image compress function
    final img = await compressFile(
      file: fileImageLicensBack.value,
    );

    // Load compress image
    fileImageLicensBack.value = img;
    pickedImageMemoryBack.value = await pickedImageBack.value!.readAsBytes();

    // if (image.path.isNotEmpty) {
    //   pickedImageBack.value = image;
    //   // File image
    //   fileImageLicensBack.value = File(image.path);

    //   // Image compress function
    //   final img = await compressFile(
    //     file: fileImageLicensBack.value,
    //   );
    //   // Load compress image
    //   fileImageLicensBack.value = img;
    //   pickedImageMemoryBack.value = await image.readAsBytes();
    // }
  }

  //.................................................

  final weightCapacity = RxString('');
  final weightCapacityUnit = RxString('');
  final weightCapacityApplicable = RxBool(false);
  final volumeCapacity = RxString('');
  final volumeCapacityUnit = RxString('');
  final volumeCapacityApplicable = RxBool(false);
  final seatCapacity = RxString('');
  final seatCapacityUnit = RxString('');
  final seatCapacityApplicable = RxBool(false);
  final brand = RxString('');
  final model = RxString('');
  final registrationNo = RxString('');
  final registrationDate = RxString('');
  final termsAndCondition = RxBool(false);

  createVehicle() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      final body = {
        'masterViewModel': {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'username': username,
          'agencyIds': [selectedAgency!.agencyId]
        },
        'vehicleTypeId': selectedVehicleType.value!.id,
        'weightCapacity': weightCapacity.value,
        'weightCapacityUnit': weightCapacityUnit.value,
        'weightCapacityApplicable': weightCapacityApplicable.value,
        'volumeCapacity': volumeCapacity.value,
        'volumeCapacityUnit': volumeCapacityUnit.value,
        'volumeCapacityApplicable': volumeCapacityApplicable.value,
        'seatCapacity': seatCapacity.value,
        'seatCapacityUnit': seatCapacityUnit.value,
        'seatCapacityApplicable': seatCapacityApplicable.value,
        'brand': selectedBrandItem.value,
        'model': selectedModelItem.value,
        'registrationNo': registrationNo.value,
        'registrationDate': registrationDate.value,
      };

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/vehicle/add',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 5.delay();
        offAll(MainPage());

        // push(AddVehicleToAgencyPage());

        //vehicleGet.clear();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
        await 6.delay();
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  bool createVehicleSubmitButtonValid() {
    if (selectedBrandItem.value.isNotEmpty &&
        selectedModelItem.value.isNotEmpty &&
        selectedVehicleType.value!.id != null &&
        registrationDate.value.isNotEmpty &&
        registrationNo.value.isNotEmpty &&
        termsAndCondition.value == true) {
      return true;
    } else {
      return false;
    }
  }

  //..........................................
  // Create Vehicle Type
  //..........................................

  getSelectVehicleType() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;

      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/vehicle/type/get',
        queryParameters: params,
      );
      // print(res.data);

      //// kLog('${res.data}');

      final dashbordSelectVehicle = res.data['data']
          .map((json) =>
              SelectVehicleType.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<SelectVehicleType>() as List<SelectVehicleType>;

      if (dashbordSelectVehicle.isNotEmpty) {
        selectVehicleType.clear();
        selectVehicleType.addAll(dashbordSelectVehicle);
        selectedVehicleType.value = dashbordSelectVehicle[0];
      }
    } on DioError catch (e) {
      print(e.message);
    }
  }

//..........................................
  //  Vehicle Search Get
  //..........................................

  final vehicleType = RxString('');

  ///...............................
  void getSelectVehicle() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;

      final params = {
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
        'vehicleType': vehicleType.value,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/vehicle/search',
        queryParameters: params,
      );

      //// kLog('${res.data}');
      vehicleType.value = '';

      final getVehicles = res.data['data']
          .map((json) {
            final item = VehicleGet.fromJson(json as Map<String, dynamic>);
            item.isChecked = false;
            item.selectedId = '';
            return item;
          })
          .toList()
          .cast<VehicleGet>() as List<VehicleGet>;

      if (getVehicles.isNotEmpty) {
        vehicleGet.clear();
        vehicleGet.addAll(getVehicles);
        isLoading.value = false;
        // selectedVehicleType.value = selectVehicle[0];
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void updateVehicleItem({
    required bool value,
    required String id,
  }) {
    // kLog(value);
    final item = vehicleGet.singleWhere((x) => x!.id == id);

    item!.isChecked = value;
    item.selectedId = id;

    vehicleGet[vehicleGet.indexOf(item)] = item;
  }

  //..........................................
  // ****  Creat Driver ****
  //..........................................

  final licenseType = RxList<String>([
    'Nonprofessional',
    'Professional',
  ]);
  final selectedlicenseType = RxString('Professional');

  final isDriver = RxBool(true);
  final medium = RxBool(false);
  final heavy = RxBool(false);
  final light = RxBool(false);
  final motorcycle = RxBool(false);
  final three = RxBool(false);
  final psv = RxBool(false);
  final other = RxBool(false);
  final termsAndConditionsDriver = RxBool(false);
  final authorityAgencyId = RxString('');
  final authorityAgencyCode = RxString('');
  final authorityAgencyName = RxString('');
  final licenseNo = RxString('');
  final issuanceDate = RxString('');
  final expirtyDate = RxString('');
  final licenseAuthority = RxString('');
  // final vehicleClasses = RxList<String?>([]);
  // final vehicleClasses = RxList<RegisterAsDriverModel>([]);

  /// To get Selected Vehicle Clases
  List<String> getSelectedVehicleClassList() {
    final list = [''];
    if (medium.isTrue) {
      list.add('Medium');
    }
    if (heavy.isTrue) {
      list.add('Heavy');
    }
    if (light.isTrue) {
      list.add('Light');
    }
    if (motorcycle.isTrue) {
      list.add('Motorcycle');
    }
    if (three.isTrue) {
      list.add('Three Wheelers');
    }
    if (psv.isTrue) {
      list.add('PSV');
    }
    if (other.isTrue) {
      list.add('Others');
    }

    return list;
  }

  void createDriver() async {
    final vehicleClassList = getSelectedVehicleClassList();

    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;

      final body = {
        'masterViewModel': {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'WFC',
          'username': username,
          'agencyIds': [selectedAgency!.agencyId]
        },
        'authorityAgencyId': '',
        'authorityAgencyCode': '',
        'authorityAgencyName': '',
        'licenseNo': licenseNo.value,
        'issuanceDate': issuanceDate.value,
        'expirtyDate': expirtyDate.value,
        'licenseAuthority': licenseAuthority.value,
        'licenseType': selectedlicenseType.value,
        //'vehicleClasses': ['Heavy', 'Medium']
        'vehicleClasses': vehicleClassList,
      };
      //// kLog(body);
      // return;
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/driver/add',
        body: body,
      );

      var responseCode = res.data['responseCode'];

      if (responseCode == '200') {
        licenseNo.value = '';
        selectedlicenseType.value = 'Professional';
        issuanceDate.value = '';
        expirtyDate.value = '';
        licenseAuthority.value = '';
        pickedImageFont.value = null;
        pickedImageMemoryFont.value = null;
        pickedImageBack.value = null;
        pickedImageMemoryBack.value = null;
        heavy.value = false;
        light.value = false;
        motorcycle.value = false;
        three.value = false;
        psv.value = false;
        medium.value = false;
        other.value = false;
        termsAndConditionsDriver.value = false;
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            offAll(MainPage());
          },
        );
        await 5.delay();
        offAll(MainPage());

        // push(AddVehicleToAgencyPage());
        // getSelectedVehicleClassList().clear();
        //vehicleGet.clear();
      } else {
        licenseNo.value = '';
        selectedlicenseType.value = 'Professional';
        issuanceDate.value = '';
        expirtyDate.value = '';
        licenseAuthority.value = '';
        pickedImageFont.value = null;
        pickedImageMemoryFont.value = null;
        pickedImageBack.value = null;
        pickedImageMemoryBack.value = null;
        isLoading.value = false;
        heavy.value = false;
        light.value = false;
        motorcycle.value = false;
        three.value = false;
        psv.value = false;
        medium.value = false;
        other.value = false;
        termsAndConditionsDriver.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
            // getSelectedVehicleClassList().clear();
          },
        );
        await 6.delay();
        //getSelectedVehicleClassList().clear();
      }

      // else if (responseCode == '412') {
      //   isLoading.value = false;
      //   DialogHelper.successDialog(
      //     title: 'Unsuccessful!',
      //     msg: res.data['message'][0].toString(),
      //     color: hexToColor('#FF3C3C'),
      //     path: 'cancel_circle',
      //     onPressed: () {
      //       back();
      //     },
      //   );
      //   await 6.delay();
      //   back();
      // }

      // else {
      //   isLoading.value = false;
      //   DialogHelper.successDialog(
      //     title: 'Unsuccessful!',
      //     msg: res.data['message'][0].toString(),
      //     color: hexToColor('#FF3C3C'),
      //     path: 'cancel_circle',
      //     onPressed: () {
      //       back();
      //     },
      //   );
      //   await 6.delay();
      //   back();
      // }

      isLoading.value = false;

      // else if (responseCode == '412') {
      //   Get.snackbar('Aleart', 'Username already exist.',
      //       backgroundColor: Colors.white, colorText: Colors.black);
      // } else {
      //   Get.snackbar('Aleart', 'Something wrong!!.',
      //       backgroundColor: Colors.white, colorText: Colors.black);
      // }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  bool createDriverSubmitButtonValid() {
    if (licenseNo.value.isNotEmpty &&
        issuanceDate.value.isNotEmpty &&
        //selectedVehicleType.value!.id != null &&
        expirtyDate.value.isNotEmpty &&
        licenseAuthority.value.isNotEmpty &&
        termsAndConditionsDriver.value == true) {
      return true;
    } else {
      return false;
    }
  }

//..........................................
  //  Select Driver Get
  //..........................................

  final driverName = RxString('');
  final isSelectedDriver = RxBool(false);

  ///...............................
  void getSelectDriver() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final params = {
        //'agencyId': '89180b6c-9cd0-40db-9b08-1b251aa1f18e',
        'agencyId': selectedAgency!.agencyId,
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        //'username': 'kabir2',
        'username': username,
        'driverName': driverName.value,
      };
      // kLog(driverName.value);

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/driver/search',
        queryParameters: params,
      );

      // kLog('${res.data}');

      final getDrivers = res.data['data']
          .map((json) {
            final item =
                SelectDriverModel.fromJson(json as Map<String, dynamic>);
            item.isChecked = false;
            item.selectedId = '';
            return item;
          })
          .toList()
          .cast<SelectDriverModel>() as List<SelectDriverModel>;

      if (getDrivers.isNotEmpty) {
        isLoading.value = false;
        slectDriverModel.clear();
        slectDriverModel.addAll(getDrivers);
      }

      isLoading.value = false;
      driverName.value = '';
    } on DioError catch (e) {
      print(e.message);
    }
  }

  void updateDriverItem({
    required bool value,
    required String id,
  }) {
    // kLog(value);
    final item = slectDriverModel.singleWhere((x) => x!.id == id);

    item!.isChecked = value;
    item.selectedId = id;

    slectDriverModel[slectDriverModel.indexOf(item)] = item;
  }

  //..........................................
  // Vehicle Agency Add
  //..........................................
  final isselectIsvehicle = RxBool(false);

  void vehicleAgencyAdd() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;

      isLoading.value = true;

      final checkedListData =
          vehicleGet.where((item) => item!.isChecked == true).toList();

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'areaLevel': 4,
        'areaType': 'COUNTRY UNIT',
        'username': username,
        'agencyIds': [selectedAgency!.agencyId],
        // 'username': 'kabir2',
        // 'agencyIds': ['89180b6c-9cd0-40db-9b08-1b251aa1f18e'],
        'ids': checkedListData.map((x) => x!.selectedId).toList(),
        // 'ids': [
        //   'd0120071-09f3-4400-862e-c9c59c607821',
        //   '694c1051-13ee-4b6e-a577-bfc106c7fa56'
        // ]
      };
      // kLog(body);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/vehicle/agency/add',
        body: body,
      );

      //// kLog(res.data['status']);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            push(AddVehicleToAgencyPage());
            vehicleGet.clear();
          },
        );
        await 5.delay();
        vehicleGet.clear();

        push(AddVehicleToAgencyPage());
        checkedListData.clear();
        vehicleGet.clear();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
            vehicleGet.clear();
          },
        );
        await 6.delay();
        vehicleGet.clear();
        back();
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //..................................................................

  //..........................................
  // Driver Agency Add
  //..........................................
  final isselectIsDriver = RxBool(false);
  void driverAgencyAdd() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;

      isLoading.value = true;

      final checkedListData =
          slectDriverModel.where((item) => item!.isChecked == true).toList();

      final body = {
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'areaLevel': 4,
        'areaType': 'COUNTRY UNIT',
        "username": username,
        'agencyIds': [selectedAgency!.agencyId],
        'ids': checkedListData.map((x) => x!.selectedId).toList(),
      };

      //// kLog(body);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/driver/agency/add',
        body: body,
      );

      // kLog(res.data['status']);

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            // offAll(AddDriverToAgencyPage());
            back();
          },
        );
        await 1.delay();
        push(AddDriverToAgencyPage());
        // back();

        slectDriverModel.clear();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            // back();
          },
        );
        await 6.delay();
        back();
      }

      isLoading.value = false;
      slectDriverModel.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }
  //.................................................

  //..........................................
  //  Agency Driver Get
  //..........................................

  void getAgencyDriver() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      isLoading.value = true;
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        //     'agencyId': '89180b6c-9cd0-40db-9b08-1b251aa1f18e',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };

      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/agency-driver/get',
        queryParameters: params,
      );
      // print(res.data);

      // kLog('${res.data}');
      //return;
      driverName.value = '';

      final getAgencyDriver = res.data['data']
          .map((json) =>
              AgencyDriverModel.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<AgencyDriverModel>() as List<AgencyDriverModel>;

      if (getAgencyDriver.isNotEmpty) {
        agencyDriverModel.clear();
        agencyDriverModel.addAll(getAgencyDriver);
        isLoading.value = false;
        // selectedVehicleType.value = selectVehicle[0];
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }
  //..........................................................................................

  //..........................................
  //  Agency Vehicle Get
  //..........................................

  void getAgencyVehicle() async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;
      final params = {
        'agencyId': selectedAgency!.agencyId,
        //     'agencyId': '89180b6c-9cd0-40db-9b08-1b251aa1f18e',
        'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
        'appCode': 'WFC',
        'username': username,
      };
      final res = await getDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/agency-vehicle/get',
        queryParameters: params,
      );

      driverName.value = '';

      final getAgencyVehicle = res.data['data']
          .map((json) =>
              AgencyVehicleGetModel.fromJson(json as Map<String, dynamic>))
          .toList()
          .cast<AgencyVehicleGetModel>() as List<AgencyVehicleGetModel>;

      if (getAgencyVehicle.isNotEmpty) {
        agencyVehicleGetModel.clear();

        agencyVehicleGetModel.addAll(getAgencyVehicle);

        for (var element in agencyVehicleGetModel) {
          if (agencyVehicleGetModelname.contains(element!.vehicleType)) {
          } else {
            agencyVehicleGetModelname.add(element.vehicleType);
          }
        }

        isLoading.value = false;
        // selectedVehicleType.value = selectVehicle[0];
      }

      isLoading.value = false;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  List<AgencyVehicleGetModel?> getAgencyByVehicleType({required String type}) {
    return agencyVehicleGetModel
        .where((item) => item!.vehicleType == type)
        .toList();
  }

  //............................................................
  //..........................................
  // Driver Agency Delete
  //..........................................

  void deleteDriverAgency({required String id}) async {
    try {
      // ignore: unused_local_variable
      final latLng = await locationC.getCurrentLocation();
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;

      final body = {
        "apiKey": "ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5",
        "appCode": "WFC",
        "username": username,
        'agencyIds': [selectedAgency!.agencyId],
        "ids": [id]
      };

      // kLog(body);

      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/driver/agency/delete',
        body: body,
      );

      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        back();
        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            // offAll(AddDriverToAgencyPage());
            back();
          },
        );
        await 1.delay();

        back();

        // slectDriverModel.clear();
      } else {
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
        await 6.delay();
        back();
      }

      isLoading.value = false;
      // slectDriverModel.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }
  //............................................................

  //..........................................
  // Vehicle Agency Delete
  //..........................................

  void deleteVehicleAgency({
    required String id,
    required AgencyVehicleGetModel item,
    required String vehicleType,
  }) async {
    try {
      final selectedAgency = Get.put(AgencyController()).selectedAgency;
      final username = Get.put(UserController()).currentUser.value!.username;
      isLoading.value = true;

      final body = {
        "apiKey": "ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5",
        "appCode": "WFC",
        "username": username,
        'agencyIds': [selectedAgency!.agencyId],
        "ids": [id]
      };

      // kLog(body);
      // kLog('value');
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/vehicle/agency/delete',
        body: body,
      );

      back();
      if (res.data['status'] != null &&
          res.data['status'].contains('successful') == true) {
        isLoading.value = false;
        agencyVehicleGetModel.remove(item);
        if (getAgencyByVehicleType(type: vehicleType).isEmpty) {
          agencyVehicleGetModelname.remove(vehicleType);
        }

        DialogHelper.successDialog(
          title: 'Success!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#00B485'),
          path: 'success-circular',
          onPressed: () {
            back();
          },
        );
        await 1.delay();

        back();

        vehicleGet.clear();
      } else {
        back();
        isLoading.value = false;
        DialogHelper.successDialog(
          title: 'Unsuccessful!',
          msg: res.data['message'][0].toString(),
          color: hexToColor('#FF3C3C'),
          path: 'cancel_circle',
          onPressed: () {
            back();
          },
        );
        await 6.delay();
        back();
      }

      isLoading.value = false;
      vehicleGet.clear();
    } on DioError catch (e) {
      kLog(e.message);
    }
  }
  //.................................................

  //..........................................
  // Create Vehicle Page Dispose
  //..........................................

  createVehicleDisposeData() {
    weightCapacity.value = '';
    weightCapacityUnit.value = '';
    weightCapacityApplicable.value = false;
    volumeCapacity.value = '';
    volumeCapacityUnit.value = '';
    volumeCapacityApplicable.value = false;
    seatCapacity.value = '';
    seatCapacityUnit.value = '';
    seatCapacityApplicable.value = false;
    registrationNo.value = '';
    registrationDate.value = '';
    pickedImage.value = null;
    pickedImageMemory.value = null;
    selectedBrandItem.value = 'Toyota';
    selectedModelItem.value = 'Tundra';
  }
  //.................................................

  //..........................................
  // Create Vehicle Page Dispose
  //..........................................

  registerDriverDisposeData() {
    print('.................................................');
    licenseNo.value = '';
    selectedlicenseType.value = 'Professional';
    issuanceDate.value = '';
    expirtyDate.value = '';
    licenseAuthority.value = '';
    pickedImageFont.value = null;
    pickedImageMemoryFont.value = null;
    pickedImageBack.value = null;
    pickedImageMemoryBack.value = null;

    //list.clear();
  }
  //.................................................

  // User Image Driver
  //..........................................
  // etImageByUserName({required String userName}) async {
  //   try {
  //     // print(username);
  //     final res = await _dio.get<Uint8List>(
  //       '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$userName&appCode=KYC&fileCategory=photo&countryCode=BD',
  //       options: Options(
  //         followRedirects: false,
  //         responseType: ResponseType.bytes,
  //         validateStatus: (status) => true,
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'latLng':   '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',,
  //         },
  //       ),
  //     );
  //     print(res.data);

  //     final userBox = Hive.box<UserImage>('user_image');

  //     await userBox.put('current_user_image', UserImage(image: res.data));
  //     userImage.value = res.data;
  //   } on DioError catch (e) {
  //     print(e.message);
  //   }
  // }

//..........................................
  // Create Vehicle Page Pick Vehicle Image
//..........................................

  vehicleImageUplod() async {
    final username = Get.put(UserController()).currentUser.value!.username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      //// kLog(fileImage.value!.path);
      //// kLog(registrationNo.value);
      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'ITS',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_CATEGORY_VEHICLE_PHOTO',
          'registrationNo': registrationNo.value,
          'files': await MultipartFile.fromFile(fileImage.value!.path,
              filename: 'photo${getExt(path: fileImage.value!.path)}'),
        },
      );

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        // '${dotenv.env['BASE_URL_FSR']}/v1/vehicle-driver/attachment/add',
        body: data,
      );
      //// kLog(res.data);

      // if (int.parse(res.data['responseCode'] as String) == 200) {}
      fileImage.value = null;
      //// kLog(fileImage.value!.path);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //..........................................
  // Register as Driver Page Driving License (Front Side)
//..........................................

  void drivinLicenseImageUplodFront() async {
    final username = Get.put(UserController()).currentUser.value!.username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      //kLog(fileImageLicensFront.value!.path);
      //// kLog(licenseNo.value);
      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'ITS',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_LICENSE_FRONT',
          'ids': licenseNo.value,
          //'ids': '33333333',
          'files': await MultipartFile.fromFile(
              fileImageLicensFront.value!.path,
              filename:
                  'photo${getExt(path: fileImageLicensFront.value!.path)}'),
        },
      );

      await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      // First confirm that the server responded
      // if (int.parse(res.data['responseCode'] as String) == 200) {}
      fileImageLicensFront.value = null;
      //// kLog(fileImage.value!.path);
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //...............................................................................

  //..........................................
// Register as Driver Page Driving License (Back Side)
//..........................................

  void drivinLicenseImageUplodBack() async {
    final username = Get.put(UserController()).currentUser.value!.username;
    final selectedAgency = Get.put(AgencyController()).selectedAgency;
    try {
      // kLog(fileImageLicensBack.value!.path);
      //// kLog(licenseNo.value);
      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'ITS',
          'countryCode': selectedAgency!.countryCode,
          'username': username,
          'fileCategory': 'FILE_LICENSE_BACK',
          'ids': licenseNo.value,
          //'ids': '33333333',
          'files': await MultipartFile.fromFile(fileImageLicensBack.value!.path,
              filename:
                  'photo${getExt(path: fileImageLicensBack.value!.path)}'),
        },
      );

      // ignore: unused_local_variable
      final res = await postDynamic(
        path: '${dotenv.env['BASE_URL_WFC']}/v1/evidence-attachment/add',
        body: data,
      );

      // First confirm that the server responded
      // if (int.parse(res.data['responseCode'] as String) == 200) {}
      fileImageLicensBack.value = null;
      //// kLog(fileImage.value!.path);
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
