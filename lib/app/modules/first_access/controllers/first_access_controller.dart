import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';

class FirstAccessController extends GetxController {
  final isLoading = false.obs;
  bool hasError = false;
  TextEditingController day = TextEditingController();
  TextEditingController month = TextEditingController();
  TextEditingController year = TextEditingController();

  final credentials = DocumentCredentials();
  final formKey = GlobalKey<FormState>();

  Future<void> signBirthday() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      credentials.birthday =
          MoralarDate.dateForSeconds('${day.text}/${month.text}/${year.text}');
      if (MoralarDate.validateDate(credentials.birthday)) {
        Get.snackbar(
          'Ops!',
          'Não é possível nascer em um dia que ainda não se passou',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
        );
      } else {
        isLoading.value = true;
        try {
          await MegaFlutter.instance.auth.signIn(credentials);
          hasError = false;
          isLoading.value = false;
        } on MegaResponseException catch (e) {
          debugPrint(e.message);
          hasError = true;
          isLoading.value = false;
          Get.snackbar(
            'Algo deu errado!',
            e.message ?? 'Data de aniversário não condiz com o registrado.',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
          );
        }
        if (MegaFlutter.instance.auth.currentUser != null && !hasError) {
          Get.toNamed(Routes.CREATE_PASSWORD);
        }
      }
    }
  }

  @override
  void onInit() {
    credentials.cpf = Get.arguments;
    super.onInit();
  }
}
