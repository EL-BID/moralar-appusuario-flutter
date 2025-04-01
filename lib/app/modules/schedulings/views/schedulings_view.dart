import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/schedulings_controller.dart';

class SchedulingsView extends GetView<SchedulingsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget _content(List<Widget> list, int index) {
      return SingleChildScrollView(
        child: Column(
          children: [
            // MoralarPicker(
            //   types: const ['Próximos', 'Histórico'],
            //   isCurrent: index,
            //   controller: controller.pageController,
            //   horizontalPadding: 24,
            // ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Visibility(
                visible: controller.isLoading.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 256),
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      MoralarColors.darkBlueGrey,
                    ),
                  ),
                ),
                replacement: Visibility(
                  visible: list.isNotEmpty,
                  child: Column(
                    children: list,
                  ),
                  replacement: Container(
                    padding: const EdgeInsets.symmetric(vertical: 256),
                    child: Text(
                      'Nenhum agendamento encontrado',
                      style: textTheme.headlineLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Agendamentos',
      ),
      body: Obx(() {
        return PageView(
          controller: controller.pageController,
          children: [
            _content(
              List.generate(
                controller.nextSchedulings.length,
                (index) => ScheduleCard(
                  scheduleDetails: controller.nextSchedulings[index],
                  function: () {
                    Get.toNamed(
                      Routes.SCHEDULING,
                      arguments: controller.nextSchedulings[index].id,
                    );
                  },
                ),
              ),
              0,
            ),
            _content(
              List.generate(
                controller.historicSchedulings.length,
                (index) => ScheduleCard(
                  scheduleDetails: controller.historicSchedulings[index],
                  function: () {
                    Get.toNamed(
                      Routes.SCHEDULING,
                      arguments: controller.historicSchedulings[index].id,
                    );
                  },
                ),
              ),
              1,
            ),
          ],
        );
      }),
    );
  }
}
