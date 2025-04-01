import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/videos_provider.dart';

class VideosController extends GetxController {
  final _videosProvider = Get.find<VideosProvider>();
  final isLoading = false.obs;
  int page = 1;

  //Classes
  final videos = <Video>[].obs;

  Future<void> getVideos({moreVideos = false}) async {
    isLoading.value = !moreVideos;
    try {
      videos.value = await _videosProvider.getVideos(page: page);
      isLoading.value = false;
      page++;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      videos.value = [];
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getVideos();
  }

  @override
  void onClose() {}
}
