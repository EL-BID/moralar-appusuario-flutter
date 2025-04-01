import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/notification_provider.dart';
import '../../../routes/app_pages.dart';
import '../../timeline/controllers/timeline_controller.dart';

class NotificationController extends GetxController {
  final _notificationProvider = Get.find<NotificationProvider>();
  final _timelineController = Get.find<TimelineController>();
  final details = <bool>[].obs;
  final isRead = <Rx<bool>>[];
  final notifications = <MoralarNotification>[].obs;
  final notificationsArchived = <MoralarNotification>[].obs;
  final isLoading = false.obs;
  int page = 1;
  int pageArchived = 1;
  RxInt intDetails = 0.obs;

  Map<String, dynamic>? getModuleData(String module) {
    final NotificationStyle nS = new NotificationStyle();
    return nS.getModuleData(module);
  }

  Future<void> getDetails() async {
    int index = 0;

    while (index < notifications.length) {
      details.add(false);
      isRead.add((notifications[index].dateViewed != null).obs);
      index++;
    }
  }

  Future<void> onTapNotificationCard(int? status, String id) async {
    if (status != null) {
      if (status != 5 && id != "") {
        Get.toNamed(
          Routes.SCHEDULING,
          arguments: id,
        );
      } else {
        Get.toNamed(Routes.CONTACTS);
      }
    }
  }

  Future<void> readNotification(int index) async {
    try {
      final response =
          await _notificationProvider.readNotification(notifications[index].id);
      if (response) {
        _timelineController.getNotifications(false);
      }
    } on MegaResponseException catch (e) {
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getNotifications(bool archived) async {
    isLoading.value = true;
    try {
      if (archived) {
        notificationsArchived.value = await _notificationProvider
            .getNotifications(pageArchived, archived);
        pageArchived++;
      } else {
        notifications.value =
            await _notificationProvider.getNotifications(page, archived);
        page++;
      }
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      notifications.value = [];
      notificationsArchived.value = [];
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getDetails();
    intDetails.value = -1;
    getNotifications(false);
    getNotifications(true);
  }
}
