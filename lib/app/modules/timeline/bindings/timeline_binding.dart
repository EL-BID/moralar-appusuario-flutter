import 'package:get/get.dart';

import '../../../providers/notification_provider.dart';
import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../controllers/timeline_controller.dart';

class TimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<RegistrationDataProvider>(
      () => RegistrationDataProvider(),
    );
    Get.lazyPut<SchedulingProvider>(
      () => SchedulingProvider(),
    );
    Get.lazyPut<NotificationProvider>(
      () => NotificationProvider(),
    );
  }
}
