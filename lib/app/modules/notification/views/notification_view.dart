import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_appusuario/app/routes/app_pages.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Notificação',
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.FILED),
            icon: const Icon(FontAwesomeIcons.folder, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          }
          if (controller.notifications.length == 0) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20),
              // ignore: prefer_const_constructors
              child: Text("Não há notificações no momento"),
            );
          }
          return Container(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
                itemCount: controller.notifications.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == controller.notifications.length) {
                    controller.getNotifications(false);
                  }
                  return Obx(() {
                    final MoralarNotification notification =
                        controller.notifications[index];
                    final data = controller
                        .getModuleData(notification.module.toString());
                    return Column(
                      children: [
                        controller.intDetails.value != index
                            ? NotifcationCard(
                                notification: notification,
                                function: () {
                                  controller.intDetails.value = index;
                                  controller.onTapNotificationCard(
                                      data?['status'] as int?,
                                      data?['id'] as String);
                                },
                                isRead: notification.dateViewed != null,
                                color: data?['color'] as Color)
                            : NotificationDetailsCard(
                                notification: notification,
                                function: () {
                                  controller.intDetails.value = -1;
                                  controller.onTapNotificationCard(
                                      data?['status'] as int?,
                                      data?['id'] as String);
                                },
                                isRead: notification.dateViewed != null,
                                color: data?['color'] as Color),
                        index == controller.notifications.length
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    );
                  });
                }),
          );
        }),
      ),
    );
  }
}
