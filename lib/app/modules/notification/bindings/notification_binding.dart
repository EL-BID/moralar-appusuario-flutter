import 'package:get/get.dart';

import '../../../providers/notification_provider.dart';
import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';
import '../../timeline/controllers/timeline_controller.dart';
import '../controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      NotificationController.new,
    );
    Get.lazyPut<TimelineController>(
      TimelineController.new,
    );
    Get.lazyPut<NotificationProvider>(
      NotificationProvider.new,
    );
    Get.lazyPut<RegistrationDataProvider>(
      RegistrationDataProvider.new,
    );
    Get.lazyPut<SchedulingProvider>(
      SchedulingProvider.new,
    );
  }
}
