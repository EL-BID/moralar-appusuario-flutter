import 'package:get/get.dart';

import '../../../providers/registration_data_provider.dart';
import '../controllers/registration_data_controller.dart';

class RegistrationDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationDataController>(
      () => RegistrationDataController(),
    );
    Get.lazyPut<RegistrationDataProvider>(
      () => RegistrationDataProvider(),
    );
  }
}
