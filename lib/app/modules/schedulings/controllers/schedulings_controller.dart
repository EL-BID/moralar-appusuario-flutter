import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/registration_data_provider.dart';
import '../../../providers/scheduling_provider.dart';

class SchedulingsController extends GetxController {
  final _registrationDataProvider = Get.find<RegistrationDataProvider>();
  final _schedulingProvider = Get.find<SchedulingProvider>();
  final PageController pageController = PageController();
  final isLoading = false.obs;

  //Classes
  FamilyUser familyUser = FamilyUser(
    holder:
        FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson()),
    spouse: Spouse(name: '', birthday: 0),
    members: [FamilyMember(name: '', birthday: 0, kinShip: 0)],
    id: '',
  );
  final nextSchedulings = <ScheduleDetails>[].obs;
  final historicSchedulings = <ScheduleDetails>[].obs;

  Future<void> getInfo() async {
    isLoading.value = true;
    familyUser = await _registrationDataProvider.getInfoFamily();
    await getSchedulings();
    // await getSchedulingsHistory();
    isLoading.value = false;
  }

  Future<void> getSchedulings() async {
    isLoading.value = true;
    nextSchedulings.value = await _schedulingProvider.getScheduling(familyUser.id);
    isLoading.value = false;
  }

  Future<void> getSchedulingsHistory() async {
    isLoading.value = true;
    historicSchedulings.value = await _schedulingProvider.getSchedulingHistory(familyUser.id);
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getInfo();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
