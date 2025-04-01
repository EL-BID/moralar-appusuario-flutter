import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/watch_video_controller.dart';

class WatchVideoView extends GetView<WatchVideoController> {
  @override
  Widget build(BuildContext context) {
    Widget _content() {
      return Container(
        alignment: Alignment.center,
        child: YoutubePlayer(
          controller: controller.youtubeController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Theme.of(context).primaryColor,
        ),
      );
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: _content(),
          );
        } else {
          return MoralarScaffold(
            appBar: const MoralarAppBar(
              titleText: 'Vídeo Educativo',
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: _content(),
          );
        }
      },
    );
  }
}
