import 'package:get/get.dart';

import '../../../providers/courses_provider.dart';
import '../../courses/controllers/courses_controller.dart';
import '../controllers/course_details_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseDetailsController>(
      () => CourseDetailsController(),
    );
    Get.lazyPut<CoursesController>(
      () => CoursesController(),
    );
    Get.lazyPut<CoursesProvider>(
      () => CoursesProvider(),
    );
  }
}
