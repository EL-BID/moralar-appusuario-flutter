import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/create_password_controller.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Criação de Senha',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Text(
                //   'Lorem ipsum dolor sit amet',
                //   style: textTheme.displayMedium?.copyWith(
                //     fontSize: 24,
                //   ),
                // ),
                // const SizedBox(height: 16),
                // Text(
                //   // ignore: lines_longer_than_80_chars
                //   'Lorem ipsum dolor sit amet, consectetur  adi sed do eiusmod tempor  incididunt ut labore etdolore magna aliqua.  Ut enim ad minim veniam.',
                //   style: textTheme.bodyLarge,
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 48),
                MoralarTextField(
                  label: 'Senha',
                  controller: controller.password,
                  isPassword: true,
                  validators: [
                    Validatorless.required('A senha precisa ser preenchida'),
                    Validatorless.min(6, 'No mínimimo 6 caracteres'),
                  ],
                  color: MoralarColors.waterBlue,
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.confirmPassword,
                  label: 'Confirmar Senha',
                  isPassword: true,
                  validators: [
                    Validatorless.required(
                        'A confirmação da senha precisa ser preenchida'),
                    Validatorless.min(6, 'No mínimimo 6 caracteres'),
                  ],
                  color: MoralarColors.waterBlue,
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.mom,
                  label: 'Primeiro nome da sua mãe',
                  color: MoralarColors.waterBlue,
                  validators: [
                    Validatorless.required(
                        'O nome da mãe precisa ser preenchido'),
                  ],
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.bornMotherPlace,
                  label: 'Cidade onde sua mãe nasceu',
                  color: MoralarColors.waterBlue,
                  validators: [
                    Validatorless.required(
                        'A cidade onde sua mãe nasceu precisa ser preenchido'),
                  ],
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 64),
                Obx(() {
                  return MoralarButton(
                    onPressed: () => controller.createPassword(),
                    isLoading: controller.isLoading.value,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Salvar', style: textTheme.labelLarge),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
