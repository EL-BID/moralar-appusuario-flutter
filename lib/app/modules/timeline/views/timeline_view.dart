import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const kellyGreen = Color(0xFF06b12e);
    const orangeYellow = Color(0xFFffaa00);

    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Status de Reassentamento',
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars, color: Colors.black),
          onPressed: () => Get.toNamed(Routes.MENU),
        ),
        actions: [
          Stack(
            children: [
              Obx(() {
                return Visibility(
                  visible: controller.numberNotifications.value > 0,
                  child: Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
              IconButton(
                icon: Stack(
                  children: <Widget>[
                    const Icon(FontAwesomeIcons.solidBell, color: Colors.black),
                    Positioned(
                      right: 0,
                      left: 11,
                      top: 1,
                      child: Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color:
                                controller.numberNotReadNotifications.value > 0
                                    ? Colors.red
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Text(
                            '${controller.numberNotReadNotifications.value}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                    )
                  ],
                ),
                onPressed: () {
                  controller.numberNotifications.value = 0;
                  controller.numberNotReadNotifications.value = 0;
                  Get.toNamed(
                    Routes.NOTIFICATION,
                    arguments: controller.notifications,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: textTheme.displayMedium,
                  ),
                  InkWell(
                    onTap: () {
                      controller.getTimeline();
                    },
                    splashColor: Colors.transparent,
                    child: const Icon(
                      Icons.refresh,
                      color: MoralarColors.darkBlueGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(24),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.schedulings.isNotEmpty,
                    child: Column(
                      children:
                          List.generate(controller.schedulings.length, (index) {
                        return StatusResettlement(
                          schedule: controller.schedulings[index],
                          isFirst: index == 0,
                        );
                      }),
                    ),
                    replacement: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Nenhum agendamento encontrado',
                        style: textTheme.headlineMedium,
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 32),
              Text(
                'Atividade Facultativa',
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ActivityCard(
                      function: () => Get.toNamed(Routes.COURSES),
                      icon: MoralarImage.asset(Assets.images.cursos),
                      title: 'Cursos',
                      color: kellyGreen,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ActivityCard(
                      function: () => Get.toNamed(
                        Routes.QUIZZES,
                        arguments: false,
                      ),
                      icon: MoralarImage.asset(Assets.images.enquetes),
                      title: 'Enquetes',
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Expanded(
                  //   child: ActivityCard(
                  //     icon: MoralarImage.asset(Assets.images.jogos),
                  //     title: 'Jogos Educativos (Em breve)',
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  Expanded(
                    child: ActivityCard(
                      function: () => Get.toNamed(Routes.VIDEOS),
                      icon: MoralarImage.asset(Assets.images.videos),
                      title: 'Vídeos Educativos',
                      color: orangeYellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
