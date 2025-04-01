import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/courses_provider.dart';
import '../../courses/controllers/courses_controller.dart';

class CourseDetailsController extends GetxController {
  final _coursesProvider = Get.find<CoursesProvider>();
  final _coursesController = Get.find<CoursesController>();

  final isLoading = false.obs;
  bool isWaiting = false;

  //Classes
  Course course = Get.arguments;
  final FamilyHolder user =
      FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson());

  Future<void> getCourseDetails() async {
    isLoading.value = true;
    try {
      course = await _coursesProvider.getCourseDetails(course.id);
      isLoading.value = false;
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      course.isSubscribed = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<bool> confirmInterest(TextTheme textTheme) async {
    isLoading.value = true;
    try {
      final response = await _coursesProvider.registerCourse(
        user.id!,
        course.id,
        isWaiting,
      );
      if (response) {
        isLoading.value = false;
        _coursesController.getCourses();
        Get.defaultDialog(
          title: '',
          content: const ConfirmSubscription(
            description:
                'Certifique-se que está inscrito nos cursos que deseja.',
          ),
          confirm: Container(
            padding: const EdgeInsets.all(8),
            child: MoralarButton(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Voltar',
                  style: textTheme.labelLarge,
                ),
              ),
              onPressed: () {
                Get.back();
                Get.back();
              },
            ),
          ),
        );
      } else {
        Get.defaultDialog(
          title: 'Curso está lotado.',
          titleStyle: textTheme.headlineLarge,
          titlePadding: const EdgeInsets.only(top: 24),
          contentPadding: const EdgeInsets.all(24),
          middleText: 'Você deseja entrar na lista de espera?',
          middleTextStyle: textTheme.bodyMedium,
          textConfirm: "Confirmar",
          textCancel: "Cancelar",
          cancelTextColor: MoralarColors.strawberry,
          confirmTextColor: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.veryLightPink,
          buttonColor: MoralarColors.strawberry,
          onConfirm: () async {
            isWaiting = true;
            Get.back();
            confirmInterest(textTheme);
          },
        );
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

  Future<void> refuseInterest() async {
    isLoading.value = true;
    try {
      final response = await _coursesProvider.cancelCourse(
        user.id!,
        course.id,
      );
      if (response) {
        _coursesController.getCourses();
        isLoading.value = false;
        Get.back();
        Get.snackbar(
          'Pronto!',
          'Curso cancelado.',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
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
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getCourseDetails();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
