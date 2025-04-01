import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/videos_controller.dart';

class VideosView extends GetView<VideosController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Vídeos Educativos',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 256),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.videos.isNotEmpty,
                    child: Column(
                      children:
                          List.generate(controller.videos.length, (index) {
                        return VideoCard(
                          function: () {
                            Get.toNamed(
                              Routes.WATCH_VIDEO,
                              arguments: controller.videos[index],
                            );
                          },
                          video: controller.videos[index],
                        );
                      }),
                    ),
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(vertical: 256),
                      child: Text(
                        'Nenhum vídeo encontrado',
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
