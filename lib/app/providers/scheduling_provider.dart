import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class SchedulingProvider extends RemoteProvider {
  Future<List<ScheduleDetails>> getScheduling(String id) async {
    try {
      final endpoint = Urls.family.scheduling;
      final response = await get('$endpoint/$id');
      return (response.data as List)
          .map((item) => ScheduleDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<ScheduleDetails>> getTimeLine(String id) async {
    try {
      final endpoint = Urls.family.schedulingTimeLine;
      final response = await get('$endpoint/$id');
      print("STATUS: " + response.data.toString());
      return (response.data as List)
          .map((item) => ScheduleDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<ScheduleDetails>> getSchedulingHistory(String id) async {
    try {
      final endpoint = Urls.family.schedulingHistory;
      final response = await get('$endpoint/$id');
      print("STATUS: " + response.data.toString());
      return (response.data as List)
          .map((item) => ScheduleDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<ScheduleDetails> getSchedulingDetails(String id) async {
    try {
      final endpoint = Urls.family.schedulingDetails;
      final response = await get('$endpoint/$id');
      return ScheduleDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> editStatus(ScheduleDetails schedule) async {
    try {
      await post(Urls.family.changeStatusSchedule, body: schedule.toJson());
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
