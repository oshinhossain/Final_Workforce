import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/loading.dart';
import 'package:workforce/src/helpers/route.dart';
import 'package:workforce/src/pages/signup_page.dart';
import 'package:workforce/src/services/validation_service.dart';
import '../helpers/dialogHelper.dart';
import '../helpers/global_helper.dart';
import '../models/biometric.dart';

class LoginPage extends StatefulWidget {
  final bool? isLogin;

  const LoginPage({super.key, this.isLogin});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationService, Base {
  @override
  void initState() {
    super.initState();

    if (widget.isLogin == true) {
      showDialog();
    }
  }

  showDialog() async {
    await Future.delayed(Duration(milliseconds: 80));
    versionC.appVersionDialog();
    // GlobalDialog.statusDialog(
    //   title: 'App Version',
    //   msg:
    //       'Please update the app version ${versionC.appVersion.isNotEmpty ? versionC.appVersion[0].appVersion : ''}',
    //   onPressed: () {
    //     back();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    versionC.getAppVersion();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
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
                  height: 70,
                ),
                Center(
                  child: SvgPicture.asset(
                    '${Constants.svgPath}/workforce_logo.svg',
                    width: 130,
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          authC.isBiometric.value = false;
                          authC.visibleBiometric.value = false;
                          authC.visiblePassword.value = true;
                          print('Password ${authC.isBiometric.value}');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: authC.isBiometric.value == false
                                ? AppTheme.primaryColor
                                : AppTheme.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                            border: Border.all(
                                width: 1, color: AppTheme.primaryColor),
                          ),
                          child: KText(
                            text: 'Password',
                            color: authC.isBiometric.value == true
                                ? hexToColor('#84BEF3')
                                : Colors.white,
                            bold: true,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          authC.isBiometric.value = true;
                          authC.visibleBiometric.value = true;
                          authC.visiblePassword.value = false;
                          print('Password ${authC.isBiometric.value}');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: authC.isBiometric.value == true
                                ? AppTheme.primaryColor
                                : AppTheme.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                            border: Border.all(
                                width: 1, color: AppTheme.primaryColor),
                          ),
                          child: KText(
                            text: 'Biometric',
                            color: authC.isBiometric.value == true
                                ? Colors.white
                                : hexToColor('#84BEF3'),
                            bold: true,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    Visibility(
                      visible: authC.visiblePassword.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            // initialValue: userC.currentUser.value!.username,
                            textInputAction: TextInputAction.next,
                            onChanged: authC.username,

                            decoration: InputDecoration(
                              errorText: validateUsername(authC.username.value),
                              label: KText(
                                text: 'Username',
                                color: AppTheme.textColor,
                                fontSize: 16,
                              ),
                              hintText: 'Enter your username',
                              // prefixIcon: Icon(
                              //   Icons.person_outline,
                              //   color: AppTheme.color3,
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          TextField(
                            onChanged: authC.password,
                            obscureText: authC.obscure.value,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (value) {
                              // kLog(value);
                              authC.isLoginButtonValid() ? authC.login() : null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => authC.changeObscure(),
                                icon: Icon(
                                  authC.obscure.value
                                      ? EvaIcons.eyeOffOutline
                                      : EvaIcons.eyeOutline,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              label: KText(
                                text: 'Password',
                                color: AppTheme.textColor,
                                fontSize: 16,
                              ),
                              errorMaxLines: 2,
                              errorText: validatePassword(authC.password.value),
                              hintText: 'Enter your password',
                              // prefixIcon: Icon(
                              //   Icons.lock_outline,
                              //   color: AppTheme.color3,
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3),
                            child: KText(
                              text: 'Login type',
                              color: hexToColor('#80939D'),
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
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: authC.loginType.value,
                                onChanged: (v) {
                                  authC.loginType.value = 'online';
                                },
                                groupValue: 'online',
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  authC.loginType.value = 'online';
                                },
                                child: KText(
                                  text: 'Online',
                                  color: AppTheme.black,
                                  fontSize: 16,
                                ),
                              ),
                              Radio<String>(
                                visualDensity: VisualDensity(
                                    horizontal: VisualDensity.minimumDensity,
                                    vertical: VisualDensity.minimumDensity),
                                value: authC.loginType.value,
                                onChanged: (v) {
                                  authC.loginType.value = 'offline';
                                },
                                groupValue: 'offline',
                              ),
                              GestureDetector(
                                onTap: () {
                                  authC.loginType.value = 'offline';
                                },
                                child: KText(
                                  text: 'Offline',
                                  color: AppTheme.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: Get.width,
                            height: .6,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  DialogHelper.showUniqueIdentifierInputDialog(
                                    title: 'Forgot Username',
                                    inputLabel: 'Email',
                                    onChanged: authC.forgotUsername,
                                    onPressed: () {
                                      authC.forgetUsernameByEmail();
                                    },
                                  );
                                },
                                child: Center(
                                  child: KText(
                                    bold: true,
                                    text: 'Forgot Username?',
                                    color: AppTheme.color2,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogHelper.showUniqueIdentifierInputDialog(
                                    title: 'Forgot Password',
                                    inputLabel: 'Email/Username',
                                    onChanged: authC.forgotPasswordInputField,
                                    onPressed: () {
                                      authC.passwordResetByEmail();
                                    },
                                  );
                                },
                                child: Center(
                                  child: KText(
                                    bold: true,
                                    text: 'Forgot Password?',
                                    color: AppTheme.color2,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () => authC.isLoginButtonValid()
                                  ? versionC.checkAppVersion()
                                      ? authC.login()
                                      : versionC.appVersionDialog()
                                  : null,
                              child: Container(
                                width: 200,
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(
                                      authC.isLoginButtonValid() ? 1 : .6),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: authC.isLoading.value
                                    ? Loading(
                                        color: Colors.white,
                                      )
                                    : KText(
                                        text: 'Sign In',
                                        color: Colors.white,
                                        bold: true,
                                        fontSize: 16,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 38,
                          ),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KText(
                                text: 'Don\'t have an account?',
                                color: AppTheme.color1,
                                fontSize: 15,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  push(SignUpPage());
                                },
                                child: KText(
                                  bold: true,
                                  text: 'Sign Up',
                                  color: AppTheme.color2,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )),
                          SizedBox(height: 30),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                KText(
                                  text: 'Version ${AppTheme.appVersion}',
                                  color: hexToColor('#9FB3BE'),
                                ),
                                SizedBox(height: 5),
                                KText(
                                  text:
                                      '© ${getCurrentYear()} ${AppTheme.appTitle}',
                                  color: hexToColor('#9FB3BE'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: authC.visibleBiometric.value,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: Biometric.biometricCategoryGridItem.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              Biometric.biometricCategoryGridItem[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: hexToColor(item.themeColor),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  item.bgThemePath,
                                  //color: Colors.pink,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(item.iconPath),
                                        SizedBox(height: 15),
                                        Text(
                                          item.titleText,
                                          style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16.0,
                                              color: hexToColor('#FFFFFF'),
                                              fontWeight: FontWeight.w700,
                                              height: 1.5),
                                        ),
                                        // SizedBox(height: 5),
                                        Text(
                                          item.subTitleText,
                                          style: TextStyle(
                                              fontFamily: 'Manrope',
                                              fontSize: 16.0,
                                              color: hexToColor('#FFFFFF'),
                                              fontWeight: FontWeight.w700,
                                              height: 1.5),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
