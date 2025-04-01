import 'package:get/get.dart';

import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../../schedulings/controllers/schedulings_controller.dart';
import '../controllers/scheduling_controller.dart';

class SchedulingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulingController>(
      SchedulingController.new,
    );
    Get.lazyPut<SchedulingsController>(
      SchedulingsController.new,
    );
    Get.lazyPut<SchedulingProvider>(
      SchedulingProvider.new,
    );
    Get.lazyPut<RegistrationDataProvider>(
      RegistrationDataProvider.new,
    );
  }
}
