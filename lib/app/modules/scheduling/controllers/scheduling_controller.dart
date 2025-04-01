import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/scheduling_provider.dart';
import '../../schedulings/controllers/schedulings_controller.dart';

class SchedulingController extends GetxController {
  final String id = Get.arguments;
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final _schedulingsController = Get.find<SchedulingsController>();
  final isLoading = true.obs;

  //Classes
  final scheduling = ScheduleDetails(
    familyId: '',
    id: '',
    typeScheduleStatus: 4,
  ).obs;

  Future<void> getSchedulings() async {
    scheduling.value = await _schedulingProvider.getSchedulingDetails(id);
    debugPrint('${scheduling.value.toJson()}');
    isLoading.value = false;
  }

  Future<void> changeStatus({int status = 2}) async {
    isLoading.value = true;
    try {
      scheduling.value.typeScheduleStatus = status;
      final response = await _schedulingProvider.editStatus(scheduling.value);
      if (response) {
        await _schedulingsController.getSchedulings();
        Get.back();
        isLoading.value = false;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
      );
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSchedulings();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
