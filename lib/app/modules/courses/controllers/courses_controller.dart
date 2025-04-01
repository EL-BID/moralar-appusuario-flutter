import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/courses_provider.dart';

class CoursesController extends GetxController {
  final _coursesProvider = Get.find<CoursesProvider>();
  final isLoading = false.obs;

  //Classes
  final courses = <Course>[].obs;

  Future<void> getCourses() async {
    isLoading.value = true;
    try {
      courses.value = await _coursesProvider.getCourses();
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

  @override
  void onInit() {
    super.onInit();
    getCourses();
  }

  @override
  void onClose() {}
}
