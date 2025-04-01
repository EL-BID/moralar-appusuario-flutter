import 'package:get/get.dart';

import '../controllers/watch_video_controller.dart';

class WatchVideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchVideoController>(
      () => WatchVideoController(),
    );
  }
}
