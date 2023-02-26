import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/controllers/auth_controller.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/services/validation_service.dart';

import '../helpers/convert_map_data.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationService, Base {
  final datepicker = TextEditingController();
  @override
  void dispose() {
    authC.disposeData();
    authC.pickedImage.value = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppTheme.appbarColor,
        backgroundColor: AppTheme.appbarColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.appbarColor,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarDividerColor: Colors.grey[50],
          systemNavigationBarColor: Colors.grey[50],
        ),
        title: KText(
          text: 'Sign Up',
          fontSize: 20,
          bold: true,
          color: AppTheme.textColor,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                authC.phase.value == Phase.signUp
                    ? signUp()
                    : authC.phase.value == Phase.otp
                        ? otp()
                        : confirmed(),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            authC.selectAvatar();
          },
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.appbarColor,
                  radius: 50,
                  child: authC.pickedImage.value != null
                      ? ClipOval(
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(50),
                              // Image radius
                              child: authC.pickedImageMemory.value != null
                                  ? Image.memory(authC.pickedImageMemory.value!,
                                      fit: BoxFit.cover)
                                  : Loading(
                                      color: AppTheme.primaryColor,
                                    )),
                        )
                      : CircleAvatar(
                          backgroundColor: AppTheme.color4,
                          radius: 45,
                          child: SvgPicture.asset(
                            '${Constants.svgPath}/avatar_placeholder.svg',
                          ),
                        ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.color4,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: SvgPicture.asset(
                        '${Constants.svgPath}/cam.svg',
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        TextFormField(
          initialValue: authC.fullName.value,
          onChanged: authC.fullName,
          decoration: InputDecoration(
            errorText: validateFullName(authC.fullName.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Full Name',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter your full name',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),

        TextField(
          inputFormatters: <TextInputFormatter>[UpperCaseTextFormatter()],
          onChanged: authC.regUsername,
          decoration: InputDecoration(
            errorText: validateUsername(authC.regUsername.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Username',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter your username',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        TextField(
          onChanged: authC.mobileNumer,
          decoration: InputDecoration(
            errorText: validateMobileNumber(authC.mobileNumer.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Mobile Number',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter your mobile number',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        TextField(
          onChanged: authC.email,
          decoration: InputDecoration(
            errorText: validateEmail(authC.email.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Email',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter your email',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),

        // TextField(
        //   onChanged: authC.password,
        //   obscureText: authC.obscure.value,
        //   decoration: InputDecoration(
        //     suffixIcon: IconButton(
        //       onPressed: () => authC.changeObscure(),
        //       icon: Icon(
        //         authC.obscure.value
        //             ? EvaIcons.eyeOutline
        //             : EvaIcons.eyeOffOutline,
        //         color: AppTheme.primaryColor,
        //       ),
        //     ),
        //     labelText: 'password',
        //     errorText: validatePassword(authC.password.value),
        //     hintText: 'Enter your password',
        //     // prefixIcon: Icon(
        //     //   Icons.lock_outline,
        //     //   color: AppTheme.color3,
        //     // ),
        //   ),
        // ),
        SizedBox(
          height: 12,
        ),
        Container(
          margin: EdgeInsets.only(left: 3),
          child: KText(
            text: 'Gender',
            color: AppTheme.textColor,
            //   hexToColor('#80939D'),
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio<String>(
              visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: authC.gender.value,
              onChanged: (v) {
                authC.gender.value = 'male';
              },
              groupValue: 'male',
            ),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                authC.gender.value = 'male';
              },
              child: KText(
                text: 'Male',
                color: AppTheme.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Radio<String>(
              visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: authC.gender.value,
              onChanged: (v) {
                authC.gender.value = 'female';
              },
              groupValue: 'female',
            ),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                authC.gender.value = 'female';
              },
              child: KText(
                text: 'Female',
                color: AppTheme.black,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Radio<String>(
              visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: authC.gender.value,
              onChanged: (v) {
                authC.gender.value = 'others';
              },
              groupValue: 'others',
            ),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                authC.gender.value = 'others';
              },
              child: KText(
                text: 'Others',
                color: AppTheme.black,
                fontSize: 16,
              ),
            ),
          ],
        ),

        SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width,
          height: .8,
          color: AppTheme.primaryColor,
        ),
        SizedBox(
          height: 18,
        ),
        TextField(
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: Get.context!,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now());

            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              authC.dateOfBirth.value = formattedDate;
            } else {}
            datepicker.clear();
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  EvaIcons.calendarOutline,
                  color: AppTheme.primaryColor.withOpacity(.7),
                ),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    authC.dateOfBirth.value = formattedDate;
                  } else {}
                  datepicker.clear();
                },
              ),
              // label: Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     KText(
              //       text: authC.dateOfBirth.value.isEmpty
              //           ? 'Date of Birth'
              //           : authC.dateOfBirth.value,
              //       color: AppTheme.textColor,
              //       fontSize: 16,
              //     ),
              //     SizedBox(
              //       width: 2,
              //     ),
              //     KText(
              //       text: '*',
              //       color: Colors.redAccent,
              //     ),
              //   ],
              // ),
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppTheme.textColor,
              ),
              hintText: authC.dateOfBirth.value.isEmpty
                  ? 'Enter your date of birth'
                  : authC.dateOfBirth.value

              // prefixIcon: Icon(
              //   Icons.person_outline,
              //   color: AppTheme.color3,
              // ),
              ),
        ),
        TextField(
          onChanged: authC.address,
          decoration: InputDecoration(
            // errorText: validateAddress(authC.address.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Address',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter your address',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        SizedBox(
          height: 28,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              activeColor: AppTheme.primaryColor,
              onChanged: (v) => authC.isTermsAgree.toggle(),
              value: authC.isTermsAgree.value,
            ),
            KText(
              text: 'I agree with the',
              color: AppTheme.color1,
              fontSize: 15,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: KText(
                bold: true,
                text: 'terms and conditions',
                color: AppTheme.color2,
                fontSize: 15,
              ),
            ),
          ],
        ),

        SizedBox(
          height: 22,
        ),

        Center(
          child: GestureDetector(
            onTap: () => authC.isSubmitButtonValid() ? authC.signUp() : null,
            child: Container(
              width: 200,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor
                    .withOpacity(authC.isSubmitButtonValid() ? 1 : .6),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: authC.isRegLoading.value
                  ? Loading(
                      color: Colors.white,
                    )
                  : KText(
                      text: 'Submit',
                      color: Colors.white,
                      bold: true,
                      fontSize: 21,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget otp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: 'OTP sent to your email, please check your email',
          color: Colors.green,
          fontSize: 14,
          bold: true,
        ),
        TextField(
          onChanged: authC.otp,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: validateOtp(authC.otp.value),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'OTP',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            hintText: 'Enter 4 digit valid OTP',

            // prefixIcon: Icon(
            //   Icons.person_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        TextField(
          onChanged: authC.regPassword,
          obscureText: authC.obscure.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () => authC.changeObscure(),
              icon: Icon(
                authC.obscure.value
                    ? EvaIcons.eyeOutline
                    : EvaIcons.eyeOffOutline,
                color: AppTheme.primaryColor,
              ),
            ),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Password',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            errorText: validatePassword(authC.regPassword.value),
            errorMaxLines: 2,
            hintText: 'Enter your password',
            // prefixIcon: Icon(
            //   Icons.lock_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        TextField(
          onChanged: authC.regConfirmPassword,
          obscureText: authC.obscure.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () => authC.changeObscure(),
              icon: Icon(
                authC.obscure.value
                    ? EvaIcons.eyeOutline
                    : EvaIcons.eyeOffOutline,
                color: AppTheme.primaryColor,
              ),
            ),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                KText(
                  text: 'Confirm password',
                  color: AppTheme.textColor,
                  fontSize: 16,
                ),
                SizedBox(
                  width: 2,
                ),
                KText(
                  text: '*',
                  color: Colors.redAccent,
                ),
              ],
            ),
            errorText: validateConfirmPassword(
                authC.regPassword.value, authC.regConfirmPassword.value),
            errorMaxLines: 2,
            hintText: 'Enter your password',
            // prefixIcon: Icon(
            //   Icons.lock_outline,
            //   color: AppTheme.color3,
            // ),
          ),
        ),
        SizedBox(
          height: 22,
        ),
        Center(
          child: GestureDetector(
            onTap: () =>
                authC.isOtpButtonValid() ? authC.confirmSignUp() : null,
            child: Container(
              width: 200,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor
                    .withOpacity(authC.isOtpButtonValid() ? 1 : .6),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: authC.isRegLoading.value
                  ? Loading(
                      color: Colors.white,
                    )
                  : KText(
                      text: 'Confirm',
                      color: Colors.white,
                      bold: true,
                      fontSize: 21,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget confirmed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: Colors.green),
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: KText(
                text: 'Registration Successful!',
                maxLines: 2,
                fontSize: 18,
                bold: true,
                color: Colors.green,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => back(),
              child: Container(
                width: 200,
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: KText(
                  text: 'Sign In',
                  color: Colors.white,
                  bold: true,
                  fontSize: 21,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
