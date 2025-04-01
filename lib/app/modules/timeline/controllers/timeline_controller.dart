import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/notification_provider.dart';
import '../../../providers/scheduling_provider.dart';

class TimelineController extends GetxController {
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final _notificationProvider = Get.find<NotificationProvider>();
  final isLoading = false.obs;
  final numberNotifications = 0.obs;
  final numberNotReadNotifications = 0.obs;

  //Classes
  final user = MegaFlutter.instance.auth.currentUser as FamilyHolder;
  final schedulings = <ScheduleDetails>[].obs;
  final notifications = <MoralarNotification>[].obs;

  int page = 0;

  Future<void> getTimeline() async {
    isLoading.value = true;
    try {
      isLoading.value = false;
      schedulings.value = await _schedulingProvider.getTimeLine(user.id!);
    } on MegaResponseException catch (e) {
      schedulings.value = [];
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
    await getNotifications(false);
  }

  Future<void> getNotifications(bool archived) async {
    try {
      notifications.value =
          await _notificationProvider.getNotifications(page, archived);
      page++;
      numberNotifications.value = 0;
      for (final notification in notifications) {
        if (notification.dateViewed == null) {
          numberNotifications.value++;
        }
      }
    } on MegaResponseException catch (e) {
      notifications.value = [];
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }

    await registerDeviceId();
  }

  Future<void> registerDeviceId() async {
    final storage = GetStorage();
    debugPrint('${storage.read('deviceId')}');
    if (storage.read('deviceId') != null) {
      try {
        await _notificationProvider.registerUnRegisterDeviceId(
          storage.read('deviceId'),
          true,
        );
        isLoading.value = false;
      } on MegaResponseException catch (e) {
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
  }

  Future<void> unregisterDeviceId() async {
    final storage = GetStorage();
    debugPrint('${storage.read('deviceId')}');
    if (storage.read('deviceId') != null) {
      try {
        await _notificationProvider.registerUnRegisterDeviceId(
          storage.read('deviceId'),
          false,
        );
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
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    getTimeline();
    await getCountNotReadNotifications();
  }

  Future<void> getCountNotReadNotifications() async {
    numberNotReadNotifications.value =
        await _notificationProvider.getCountNotReadNotifications();
  }

  @override
  void onClose() {}
}
