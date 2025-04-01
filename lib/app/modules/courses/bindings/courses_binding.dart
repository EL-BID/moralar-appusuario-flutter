import 'package:get/get.dart';

import '../../../providers/courses_provider.dart';
import '../controllers/courses_controller.dart';

class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesController>(
      () => CoursesController(),
    );
    Get.lazyPut<CoursesProvider>(
      () => CoursesProvider(),
    );
  }
}
