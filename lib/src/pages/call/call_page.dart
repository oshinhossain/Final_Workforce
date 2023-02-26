import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/components/user_avatar.dart';
import 'package:workforce/src/helpers/k_text.dart';
import '../../components/left_sidebar_component.dart';
import '../../components/right_sidebar_component.dart';
import '../../config/base.dart';

import '../../helpers/hex_color.dart';
import '../../helpers/render_img.dart';
import '../../helpers/route.dart';

class CallPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage>
    with SingleTickerProviderStateMixin, Base {
  TabController? _tabController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //socketS.initializeSocket();
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging) {
        setState(() {
          _activeIndex = _tabController!.index;
        });
      }
    });

    return Scaffold(
      drawer: LeftSidebarComponent(),
      endDrawer: RightSidebarComponent(),
      appBar: KAppbar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: hexToColor('#9BA9B3'),
              )),
          title: KText(
            text: 'Call',
            fontSize: 16,
            color: hexToColor('#41525A'),
            bold: true,
          ),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Material(
              color: hexToColor('#EEF0F6'),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(
                    left: 29.0, top: 14.75, right: 29.0, bottom: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  child: _tabBar,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            LatestActivityPage(),
            ContactsPage(),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        labelStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.0,
            color: Colors.amber,
            fontWeight: FontWeight.w700),
        labelPadding: EdgeInsets.all(0),
        indicator: BoxDecoration(
          borderRadius: _activeIndex == 0
              ? BorderRadius.only(topLeft: Radius.circular(5.0))
              : _activeIndex == 1
                  ? BorderRadius.only(topRight: Radius.circular(5.0))
                  : _activeIndex == 1
                      ? BorderRadius.only(topRight: Radius.circular(5.0))
                      : null,
          color: Colors.white,
        ),
        indicatorWeight: 1,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: hexToColor('#41525A'),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Manrope', fontSize: 14.0, fontWeight: FontWeight.w400),
        isScrollable: false,
        physics: BouncingScrollPhysics(),
        tabs: [
          Tab(text: 'Latest Activity'),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      left:
                          BorderSide(width: 1, color: hexToColor('#EEF0F6')))),
              child: Tab(text: 'Contacts')),
        ],
      );
}

class LatestActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      physics: BouncingScrollPhysics(),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, index) {
          //   return index % 3 == 0 && index != 0
          //       ? Padding(
          //           padding: EdgeInsets.all(15.0),
          //           child: KText(
          //             text: 'September ${index + 2}, 2021',
          //             fontSize: 13,
          //             bold: true,
          //           ),
          //         )
          //       :
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: ListTile(
                title: KText(text: 'Name', bold: true, fontSize: 15),
                subtitle: KText(text: '07:14PM'),
                contentPadding: EdgeInsets.only(right: 10),
                leading: UserAvatar(),
                trailing:
                    // index % 2 == 0
                    //     ? Icon(Icons.video_call, color: Colors.grey)
                    //     :Icon(Icons.call, color: Colors.red),
                    IconButton(
                        onPressed: () {
                          push(CallingPage());
                        },
                        icon: Icon(Icons.call),
                        color: Colors.red)),
          );
        },
        childCount: 12,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
    );
  }
}

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'angel',
      'bubbles',
      'shimmer',
      'angelic',
      'bubbly',
      'glimmer',
      'baby',
      'pink',
      'little',
      'butterfly',
      'sparkly',
      'doll',
      'sweet',
      'sparkles',
      'dolly',
      'sweetie',
      'sprinkles',
      'lolly',
      'princess',
      'fairy',
      'honey',
      'snowflake',
      'pretty',
      'sugar',
      'cherub',
      'lovely',
      'blossom',
      'Ecophobia',
      'Hippophobia',
      'Scolionophobia',
      'Ergophobia',
      'Musophobia',
      'Zemmiphobia',
      'Geliophobia',
      'Tachophobia',
      'Hadephobia',
      'Radiophobia',
      'Turbo Slayer',
      'Cryptic Hatter',
      'Crash TV',
      'Blue Defender',
      'Toxic Headshot',
      'Iron Merc',
      'Steel Titan',
      'Stealthed Defender',
      'Blaze Assault',
      'Venom Fate',
      'Dark Carnage',
      'Fatal Destiny',
      'Ultimate Beast',
      'Masked Titan',
      'Frozen Gunner',
      'Bandalls',
      'Wattlexp',
      'Sweetiele',
      'HyperYauFarer',
      'Editussion',
      'Experthead',
      'Flamesbria',
      'HeroAnhart',
      'Liveltekah',
      'Linguss',
      'Interestec',
      'FuzzySpuffy',
      'Monsterup',
      'MilkA1Baby',
      'LovesBoost',
      'Edgymnerch',
      'Ortspoon',
      'Oranolio',
      'OneMama',
      'Dravenfact',
      'Reallychel',
      'Reakefit',
      'Popularkiya',
      'Breacche',
      'Blikimore',
      'StoneWellForever',
      'Simmson',
      'BrightHulk',
      'Bootecia',
      'Spuffyffet',
      'Rozalthiric',
      'Bookman'
    ];
//   int selectedIndex = 0;
    return Column(
      children: [
        Expanded(
          child: AlphabetScrollView(
            list: list.map((e) => AlphaModel(e)).toList(),
            // isAlphabetsFiltered: false,
            alignment: LetterAlignment.right,
            itemExtent: 60,
            unselectedTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black),
            selectedTextStyle: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            overlayWidget: (value) => Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 80,
                  color: Colors.red,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Theme.of(context).primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    value.toUpperCase(),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            itemBuilder: (_, k, id) {
              return Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Slidable(
                    key: const ValueKey(1),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {
                        push(CallingPage());
                      }),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: doNothing,
                          backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Archive',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            push(CallingPage());
                          },
                          backgroundColor: Color(0xFF0392CF),
                          foregroundColor: Colors.white,
                          icon: Icons.call,
                          label: 'Call',
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: ListTile(
                        title: KText(text: id, bold: true, fontSize: 15),
                        subtitle: Text('07:14 PM'),
                        contentPadding: EdgeInsets.only(right: 20),
                        leading: UserAvatar(),
                      ),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}

void doNothing(BuildContext context) {}

class CallingPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: KText(
                text: 'Calling',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: RenderImg(path: 'bill.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: KText(
                text: 'Name',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: KText(
                text: 'Description',
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                IconButton(
                  onPressed: () {
                    push(CallPage());
                  },
                  icon: Icon(Icons.call_end),
                  iconSize: 40,
                  color: Colors.red[400],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    push(VideoPage());
                  },
                  icon: Icon(Icons.call),
                  color: Colors.green,
                  iconSize: 40,
                ),
                SizedBox(
                  width: 70,
                ),
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   height: 120,
      //   width: Get.width,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: callC.bottomMenus
      //         .map(
      //           (item) => GestureDetector(
      //             onTap: () => callC.setCurrentIndex = item,
      //             child: SvgPicture.asset(
      //               '${Constants.svgPath}/$item',
      //               color: callC.getMenuIndex(item) == 2
      //                   ? null
      //                   : menuC.currentIndex.value == menuC.getMenuIndex(item)
      //                       ? AppTheme.color2
      //                       : AppTheme.color6,
      //             ),
      //           ),
      //         )
      //         .toList(),
      //   ),
      // ),
    );
  }
}

class CallReceivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: KText(
                text: 'Calling',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: RenderImg(path: 'bill.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: KText(
                text: 'Name',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: KText(
                text: 'Description',
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 70,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call_end),
                  iconSize: 40,
                  color: Colors.red[400],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.call),
                  iconSize: 40,
                ),
                SizedBox(
                  width: 70,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              height: 500,
              width: Get.width,
              color: Colors.grey[200],
            ),
            // Center(
            //   child: KText(
            //     text: 'Calling',
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            // Center(
            //   child: Container(
            //     height: 200,
            //     width: 200,
            //     decoration: BoxDecoration(
            //       color: Colors.green[50],
            //       borderRadius: BorderRadius.circular(100),
            //     ),
            //     child: Center(
            //       child: Container(
            //         height: 170,
            //         width: 170,
            //         decoration: BoxDecoration(
            //           color: Colors.green[100],
            //           borderRadius: BorderRadius.circular(100),
            //         ),
            //         child: Center(
            //           child: Container(
            //             height: 140,
            //             width: 140,
            //             decoration: BoxDecoration(
            //               color: Colors.green[200],
            //               borderRadius: BorderRadius.circular(100),
            //             ),
            //             child: Padding(
            //               padding: EdgeInsets.all(15.0),
            //               child: RenderImg(path: 'bill.jpg'),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            // Center(
            //   child: KText(
            //     text: 'Name',
            //     fontSize: 20,
            //   ),
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //   child: KText(
            //     text: 'Description',
            //     fontSize: 15,
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 70,
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(Icons.call_end),
            //       iconSize: 40,
            //       color: Colors.red[400],
            //     ),
            //     Spacer(),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(Icons.call),
            //       iconSize: 40,
            //     ),
            //     SizedBox(
            //       width: 70,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
