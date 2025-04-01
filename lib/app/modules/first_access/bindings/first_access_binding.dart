import 'package:get/get.dart';

import '../controllers/first_access_controller.dart';

class FirstAccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstAccessController>(
      () => FirstAccessController(),
    );
  }
}
