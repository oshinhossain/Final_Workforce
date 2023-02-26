import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/helpers/hex_color.dart';
import 'package:workforce/src/helpers/render_svg.dart';

import '../config/constants.dart';
import '../models/conversationModel.dart';
import 'single_conversation_page.dart';

// floatingActionButton: ClipRRect(
//     borderRadius: BorderRadius.circular(50),
//     child: FloatingActionButton(
//       onPressed: () {},
//       child: RenderSvg(
//         path: 'floating-button-Chat-user-add',
//         height: 60.0,
//         width: 60,
//       ),
//     ),
//   ),
class ConversationListPage extends StatelessWidget with Base {
  final conversations = [
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Shumon Iqbal',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'BTRC',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Zillur Rahman',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Shumon Iqbal',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'BTRC',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Zillur Rahman',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
    Conversation(
      '${Constants.imgPath}/bill.jpeg',
      'Pls take a look at the images I sent',
      'Tasnim Kabir',
      '3:10',
      5,
      // Colors.grey,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.grey.shade300),
            ),
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            minLines: 1,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff41525A),
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
                hintText: 'My Conversations',
                contentPadding: EdgeInsets.only(
                  left: 15,
                ),
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
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(width: .1)),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SvgPicture.asset(
                    //   'images/chat/icon_search_user.svg',
                    //   height: 30.0,
                    //   width: 30.0,
                    //   color: Color(0xff9BA9B3),
                    //   allowDrawingOutsideViewBox: true,
                    //   //color: Color(0xff007BEC),
                    // ),
                    RenderSvg(
                      path: 'icon_search_user',
                      height: 20.0,
                      width: 20.0,
                      color: Color(0xff9BA9B3),
                    ),
                    SizedBox(
                      width: 13,
                    )
                  ],
                )),
          ),
        ),
        SizedBox(
          height: Get.height - 50,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: conversations.length,
            itemBuilder: (BuildContext context, int index) {
              final item = conversations[index];
              return InkWell(
                onTap: () {
                  // push(SingleConversationPage());
                  Get.to(SingleConversationPage());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 74,
                      // padding: EdgeInsets.only(
                      //   left: 10,
                      //   top: 10.5,
                      //   bottom: 11.5,
                      //   right: 10,
                      // ),
                      width: Get.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Stack(
                            children: [
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
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
                                        '${item.avatar}',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 55,
                                top: 14,
                                child: Container(
                                  height: 11,
                                  width: 10.75,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFA133),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: Color(0xffF5F5FA),
                                      style: BorderStyle.solid,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 18,
                              // bottom: 21,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    textAlign: TextAlign.right,
                                    '${item.name}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: hexToColor('#515D64')),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  textAlign: TextAlign.right,
                                  '${item.lastMessage}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff515D64),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 18, right: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 1,
                                  ),
                                  child: Text(
                                    '${item.time}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff80939D),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFDBF47),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${item.unseenMessageCount}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      // color: Color(0xffEAEAEA),
                      // height: 2,
                      thickness: 1.5,
                      color: Color(0xffEAEAEA),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
