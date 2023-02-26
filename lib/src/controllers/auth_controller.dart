import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/controllers/agencyController.dart';
import 'package:workforce/src/controllers/user_controller.dart';
import 'package:workforce/src/helpers/get_file_name.dart';
import 'package:workforce/src/helpers/k_text.dart';

import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/hive_models/user_image.dart';
import 'package:workforce/src/models/user.dart';
import 'package:workforce/src/pages/main_page.dart';
import 'package:workforce/src/services/api_service.dart';
import 'package:workforce/src/services/validation_service.dart';

import '../helpers/dialogHelper.dart';
import '../helpers/image_compress.dart';
import 'location_controller.dart';

enum Phase {
  signUp,
  otp,
  confirmed,
}

class AuthController extends GetxController with ApiService, ValidationService {
  final _picker = ImagePicker();
  // final otpTimer = Rx
  // Sign Up Phase
  final _dio = Dio();
  final phase = Rx<Phase>(Phase.signUp);

  final pickedImage = Rx<XFile?>(null);
  final fileImage = Rx<File?>(null);
  final pickedImageMemory = Rx<Uint8List?>(null);

  final userImage = Rx<Uint8List?>(null);

  final isLoading = RxBool(false);
  final isRegLoading = RxBool(false);
  // Login type
  final loginType = RxString('online');
  // --------------------------------  ----------------------------

  // For login
  final username = RxString('');
  final password = RxString('');
  final isBiometric = RxBool(false);
  final visibleBiometric = RxBool(false);
  final visiblePassword = RxBool(true);
  // ------------------------------------------------------------
  // For SignUp
  final fullName = RxString('');

  final regUsername = RxString('');
  final mobileNumer = RxString('');
  final email = RxString('');
  final gender = RxString('male');
  final dateOfBirth = RxString('');
  final address = RxString('');
  final isTermsAgree = RxBool(false);

  final regPassword = RxString('');
  final regConfirmPassword = RxString('');
  final otp = RxString('');

  // ------------------------------------------------------------

  // For Forgot Username
  final isForgotLoading = RxBool(false);
  final forgotUsername = RxString('');
  // ------------------------------------------------------------

  // For Forgot Password
  final forgotPasswordInputField = RxString('');
  final forgotNewPassword = RxString('');
  final forgotConfirmPassword = RxString('');
  final isForgotNewObscure = RxBool(true);
  final isForgotConfirmObscure = RxBool(true);
  // ------------------------------------------------------------

  bool isSubmitButtonValid() {
    if (pickedImage.value != null &&
        fullName.value.isNotEmpty &&
        regUsername.value.isNotEmpty &&
        mobileNumer.value.length > 10 &&
        email.value.contains('@') &&
        gender.value.isNotEmpty &&
        dateOfBirth.value.isNotEmpty &&
        address.value.isNotEmpty &&
        isTermsAgree.value) {
      return true;
    } else {
      return false;
    }
  }

  bool isOtpButtonValid() {
    if (otp.value.length == 4 &&
        regPassword.value.isNotEmpty &&
        regConfirmPassword.value.isNotEmpty &&
        regPassword.value == regConfirmPassword.value) {
      return true;
    } else {
      return false;
    }
  }

  bool isLoginButtonValid() {
    if (username.value.isNotEmpty && password.value.length >= 4) {
      return true;
    } else {
      return false;
    }
  }

  final obscure = RxBool(true);

  void changeObscure() {
    obscure.toggle();
  }

  void login() async {
    // final versionC = Get.put(VersionController());
    // await versionC.getAppVersion();
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);

      isLoading.value = true;
      // kLog(stringToBase64.encode('pKode ${password.value}'));
      //
      final res = await post(
        path: '/user_authentication',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'username': username.value,
          'password': stringToBase64.encode('pKode${password.value}'),
          'appCode': 'SHOUT',
          'version': 1
        },
      );
      // kLog(res.data);
      if (res.data['message'] != null &&
          res.data['message'].contains('INVALID_CREDENTIALS') == true) {
        Get.defaultDialog(
            backgroundColor: Colors.white,
            title: '',
            content: SizedBox(
              height: 200,
              width: Get.width,
              child: Column(
                children: [
                  Icon(
                    EvaIcons.alertTriangleOutline,
                    color: Colors.red.withOpacity(.6),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  KText(
                    text: 'Username or password wrong',
                    fontSize: 17,
                    bold: false,
                    color: AppTheme.textColor,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ));

        isLoading.value = false;
      } else {
        final rawData = res.data['data']['user'];

        final userData = User.fromJson(rawData as Map<String, dynamic>);
        //------------------------------------------------------

        await getImageByUserName(userName: userData.username!);

        if (userImage.value != null) {
          userData.token = res.data['token'] as String;

          Get.put(UserController()).currentUser.value = userData;

          // Add user data in local DB

          final userBox = Hive.box<User>('user');

          await userBox.put(
            'current_user',
            User(
              fullName: userData.fullName,
              username: userData.username,
              address: userData.address,
              token: userData.token,
              // image: userImage.value,
            ),
          );
        }
        //// kLog(userData.username);

        await Get.put(AgencyController()).getAgencies('${userData.username}');

        offAll(MainPage());

        // final fullName = userData['personName'] as String;
        // final userName = userData['username'] as String;
        // final address = userData['homeAddress'] as String;

        // print(fullName);
        // print(userName);
        // print(address);
        // print(token);

        // final user = LocalUser(
        //   address: address,
        // );

        isLoading.value = false;
        // Login Succeded

        // // final username = res.data['data']['user']['username'] as String;

        // final userBox = Hive.box<User>('user');
        // final user = User(token: token, name: name);
        // await userBox.put(
        //   'current_user',
        //   user,
        // );

        // Get.put(UserController()).user.value = user;
        // offAll(MainPage());
        // isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  void signUp() async {
    try {
      isRegLoading.value = true;
      // phase.value = Phase.signUp;

      final res = await post(
        path: '/request_for_otp',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'username': regUsername.value,
          'email': email.value,
          'mobile': mobileNumer.value,
        },
      );

      if (res.data['message'] != null &&
          res.data['message'].contains('Email already exists.') == true) {
        isRegLoading.value = false;
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: '',
          content: SizedBox(
            height: 200,
            width: Get.width,
            child: Column(
              children: [
                Icon(
                  EvaIcons.alertTriangleOutline,
                  color: Colors.red.withOpacity(.6),
                  size: 60,
                ),
                SizedBox(
                  height: 22,
                ),
                KText(
                  text: 'Email already exists.',
                  fontSize: 17,
                  bold: false,
                  color: AppTheme.textColor,
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primaryColor)),
                    child: KText(
                      text: 'OK',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      } else if (res.data['message'] != null &&
          res.data['message'].contains('Mobile already exists.') == true) {
        isRegLoading.value = false;
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: '',
          content: SizedBox(
            height: 200,
            width: Get.width,
            child: Column(
              children: [
                Icon(
                  EvaIcons.alertTriangleOutline,
                  color: Colors.red.withOpacity(.6),
                  size: 60,
                ),
                SizedBox(
                  height: 22,
                ),
                KText(
                  text: 'Mobile number already exists.',
                  fontSize: 17,
                  bold: false,
                  color: AppTheme.textColor,
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primaryColor)),
                    child: KText(
                      text: 'OK',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      } else if (res.data['message'] != null &&
          res.data['message'].contains('Username already exists.') == true) {
        isRegLoading.value = false;
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: '',
          content: SizedBox(
            height: 200,
            width: Get.width,
            child: Column(
              children: [
                Icon(
                  EvaIcons.alertTriangleOutline,
                  color: Colors.red.withOpacity(.6),
                  size: 60,
                ),
                SizedBox(
                  height: 22,
                ),
                KText(
                  text: 'Username already exists.',
                  fontSize: 17,
                  bold: false,
                  color: AppTheme.textColor,
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: Get.width / 2,
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primaryColor)),
                    child: KText(
                      text: 'OK',
                      bold: true,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        isRegLoading.value = false;
        phase.value = Phase.otp;
      }
    } catch (e) {
      isRegLoading.value = false;
      print(e);
      print(e);
    }
  }

  void confirmSignUp() async {
    try {
      isRegLoading.value = true;
      Codec<String, String> stringToBase64 = utf8.fuse(base64);

      final data = FormData.fromMap(
        {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'appCode': 'SHOUT',
          'version': 1,
          'personName': fullName.value,
          'username': regUsername.value,
          'password': stringToBase64.encode('pKode${regPassword.value}'),
          'mobile': mobileNumer.value,
          'email': email.value,
          'gender': gender.value,
          'homeAddress': address.value,
          'birthDate': dateOfBirth.value,
          'otp': otp.value,
          'uiCodes': ['555'],
          'files': await MultipartFile.fromFile(fileImage.value!.path,
              filename: 'photo${getExt(path: fileImage.value!.path)}'),
        },
      );
      final res = await post(
        path: '/add_user_form',
        body: data,
      );

      // First confirm that the server responded
      if (int.parse(res.data['responseCode'] as String) == 200) {
        phase.value = Phase.confirmed;
        isRegLoading.value = false;
      }

      if (res.data['message'] != null) {
        // Now confirm that all validations succeeded!

        if (res.data['message'].contains('INVALID_CREDENTIALS') == true) {
          isRegLoading.value = false;
          // Now we are good to proccess the api output
          Get.defaultDialog(
            backgroundColor: Colors.white,
            title: '',
            content: SizedBox(
              height: 200,
              width: Get.width,
              child: Column(
                children: [
                  Icon(
                    EvaIcons.alertTriangleOutline,
                    color: Colors.red.withOpacity(.6),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  KText(
                    text: 'Validation failed',
                    fontSize: 17,
                    bold: false,
                    color: AppTheme.textColor,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (int.parse(res.data['responseCode'] as String) != 200) {
          Get.defaultDialog(
            backgroundColor: Colors.white,
            title: '',
            content: SizedBox(
              height: 200,
              width: Get.width,
              child: Column(
                children: [
                  Icon(
                    EvaIcons.alertTriangleOutline,
                    color: Colors.red.withOpacity(.6),
                    size: 60,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  KText(
                    text: 'Validation failed',
                    fontSize: 17,
                    bold: false,
                    color: AppTheme.textColor,
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppTheme.primaryColor)),
                      child: KText(
                        text: 'OK',
                        bold: true,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }

      isRegLoading.value = false;
    } catch (e) {
      isRegLoading.value = false;
      print(e);
    }
  }

  //===========================================================
  // *******  Forgot User Name  *********
  //===========================================================

  void forgetUsernameByEmail() async {
    try {
      isForgotLoading.value = true;

      final res = await post(
        path: '/request_for_forget_username',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'email': forgotUsername.value
        },
      );

      print(res.data);

      print(res.data);
      if (res.data['message'] != null &&
          res.data['message'].contains('Invalid email.') == true) {
        back();
        DialogHelper.forgetPassShowErrorDialog(
            msg: 'Your Email doesn\'t exist.');
        isForgotLoading.value = false;
      } else if (res.data['responseCode'] != null &&
          res.data['responseCode'] == '200') {
        back();
        isForgotLoading.value = false;
        DialogHelper.showOtpAndNewPassInputDialog();
      }
      isForgotLoading.value = false;
      // forgotUsername.value = '';
    } catch (e) {
      isForgotLoading.value = false;
      print(e);
    }
  }

  // OTP Send
  void sendOtpByEmail() async {
    try {
      isForgotLoading.value = true;
      // print(forgotUsername.value);

      final res = await post(
        path: '/get_forget_username_by_otp',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'email': forgotUsername.value,
          'otp': otp.value
        },
      );

      // print(res.data);
      if (res.data['message'] != null &&
          res.data['message'].contains('otp does not match') == true) {
        back();
        isForgotLoading.value = false;
        DialogHelper.forgetPassShowErrorDialog(msg: 'Invalid OTP number.');
        isForgotLoading.value = false;
      } else if (res.data['responseCode'] != null &&
          res.data['responseCode'] == '200') {
        isForgotLoading.value = false;
        back();
        DialogHelper.showForgotPasswordSuccessDialog(
          msg:
              'A mail has been sent to your email informing your username. Please check your inbox or spam.',
          title: 'Forgot Username',
        );
      }
      isForgotLoading.value = false;
      forgotUsername.value = '';
      otp.value = '';
    } catch (e) {
      isForgotLoading.value = false;
      print(e);
    }
  }

  //===========================================================
  // *******  Forgot Password  *********
  //===========================================================
  passwordResetByEmail() async {
    try {
      isForgotLoading.value = true;
      print(forgotPasswordInputField.value);

      final res = await post(
        path: '/reset_user_password',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'inputField': forgotPasswordInputField.value,
        },
      );

      print(res.data);
      if (res.data['message'] != null &&
          res.data['message'].contains('Invalid username or email.') == true) {
        back();
        isForgotLoading.value = false;
        DialogHelper.forgetPassShowErrorDialog(
            msg: 'Your Email doesn\'t exist.');
      } else if (res.data['responseCode'] != null &&
          res.data['responseCode'] == '200') {
        back();
        isForgotLoading.value = false;
        DialogHelper.showOtpAndNewPassInputDialog2(title: 'Reset Password');
      }
      isForgotLoading.value = false;
      // forgotPasswordInputField.value = '';
    } catch (e) {
      isForgotLoading.value = false;
      print(e);
    }
  }

  //------------------------------------------------------------------
  sendPasswordResetOTPByEmail() async {
    try {
      print('<<<<<<Reset Pass Otp>>>>>>');
      print(forgotPasswordInputField.value);

      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      isForgotLoading.value = true;
      final res = await post(
        path: '/update_user_password',
        body: {
          'apiKey': 'ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5',
          'inputField': forgotPasswordInputField.value,
          'password':
              stringToBase64.encode('pKode${forgotConfirmPassword.value}'),
          'otp': otp.value
        },
      );

      print(res.data);
      if (res.data['message'] != null &&
          res.data['message'].contains('INVALID_CREDENTIALS') == true) {
        back();
        DialogHelper.forgetPassShowErrorDialog(msg: 'Invalid OTP number.');
        isForgotLoading.value = false;
      } else if (res.data['responseCode'] != null &&
          res.data['responseCode'] == '200') {
        back();
        DialogHelper.showForgotPasswordSuccessDialog(
          msg: 'Your password has been updated successfully.',
          title: 'Success!',
        );
        isForgotLoading.value = false;
      }
      disposeForgotData();
    } catch (e) {
      isForgotLoading.value = false;
      print(e);
    }
  }

  ////=///===================================================================

  getImageByUserName({required String userName}) async {
    try {
      // print(username);
      final res = await _dio.get<Uint8List>(
        '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$userName&appCode=KYC&fileCategory=photo&countryCode=BD',
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'latLng':
                '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}',
          },
        ),
      );
      print(res.data);

      final userBox = Hive.box<UserImage>('user_image');

      await userBox.put('current_user_image', UserImage(image: res.data));
      userImage.value = res.data;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  //====================================================================

  // Select user avatar image
  void selectAvatar() async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image!.path.isNotEmpty) {
      // pickedImage.value = image;
      // pickedImageMemory.value = await image.readAsBytes();

      // File image
      fileImage.value = File(image.path);

      // Image compress function
      final img = await compressFile(
        file: fileImage.value,
      );

      // Load compress image
      fileImage.value = img;

      pickedImage.value = XFile(img.path);
      pickedImageMemory.value = await img.readAsBytes();
    }
  }

  void selectAvatarFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image!.path.isNotEmpty) {
      // pickedImage.value = image;
      // pickedImageMemory.value = await image.readAsBytes();

      // File image
      fileImage.value = File(image.path);

      // Image compress function
      final img = await compressFile(
        file: fileImage.value,
      );

      // Load compress image
      fileImage.value = img;

      pickedImage.value = XFile(img.path);
      pickedImageMemory.value = await img.readAsBytes();
    }
  }

  // ----------------------------------------------

  disposeData() {
    phase.value = Phase.signUp;
    username.value = '';
    password.value = '';
    fullName.value = '';

    regUsername.value = '';
    mobileNumer.value = '';
    email.value = '';
    gender.value = 'male';
    dateOfBirth.value = '';
    address.value = '';
    isTermsAgree.value = false;

    regPassword.value = '';
    regConfirmPassword.value = '';
    otp.value = '';
    isLoading.value = false;
    isRegLoading.value = false;
    userImage.value = null;
    pickedImage.value = null;
    pickedImageMemory.value = null;
  }

  void disposeForgotData() {
    forgotPasswordInputField.value = '';
    forgotNewPassword.value = '';
    forgotConfirmPassword.value = '';
    isForgotNewObscure.value = false;
    isForgotConfirmObscure.value = false;
  }

  getImagePath({required String userName}) async {
    try {
      final locationC = Get.put(LocationController());
      final latLng =
          '${locationC.latLng.value.latitude},${locationC.latLng.value.longitude}';
      final data =
          '${dotenv.env['BASE_URL_FSR']}/v2/user-attachment/get?latLng=$latLng&apiKey=ZWR1Y2l0aW9uQkRBMTIzNDU2Nzg5&username=$userName&appCode=KYC&fileCategory=photo&countryCode=BD';
      return Image.network(
        data,
        fit: BoxFit.cover,
      );
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
