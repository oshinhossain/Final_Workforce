class Biometric {
  final String themeColor;
  final String bgThemePath;
  final String iconPath;
  final String titleText;
  final String subTitleText;

  Biometric({
    required this.themeColor,
    required this.bgThemePath,
    required this.iconPath,
    required this.titleText,
    required this.subTitleText,
  });

  static var biometricCategoryGridItem = [
    Biometric(
      themeColor: '#007F8F',
      iconPath: 'assets/svg/fingerprint.svg',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: 'Internal',
      subTitleText: 'Finger Print',
    ),
    Biometric(
      themeColor: '#43A047',
      iconPath: 'assets/svg/face_recognition.svg',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: 'Face',
      subTitleText: 'Recognition',
    ),
    Biometric(
      themeColor: '#C24343',
      iconPath: 'assets/svg/voice_recognition.svg',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: 'Voice',
      subTitleText: 'Recognition',
    ),
    Biometric(
      themeColor: '#A97E00',
      iconPath: 'assets/svg/retina.svg',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: 'Ratinal ',
      subTitleText: 'Scan',
    ),
    Biometric(
      themeColor: '#004C3F',
      iconPath: 'assets/svg/external_finger_print.svg',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: 'External',
      subTitleText: 'Finger Print',
    ),
    Biometric(
      themeColor: '#78909C',
      iconPath: 'assets/svg/retina.svg',
      // iconPath: '',
      bgThemePath: 'assets/svg/card_bg_transparent.svg',
      titleText: '',
      subTitleText: '',
    ),
  ];
}
