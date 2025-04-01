import 'dart:io';

import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_appusuario/app/providers/hive_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';

class QuizzesController extends GetxController {
  final _quizProvider = Get.find<QuizProvider>();
  final _hiveProvider = Get.find<HiveProvider>();
  final isLoading = false.obs;
  final bool typeQuiz = Get.arguments;

  //Classes
  final quizzes = <Quiz>[].obs;

  Future<void> getQuiz() async {
    isLoading.value = true;
    if (await hasNetwork()) {
      try {
        quizzes.value =
            await _quizProvider.getQuiz(typeQuiz ? 0 : 1);
        _hiveProvider.saveListQuiz(quizzes.value);
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
    }else{
      quizzes.value = await _hiveProvider.getListQuiz();
      isLoading.value = false;
    }
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getQuiz();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}
}
