import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/course_details_controller.dart';

class CourseDetailsView extends GetView<CourseDetailsController> {
  String getStringGenre(int genre) {
    switch (genre) {
      case 0:
        return "Feminino";
      case 1:
        return "Masculino";
      case 2:
        return "Outro";
      case 3:
        return "Todos";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final String startDate =
        MoralarDate.secondsForDate(controller.course.startDate);
    final String endDate =
        MoralarDate.secondsForDate(controller.course.endDate);
    final int start = controller.course.startTargetAudienceAge;
    final int end = controller.course.endTargetAudienceAge;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 320,
                  child: Image.network(
                    controller.course.img ??
                        '${MoralarWidgets.instance.baseUrlAssets}/default.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 212,
                  left: 4,
                  child: IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.angleLeft,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: Get.back,
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    // spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.course.title,
                    style: textTheme.headlineLarge?.copyWith(
                      color: MoralarColors.kellyGreen,
                    ),
                  ),
                  MegaListTile(
                    title: controller.course.place ?? '',
                    leading: const Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      size: 16,
                      color: MoralarColors.brownGrey,
                    ),
                    style: textTheme.bodyLarge,
                  ),
                  MegaListTile(
                    title: '$startDate - $endDate',
                    leading: const Icon(
                      FontAwesomeIcons.calendar,
                      size: 16,
                      color: MoralarColors.brownGrey,
                    ),
                    style: textTheme.bodyLarge,
                  ),
                  MegaListTile(
                    title: '${controller.course.schedule} hrs',
                    leading: const Icon(
                      FontAwesomeIcons.clock,
                      size: 16,
                      color: MoralarColors.brownGrey,
                    ),
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldNormal(
                    title: 'Carga Horária',
                    body: '${controller.course.workLoad} horas',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(title: 'Público Alvo', body: '$start a $end anos'),
                  controller.course.typeGenre != null
                      ? Column(
                          children: [
                            const SizedBox(height: 24),
                            BoldNormal(
                              title: 'Gênero',
                              body: CourseService.courseGenre(
                                  controller.course.typeGenre!),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Detalhes',
                    body: controller.course.description ?? '',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Quantidade de vagas',
                    body: '${controller.course.numberOfVacancies} vagas',
                  ),
                  const SizedBox(height: 64),
                  Obx(() {
                    return MoralarButton(
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        if (controller.course.isSubscribed) {
                          await controller.refuseInterest();
                        } else {
                          await controller.confirmInterest(textTheme);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.course.isSubscribed
                              ? 'Cancelar Inscrição'
                              : 'Realizar Inscrição',
                          style: textTheme.labelLarge,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
