import 'package:get/get.dart';

import '../../../providers/properties_provider.dart';
import '../controllers/properties_controller.dart';

class PropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertiesController>(
      () => PropertiesController(),
    );
    Get.lazyPut<PropertiesProvider>(
      () => PropertiesProvider(),
    );
  }
}
