import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/first_access_controller.dart';

class FirstAccessView extends GetView<FirstAccessController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Data de Nascimento',
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 64),
                Container(
                  alignment: Alignment.center,
                  height: 180,
                  width: 180,
                  child: MoralarImage.asset(Assets.images.bolo),
                ),
                const SizedBox(height: 64),
                Text(
                  'Data de Nascimento',
                  style: textTheme.displayMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  // ignore: lines_longer_than_80_chars
                  'Informe aqui a data de nascimento do responsável pela família',
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),
                Row(
                  children: [
                    Flexible(
                      child: MoralarTextField(
                        controller: controller.day,
                        label: 'Dia',
                        keyboard: const TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        validators: [
                          Validatorless.required('Identifique o dia')
                        ],
                        maxLenght: 2,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: MoralarTextField(
                        controller: controller.month,
                        label: 'Mês',
                        keyboard: const TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        validators: [
                          Validatorless.required('Identifique o mês')
                        ],
                        maxLenght: 2,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: MoralarTextField(
                        controller: controller.year,
                        label: 'Ano',
                        keyboard: const TextInputType.numberWithOptions(
                          signed: true,
                        ),
                        validators: [
                          Validatorless.required('Identifique o ano')
                        ],
                        maxLenght: 4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                Obx(() {
                  return MoralarButton(
                    onPressed: () => controller.signBirthday(),
                    isLoading: controller.isLoading.value,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Salvar', style: textTheme.labelLarge),
                    ),
                  );
                }),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
