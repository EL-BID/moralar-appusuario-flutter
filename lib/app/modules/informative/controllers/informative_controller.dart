import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/informative_provider.dart';
import '../../../routes/app_pages.dart';

class InformativeController extends GetxController {
  final _informativeProvider = Get.find<InformativeProvider>();
  final isLoading = false.obs;
  final checkboxLoading = [false.obs];
  final isChecked = [false.obs];

  final RxInt index = 0.obs;

  //Classes
  final informatives = <Informative>[].obs;

  final Informative? informativeDetail =
      (Get.arguments != null) ? Get.arguments as Informative : null;

  Future<void> getInformatives() async {
    isLoading.value = true;
    try {
      informatives.value = await _informativeProvider.getInformatives();
      await getChecks();
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getChecks() async {
    checkboxLoading.clear();
    isChecked.clear();
    for (Informative informative in informatives) {
      checkboxLoading.add(false.obs);
      if (informative.dateViewed == null) {
        isChecked.add(false.obs);
      } else {
        isChecked.add(true.obs);
      }
    }
  }

  Future<void> changeStatusInformative(int index) async {
    checkboxLoading[index].value = true;
    try {
      final response = await _informativeProvider.changeStatusInformative(
        informatives[index].id,
      );
      if (response) {
        isChecked[index].value = !isChecked[index].value;
      }
      checkboxLoading[index].value = false;
    } on MegaResponseException catch (e) {
      checkboxLoading[index].value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  String shortenDescription(String description, int maxLength) {
    if (description.length <= maxLength) {
      return description;
    }

    List<String> words = description.split(' ');
    String shortened = '';

    for (String word in words) {
      if ((shortened + word).length > maxLength) {
        break;
      }
      shortened += word + ' ';
    }

    return shortened.trim() + '...';
  }

  void goToDetailView(Informative _informative) {
    Get.offNamed(Routes.INFORMATIVE_DETAILS, arguments: _informative);
  }

  final checkbox = <bool>[true, false, true].obs;
  @override
  void onInit() {
    super.onInit();
    getInformatives();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
