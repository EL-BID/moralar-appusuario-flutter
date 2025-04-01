import 'package:get/get.dart';
import 'package:moralar_appusuario/app/providers/hive_provider.dart';

import '../../../providers/quiz_provider.dart';
import '../controllers/quizzes_controller.dart';

class QuizzesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizzesController>(
      () => QuizzesController(),
    );
    Get.lazyPut<QuizProvider>(
      () => QuizProvider(),
    );
    Get.lazyPut<HiveProvider>(
          () => HiveProvider(),
    );
  }
}
