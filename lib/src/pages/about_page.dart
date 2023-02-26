import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/constants.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

class AboutUs extends StatefulWidget {
  final String? title;

  AboutUs({this.title});

  @override
  // ignore: library_private_types_in_public_api
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final pageDecoration = PageDecoration(
    titleTextStyle:
        PageDecoration().titleTextStyle.copyWith(color: Colors.black),
    bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(color: Colors.black),
    // descriptionPadding:   EdgeInsets.all(10.0),
  );

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: SafeArea(
          child: Image.asset(
            '${Constants.imgPath}/cts_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        title: 'CTrends Software & Services Limited',
        body:
            'We bring innovation to your business and innovation leads to success',
        footer: Card(
          color: hexToColor('#BAC2CE'),
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Plot - 76 (4th Floor), Block - B, Road – 4, Niketan, Gulshan – 1, Dhaka – 1212, Bangladesh'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Email: office@ctrends-software.com'),
                SizedBox(height: 5),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Phone: +880 2 9882801'),
              ],
            ),
          ),
        ),
      ),
      PageViewModel(
        image: SafeArea(
          child: Image.asset('${Constants.imgPath}/our_services.jpg',
              fit: BoxFit.contain),
        ),
        title: 'Our Products',
        body:
            'We develop products that can be configured by our clients or consultants to meet client business need',
        footer: Card(
          color: hexToColor('#BAC2CE'),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Human Resource Management'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Supply Chain Management'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Financial Management'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Sales & Marketing Management (CRM)'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5),
                Text('Production & Quality Management'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('GRC Platform'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('CXO Cockpit'),
                SizedBox(height: 5.0),
                Divider(height: 1, thickness: 1, color: Colors.white),
                SizedBox(height: 5.0),
                Text('Tasks & Activities Management'),
              ],
            ),
          ),
        ),
      ),
      PageViewModel(
        titleWidget: Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text('Credits',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        body:
            'We recognise and express our gratitude to those who participated in the development of this app:',
        footer: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: hexToColor(
                          '#CFE8FF'), //background color of dropdown button
                      border: Border.all(
                          color: hexToColor('#6AB2F5'),
                          width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromARGB(
                                145, 221, 214, 223), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: KText(
                      text: 'App Team',
                      fontSize: 20,
                      bold: true,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/zillur.jpeg',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Zillur Rahman (Uzzal Sharif)'),
                subtitle: Text('Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/Sumaiya.jpg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Sumaiya Mollika'),
                subtitle: Text('Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/oshin.jpeg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Noorjahan Hossain'),
                subtitle: Text('Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/icon_avatar.png',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Hm Habibur Rahman'),
                subtitle: Text('Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/nahid.png',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Shahoriar Nahid'),
                subtitle: Text('Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/hridoyphoto.jpg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Abdul Kader (Hridoy)'),
                subtitle: Text('Programmer'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: hexToColor(
                          '#CFE8FF'), //background color of dropdown button
                      border: Border.all(
                          color: hexToColor('#6AB2F5'),
                          width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromARGB(
                                145, 221, 214, 223), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: KText(
                      text: 'Backend Team',
                      fontSize: 20,
                      bold: true,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/tusar1.jpeg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md Mehedi Hasan Tusar'),
                subtitle: Text('Java Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/alamin.jpeg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Al Amin Arif'),
                subtitle: Text('Java Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/aslam.jpg',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Sultan Md Aslam'),
                subtitle: Text('Java Programmer'),
              ),
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/p_day.jpg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Prince Dey'),
                subtitle: Text('Java Programmer'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: hexToColor(
                          '#CFE8FF'), //background color of dropdown button
                      border: Border.all(
                          color: hexToColor('#6AB2F5'),
                          width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromARGB(
                                145, 221, 214, 223), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: KText(
                      text: 'UI/UX Team',
                      fontSize: 20,
                      bold: true,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/icon_avatar.png',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Shumon Iqbal'),
                subtitle: Text('UX/UI Designer'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/icon_avatar.png',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Arafat Kabir'),
                subtitle: Text('UX/UI Designer'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: hexToColor(
                          '#CFE8FF'), //background color of dropdown button
                      border: Border.all(
                          color: hexToColor('#6AB2F5'),
                          width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromARGB(
                                145, 221, 214, 223), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: KText(
                      text: 'SQA Team',
                      fontSize: 20,
                      bold: true,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/abky.jpeg',
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Abdullah Al Baky'),
                subtitle: Text('Software Quality Assurance Engnieer'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      color: hexToColor(
                          '#CFE8FF'), //background color of dropdown button
                      border: Border.all(
                          color: hexToColor('#6AB2F5'),
                          width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(
                          50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromARGB(
                                145, 221, 214, 223), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: KText(
                      text: 'DevOps Team',
                      fontSize: 20,
                      bold: true,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: hexToColor('#6AB2F5'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5.0,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: AppTheme.primaryColor,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      // child: Image.asset(
                      //   'assets/images/ruhul_amin.jpeg',
                      //   fit: BoxFit.cover,
                      //   height: 40.0,
                      //   width: 40.0,
                      // ),
                      child: Image.asset(
                        '${Constants.imgPath}/icon_avatar.png',
                        fit: BoxFit.contain,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                ),
                title: Text('Md. Mahadi Hassan (Shohag)'),
                subtitle: Text('DevOps Engnieer'),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        pages: getPages(),
        next: Icon(Icons.arrow_forward),
        done: Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        //done:   Text('Done', style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)),
        onDone: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
}
