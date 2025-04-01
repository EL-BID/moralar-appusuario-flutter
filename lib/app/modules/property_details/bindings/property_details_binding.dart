import 'package:get/get.dart';

import '../../../providers/properties_provider.dart';
import '../../properties/controllers/properties_controller.dart';
import '../controllers/property_details_controller.dart';

class PropertyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDetailsController>(
      () => PropertyDetailsController(),
    );
    Get.lazyPut<PropertiesController>(
      () => PropertiesController(),
    );
    Get.lazyPut<PropertiesProvider>(
      () => PropertiesProvider(),
    );
  }
}
