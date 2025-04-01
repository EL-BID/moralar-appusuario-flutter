import 'package:get/get.dart';

import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../controllers/schedulings_controller.dart';

class SchedulingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulingsController>(
      () => SchedulingsController(),
    );
    Get.lazyPut<RegistrationDataProvider>(
      () => RegistrationDataProvider(),
    );
    Get.lazyPut<SchedulingProvider>(
      () => SchedulingProvider(),
    );
  }
}
