import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/notification_controller.dart';

class FiledView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: const MoralarAppBar(titleText: 'Arquivadas'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Obx(() {
          if (controller.notificationsArchived.length == 0) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 20),
              child: const Text("Não há notificações no momento"),
            );
          }
          return Container(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
                itemCount: controller.notificationsArchived.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == controller.notificationsArchived.length) {
                    controller.getNotifications(true);
                  }
                  return Obx(() {
                    return Column(
                      children: [
                        controller.intDetails.value != index
                            ? NotifcationCard(
                                notification:
                                    controller.notificationsArchived[index],
                                function: () {
                                  controller.intDetails.value = index;
                                },
                                isRead: controller.notificationsArchived[index]
                                        .dateViewed !=
                                    null,
                              )
                            : NotificationDetailsCard(
                                notification:
                                    controller.notificationsArchived[index],
                                function: () {
                                  controller.intDetails.value = -1;
                                },
                                isRead: controller.notificationsArchived[index]
                                        .dateViewed !=
                                    null,
                              ),
                        index == controller.notificationsArchived.length
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
