import 'package:get/get.dart';
import 'package:moralar_appusuario/app/providers/videos_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoController extends GetxController {
  final _videosProvider = Get.find<VideosProvider>();
  final Video video = Get.arguments;
  YoutubePlayerController youtubeController = YoutubePlayerController(
    initialVideoId: "",
  );

  Future<void> registerView({required String id}) async {
    await _videosProvider.registerVideoViewed(videoId: id);
  }

  @override
  void onInit() {
    registerView(id: video.id);
    youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(video.url)!,
    );
    super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
