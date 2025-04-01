import 'package:get/get.dart';

import '../../../providers/informative_provider.dart';
import '../controllers/informative_controller.dart';

class InformativeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformativeController>(
      () => InformativeController(),
    );
    Get.lazyPut<InformativeProvider>(
      () => InformativeProvider(),
    );
  }
}
