import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class CoursesProvider extends RemoteProvider {
  Future<List<Course>> getCourses() async {
    try {
      final response = await get(Urls.family.courses);
      return (response.data as List)
          .map((item) => Course.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<Course> getCourseDetails(String id) async {
    try {
      final response = await get('${Urls.family.courseDetails}/$id');
      return Course.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> registerCourse(
      String familyId, String courseId, bool isWaiting) async {
    try {
      await post(
        Urls.family.interestCourse,
        body: {
          'familyId': familyId,
          'courseId': courseId,
          'waitInTheQueue': isWaiting,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      if (e.message == 'Deseja aguardar na fila de espera?') {
        return false;
      } else {
        rethrow;
      }
    }
  }

  Future<bool> cancelCourse(String familyId, String courseId) async {
    try {
      await post(
        Urls.family.desinterestCourse,
        body: {
          'familyId': familyId,
          'courseId': courseId,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
