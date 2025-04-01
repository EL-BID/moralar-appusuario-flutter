import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/create_password_provider.dart';
import '../../../routes/app_pages.dart';

class CreatePasswordController extends GetxController {
  final isLoading = false.obs;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mom = TextEditingController();
  TextEditingController bornMotherPlace = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _createPasswordProvider = Get.find<CreatePasswordProvider>();
  final user =
      FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson());

  Future<void> createPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (password.text == confirmPassword.text) {
        isLoading.value = true;
        try {
          final response = await _createPasswordProvider.createPassword(
            user.cpf,
            password.text,
            mom.text,
            bornMotherPlace.text,
          );
          if (response) {
            isLoading.value = false;
            Get.toNamed(Routes.PERSONAL_DATA);
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
      } else {
        Get.snackbar(
          'Verifique seus dados!',
          'As senhas não se correspondem.',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
        );
      }
    }
  }

  @override
  void onClose() {}
}
