import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';
import 'package:workforce/src/config/base.dart';
import 'package:workforce/src/controllers/deep_link_controller.dart';
import 'package:workforce/src/helpers/k_text.dart';
import 'package:workforce/src/helpers/route.dart';

class PushNotificationsPage extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            back();
          },
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        elevation: 3,
        title: KText(
          text: 'Notifications',
          fontSize: 19,
          bold: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              notificationsC.notifications.isEmpty
                  ? Center(
                      child: KText(text: 'Notification is empty'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: notificationsC.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = notificationsC.notifications[index];

                        return GestureDetector(
                          onTap: () {
                            Get.put(DeepLinkController()).pushPage(
                                transportOrderNo: item.transportOrderNo!,
                                destPage: item.destPage!);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.notifications_active,
                                          color: AppTheme.textColor),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: KText(
                                          text: '${item.title}',
                                          maxLines: 3,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: .7,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
