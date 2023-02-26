import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:workforce/src/components/k_appbar.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/k_text.dart';

import '../config/constants.dart';
import '../helpers/render_svg.dart';
import '../helpers/route.dart';

class SingleConversationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(),

      // appBar: AppBar(
      //   elevation: 0,
      //   iconTheme: IconThemeData(color: Color(0xff434969)),
      //   title: Text(
      //     'Conversation',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Color(0xffEEF0F6),
      // ),
      // endDrawer: Drawer(),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(children: [
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(width: 2, color: Colors.grey.shade400),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                // color: Colors.white,
                height: 82,
                width: Get.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () => back(),
                        child: RenderSvg(path: 'icon_back')),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 68,
                      width: 68,
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5FA),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Color.fromARGB(255, 230, 230, 233),
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffF5F5FA).withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              '${Constants.imgPath}/bill.jpeg',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'Jaman Ali',
                          fontSize: 18,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        KText(
                          text: 'Online last at 8:12am',
                          fontSize: 12,
                        ),
                      ],
                    ),
                    Spacer(),
                    RenderSvg(path: 'icon_chat_call'),
                    SizedBox(
                      width: 15,
                    ),
                    RenderSvg(path: 'icon-dot-menu-top'),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
              Container(
                height: Get.height - 80,
                color: Color(0xffEAEAF3),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  reverse: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(12),
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: index.isEven
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: index.isEven
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              index.isEven
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 228,
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              bottom: 12,
                                              left: 15,
                                              right: 16),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            color: Color(0xff007BEC),
                                          ),
                                          child: Center(
                                            child: KText(
                                              text:
                                                  'Hey, this is Jaman Ali, How is going?',
                                              maxLines: 2,
                                              fontSize: 14,
                                              color: hexToColor(
                                                '#ffffff',
                                              ),
                                            ),
                                          ),
                                        ),
                                        KText(
                                          text:
                                              '04/03/2021 (Thursday) 06:15 PM',
                                          fontSize: 11,
                                          color: hexToColor(
                                            '#80939D',
                                          ),
                                        )
                                      ],
                                    )
                                  : index == 5
                                      ? Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 228,
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      bottom: 12,
                                                      left: 15,
                                                      right: 16),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                    color: Color(0xffFFA133),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      RenderSvg(
                                                        path: 'icon_pdf',
                                                        height: 35.0,
                                                        width: 20.0,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            KText(
                                                              text:
                                                                  'presentation.pdf',
                                                              maxLines: 2,
                                                              fontSize: 14,
                                                              color: hexToColor(
                                                                '#ffffff',
                                                              ),
                                                            ),
                                                            KText(
                                                              text: '21.5 Mb',
                                                              fontSize: 11,
                                                              maxLines: 2,
                                                              color: hexToColor(
                                                                '#ffffff',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                KText(
                                                  text:
                                                      '04/03/2021 (Thursday) 06:15 PM',
                                                  fontSize: 11,
                                                  color: hexToColor(
                                                    '#80939D',
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            SizedBox(
                                              height: 43,
                                              width: 42.50,
                                              // child: SvgPicture.asset(
                                              //   'images/chat/icon_chat_download.svg',
                                              //   height: 20.0,
                                              //   width: 20.0,
                                              //   allowDrawingOutsideViewBox:
                                              //       true,
                                              //   //color: Color(0xff007BEC),
                                              // ),
                                              child: RenderSvg(
                                                path: 'icon_chat_download',
                                                height: 20.0,
                                                width: 20.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 228,
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 12,
                                                  left: 15,
                                                  right: 16),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                color: Color(0xffFFA133),
                                              ),
                                              child: KText(
                                                text:
                                                    'Hey, this is Jaman Ali, How is going?',
                                                maxLines: 2,
                                                fontSize: 14,
                                                color: hexToColor(
                                                  '#ffffff',
                                                ),
                                              ),
                                            ),
                                            KText(
                                              text:
                                                  '04/03/2021 (Thursday) 06:15 PM',
                                              fontSize: 11,
                                              color: hexToColor(
                                                '#80939D',
                                              ),
                                            )
                                          ],
                                        )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ]),
      ),

      bottomSheet: Row(
        children: [
          SizedBox(
            width: Get.width - 70,
            child: Container(
              margin: EdgeInsets.only(
                left: 2,
                right: 2,
                bottom: 8,
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    hintText: 'Message',
                    contentPadding: EdgeInsets.all(5),
                    // prefixIcon: IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.emoji_emotions_outlined,
                    //     color: Color(0xff9BA9B3),
                    //     size: 30,
                    //   ),
                    // ),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(width: .1)),
                    prefixIcon: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      height: 30,
                      width: 30,
                      child: Row(
                        children: [
                          // SvgPicture.asset(
                          //   'images/chat/icon_chat_emoji-smile.svg',
                          //   height: 25.0,
                          //   width: 25.0,
                          //   color: Color(0xff9BA9B3),
                          //   allowDrawingOutsideViewBox: true,
                          //   //color: Color(0xff007BEC),
                          // ),
                          RenderSvg(
                            path: 'icon_chat_emoji-smile',
                            height: 25.0,
                            width: 25.0,
                            color: hexToColor('#9BA9B3'),
                            //allowDrawingOutsideViewBox: true,
                          ),
                        ],
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RenderSvg(
                          path: 'icon_chat_camera',
                          height: 25.0,
                          width: 25.0,
                          color: hexToColor('#9BA9B3'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RenderSvg(
                          path: 'icon_chat_attach',
                          height: 25.0,
                          width: 25.0,
                        ),
                      ],
                    )),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: CircleAvatar(
          //     backgroundColor: Color(0xffFE8E46),
          //     radius: 27,
          //     child: Center(
          //       child: Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: IconButton(
          //           iconSize: 30,
          //           icon: Icon(
          //             Icons.mic_none,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {},
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Padding(
            padding: EdgeInsets.only(
              left: 3,
            ),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Color(0xffFE8E46),
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.mic_none_sharp,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              // child: IconButton(
              //   iconSize: 31,
              //   icon: RenderSvg(
              //     path: 'icon_chat_voice',
              //     color: Colors.white,
              //     height: 25.0,
              //     width: 25.0,
              //   ),
              //   onPressed: () {},
              // ),
              // child: Image.asset(
              //   '${Constants.imgPath}/voice_icon.jpeg',
              //   width: 20,
              //   height: 20,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
