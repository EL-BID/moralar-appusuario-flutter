import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/scheduling_controller.dart';

class SchedulingView extends GetView<SchedulingController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget _openSheduling(ScheduleDetails schedule) {
      return Column(
        children: [
          Container(
            height: 128,
            width: 128,
            child: MoralarImage.asset(Assets.images.agendamento),
          ),
          const SizedBox(height: 64),
          ScheduleCard(scheduleDetails: schedule, function: () {}),
          // const MoralarCard(isQuiz: false),
          const SizedBox(height: 32),
          Visibility(
            visible: schedule.typeScheduleStatus! <= 2 ||
                schedule.typeScheduleStatus! == 0,
            child: Text('Reagendamento',
                style: textTheme.displayMedium?.copyWith(fontSize: 24)),
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: schedule.typeScheduleStatus! == 0 ||
                schedule.typeScheduleStatus! == 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: MoralarButton(
                color: MoralarColors.kellyGreen,
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Agendamento',
                    titleStyle: textTheme.headlineLarge,
                    titlePadding: const EdgeInsets.only(top: 24),
                    contentPadding: const EdgeInsets.all(24),
                    middleText: 'Deseja confirmar o agendamento?',
                    middleTextStyle: textTheme.bodyMedium,
                    textConfirm: "Confirmar",
                    textCancel: "Cancelar",
                    cancelTextColor: MoralarColors.strawberry,
                    confirmTextColor: MoralarColors.veryLightPink,
                    backgroundColor: MoralarColors.veryLightPink,
                    buttonColor: MoralarColors.strawberry,
                    onConfirm: () async {
                      Get.back();
                      await controller.changeStatus(status: 1);
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Confirmar agendamento',
                    style: textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: schedule.typeScheduleStatus! < 3,
            child: MoralarButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Você tem certeza?',
                  titleStyle: textTheme.headlineLarge,
                  titlePadding: const EdgeInsets.only(top: 24),
                  contentPadding: const EdgeInsets.all(24),
                  middleText: 'Sua reunião será reagendada',
                  middleTextStyle: textTheme.bodyMedium,
                  textConfirm: "Confirmar",
                  textCancel: "Cancelar",
                  cancelTextColor: MoralarColors.strawberry,
                  confirmTextColor: MoralarColors.veryLightPink,
                  backgroundColor: MoralarColors.veryLightPink,
                  buttonColor: MoralarColors.strawberry,
                  onConfirm: () async {
                    Get.back();
                    await controller.changeStatus(status: 3);
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Solicitar Reagendamento',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
          )
        ],
      );
    }

    Widget _finalizedSheduling() {
      return FinalizedCard(schedule: controller.scheduling.value);
    }

    return Obx(() => MoralarScaffold(
          appBar: MoralarAppBar(
            titleText: 'Agendamento',
            backgroundColor: Scheduling.statusColor(
                controller.scheduling.value.typeScheduleStatus!),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
              child: Visibility(
                visible: controller.isLoading.value,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 256),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Scheduling.statusColor(
                          controller.scheduling.value.typeScheduleStatus!),
                    ),
                  ),
                ),
                replacement:
                    controller.scheduling.value.typeScheduleStatus! == 4
                        ? _finalizedSheduling()
                        : _openSheduling(controller.scheduling.value),
              ),
            ),
          ),
        ));
  }
}
