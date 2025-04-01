import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class NotificationProvider extends RemoteProvider {
  Future<List<MoralarNotification>> getNotifications(
      int page, bool archived) async {
    try {
      final endpoint = Urls.family.notifications + "/$page?archived=$archived";
      final response = await get(endpoint);
      await get(endpoint + "&setRead=true");
      return (response.data as List)
          .map((item) => MoralarNotification.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<int> getCountNotReadNotifications() async {
    try {
      final endpoint = "${Urls.family.notificationsCount}?archived=false";
      final response = await get("$endpoint&onlyNews=true");
      return response.data as int;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> readNotification(String notificationId) async {
    try {
      await post(
        '${Urls.family.readNotification}/$notificationId',
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<void> registerUnRegisterDeviceId(
      String deviceId, bool isRegister) async {
    print("TSTSTSTSTTS::::${deviceId}");
    try {
      await post(Urls.family.registerUnRegisterDeviceId, body: {
        'deviceId': deviceId,
        'isRegister': isRegister,
      });
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
