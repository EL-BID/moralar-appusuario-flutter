import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/properties_provider.dart';
import '../../properties/controllers/properties_controller.dart';
import '../../timeline/controllers/timeline_controller.dart';

class PropertyDetailsController extends GetxController {
  final _propertiesProvider = Get.find<PropertiesProvider>();
  final _propertiesController = Get.find<PropertiesController>();

  final isLoading = false.obs;
  final countInterestingFamilyInTheProperty = 0.obs;

  //classes
  final Property property = Get.arguments;
  final FamilyHolder user =
      FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson());

  String getProjectPath(String project) {
    if (project == 'null') {
      // ignore: parameter_assignments
      project = 'default.png';
    }
    if (project.contains("http")) {
      return project;
    } else {
      return '${MoralarWidgets.instance.baseUrlAssets}/$project';
    }
  }

  Future<bool> confirmInterest() async {
    isLoading.value = true;
    try {
      final response = await _propertiesProvider.confirmInterest(
        user.id!,
        property.id,
      );
      if (response) {
        isLoading.value = false;
        getProperties();
        return response;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
    isLoading.value = false;
    return false;
  }

  Future<int> getCountInterestingFamilyInTheProperty() async {
    int actualCount = await this
        ._propertiesProvider
        .getCountInterestingFamilyInTheProperty(user.id.toString());
    if (actualCount == 0) {
      return 1;
    } else {
      return actualCount > 3 ? 3 : actualCount;
    }
  }

  Future<bool> refuseInterest() async {
    isLoading.value = true;
    try {
      final response = await _propertiesProvider.refuseInterest(
        user.id!,
        property.id,
      );
      if (response) {
        isLoading.value = false;
        getProperties();
        return response;
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
    isLoading.value = false;
    return false;
  }

  Future<void> getProperties() async {
    _propertiesController.getProperties();
    _propertiesController.getMatchs();
  }

  Future<void> moveForInterestPage() async {
    _propertiesController.pageController.jumpToPage(1);
  }

  @override
  void onClose() {}
}
