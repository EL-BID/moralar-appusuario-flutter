import 'package:get/get.dart';

import '../../../providers/videos_provider.dart';
import '../controllers/videos_controller.dart';

class VideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideosController>(
      () => VideosController(),
    );
    Get.lazyPut<VideosProvider>(
      () => VideosProvider(),
    );
  }
}
