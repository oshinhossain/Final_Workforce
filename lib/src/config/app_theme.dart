import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workforce/src/helpers/hex_color.dart';

class AppTheme {
  // AppTheme._();

  static const appTitle = 'Workforce';
  static const appVersion = '1.0.1';

  //===========================================

  static Color primaryColor = hexToColor('#007BEC');
  static Color appbarColor = hexToColor('#EEF0F6');
  static Color textColor = hexToColor('#41525A');
  static Color textColorlight = hexToColor('#80939D');
  static Color white = Colors.white;

  static Color color1 = hexToColor('#2c3e50');
  static Color color2 = hexToColor('#FFA133');
  static Color color3 = hexToColor('#8A8D93');
  static Color color4 = hexToColor('#78909C');
  static Color color5 = hexToColor('#EAEAF3');
  static Color color6 = hexToColor('#9BA9B3');

  static Color black = Colors.black;

  // ------------------

  static Color appHomePageColor = Color(0xFFEFF6FF);
  static Color appFooterColor = Color(0xFF78909C);
  static Color newAppBarTextColor = Color(0xFF434969);
  static Color newAppBarBackgroundColor = Color(0xFFEFF6FF);
  static Color appTextColor1 = Color(0xFF72778F);
  static Color appTextColor2 = Color(0xFF141C44);
  static Color focusedLineColor = Color(0xFFF2BA14);
  static Color enabledLineColor = Color(0xFFA3CCDC);
  static Color enabledLineColors = Color(0xFFECEAEA);
  static Color disableColors = Color(0xFFBCC8CE);

  // Nahid

  static Color nEvaIconC = hexToColor('#80939D');
  static Color nColor1 = hexToColor('#DBECFB');
  static Color nColor2 = hexToColor('#98F2DB');
  static Color nTextLightC = hexToColor('#80939D');
  static Color nTextC = hexToColor('#515D64');
  static Color nBorderC1 = hexToColor('#DBECFB');
  static Color nBorderC2 = hexToColor('#80939D');
  static Color nBorderC3 = hexToColor('#98F2DB');
  static Color nBorderC4 = hexToColor('#FFCCCC');
  static Color nTONColor3 = hexToColor('#FFCCCC');
  static Color nBoxC1 = hexToColor('#CCE7FF');
  static Color nBoxC3 = hexToColor('#BFFFEE');
  static Color nBoxC2 = hexToColor('#FFECD6');
  static Color nBoxC4 = hexToColor('#FFE1E1');
  static Color nColor3 = hexToColor('#FFE9CF');
  static Color nColor4 = hexToColor('#49CDAB');
  static Color nColor5 = hexToColor('#FF9191');
  static Color nColor6 = hexToColor('#75B7F3');
  static Color nColor7 = hexToColor('#8BB2D6');
  static Color nBtn1 = hexToColor('#9BA9B3');
  static Color nTabTextUC = hexToColor('#007BEC');

  // ---------------------------------------------------

  //oshin
  static Color oColor1 = hexToColor('#41525A');
  static Color oColor2 = hexToColor('#FF9191');
  static Color oColor3 = hexToColor('#FFE9CF');

  //....................................................

  // Zillur
  static Color textfieldColor = hexToColor('#80939D');
  static Color skyBuluColor = hexToColor('#66A1D9');
  static Color yellowColor = hexToColor('#FFA133');
  static Color vehicleItemColor = hexToColor('#DBECFB');
  static Color siteLocationSelect = hexToColor('#84BEF3');
  static Color siteLocationtext = hexToColor('#007BEC');

  //--------------------------------------------------------------------------------------------------
//added by sumaiya
  static Color colorS1 = hexToColor('#41525A');
  static Color colorS2 = hexToColor('#FFA133');
  static Color borderColor = hexToColor('#DBECFB');
  static Color rattingColor = hexToColor('#FDB35C');
  static Color profesionalColor = hexToColor('#61ADF2');
  static Color unprofesionalColor = hexToColor('#FF9191');
  static Color searchColor = hexToColor('#84BEF3');
  static Color bdrColor = hexToColor('#CFD7DA');
  static Color btnColor = hexToColor('#007BEC');
  static Color rateColor = hexToColor('#9BA9B3');
  static Color enableColor = hexToColor('#BAC2CE');
  static Color focusColor = hexToColor('#51A7F7');
  static Color txtColor = hexToColor('#515D64');
  static Color compltColor = hexToColor('#49CDAB');
  static Color cancletColor = hexToColor('#FF9191');
  static Color inTransitColor = hexToColor('#5EA9EE');
  static Color delivrdColor = hexToColor('#05BF8F');
  static Color plocColor = hexToColor('#8F0CF5');
  static Color timeBoxColor = hexToColor('#FFECD6');
  static Color bdrColor2 = hexToColor('#FFC27B');
  static Color areaColor = hexToColor('#F8F9FC');
  static Color borderColor3 = hexToColor('#EBEBEC');

//-------------------------------------------------------------------------------------------------

  static final themeData = ThemeData(
    useMaterial3: true,
    applyElevationOverlayColor: false,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    dialogBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: 'Manrope Regular',
        fontSize: 12,
      ),

      labelStyle: TextStyle(
        color: hexToColor('#FF0000'),
      ),
      errorStyle: TextStyle(
        color: hexToColor('#e74c3c').withOpacity(.5),
      ),
      // contentPadding: EdgeInsets.symmetric(vertical: 12),
      // border: OutlineInputBorder(
      //   // borderSide: BorderSide.none,
      //   borderRadius: BorderRadius.circular(
      //     10,
      //   ),
      // ),

      enabledBorder: UnderlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: AppTheme.primaryColor, width: .8)),
      focusedBorder: UnderlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: AppTheme.primaryColor, width: .8)),
      errorBorder: UnderlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: Colors.red, width: .8)),
      focusedErrorBorder: UnderlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: AppTheme.primaryColor, width: .8)),
      // fillColor: hexToColor('#F2F7FB'),
      // filled: true,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppTheme.appbarColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: textColor,
      ),
      headline2: TextStyle(color: textColor),
      headline3: TextStyle(color: textColor),
      headline4: TextStyle(color: textColor),
      headline5: TextStyle(color: textColor),
      subtitle1: TextStyle(color: textColor),
      subtitle2: TextStyle(color: textColor),
      button: TextStyle(color: textColor),
    ),
    iconTheme: IconThemeData(color: Colors.black54),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
      },
    ),
    fontFamily: 'Cera Regular',
    primaryTextTheme: TextTheme(
      headline2: TextStyle(color: Colors.black54),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black54,
      selectionColor: Colors.black54,
      selectionHandleColor: Colors.black54,
    ),
  );
}
