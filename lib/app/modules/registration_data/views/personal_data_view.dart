import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/registration_data_controller.dart';

class PersonalDataView extends GetView<RegistrationDataController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Dados Cadastrais',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.personalFormKey,
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                MoralarTextField(
                  controller: controller.name,
                  label: 'Nome do titular',
                  color: MoralarColors.waterBlue,
                  readOnly: true,
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.cpf,
                  label: 'CPF do titular',
                  readOnly: true,
                  formats: [Formats.cpfMaskFormatter],
                  color: MoralarColors.waterBlue,
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.date,
                  label: 'Data de Nascimento',
                  readOnly: true,
                  color: MoralarColors.waterBlue,
                  labelStyle: textTheme.bodyLarge
                      ?.copyWith(color: MoralarColors.waterBlue, fontSize: 16),
                ),
                const SizedBox(height: 32),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gênero',
                    style: textTheme.displaySmall?.copyWith(
                      color: MoralarColors.brownishGrey,
                    ),
                  ),
                ),
                Obx(() {
                  return Column(
                    children: [
                      RadioListTile(
                        value: 0,
                        groupValue: controller.genderPersonal.value,
                        onChanged: (dynamic value) {
                          controller.genderPersonal.value = value!;
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text('Feminino', style: textTheme.bodyMedium),
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: controller.genderPersonal.value,
                        onChanged: (dynamic value) {
                          controller.genderPersonal.value = value!;
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text('Masculino', style: textTheme.bodyMedium),
                      ),
                      RadioListTile(
                        value: 2,
                        groupValue: controller.genderPersonal.value,
                        onChanged: (dynamic value) {
                          controller.genderPersonal.value = value!;
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text('Outro', style: textTheme.bodyMedium),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.email,
                  label: 'E-Mail',
                  validators: [
                    Validatorless.email('Esse e-mail não existe'),
                  ],
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                MoralarTextField(
                  controller: controller.tel,
                  label: 'Telefone',
                  keyboard: const TextInputType.numberWithOptions(
                    signed: true,
                  ),
                  formats: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Escolaridade',
                    style: textTheme.displaySmall?.copyWith(
                      color: MoralarColors.brownishGrey,
                    ),
                  ),
                ),
                Obx(() {
                  return DropdownButton<String>(
                    hint: Text(
                      controller.schoolPersonal.value,
                      style: textTheme.bodyMedium,
                    ),
                    icon: const Icon(FontAwesomeIcons.angleDown),
                    elevation: 16,
                    style: textTheme.bodyMedium,
                    underline: Container(
                      height: 2,
                      color: MoralarColors.brownishGrey,
                    ),
                    isExpanded: true,
                    onChanged: (s) {
                      controller.schoolPersonal.value = s!;
                    },
                    items: controller.schoolTypes
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 20),
                Obx(() {
                  return MoralarButton(
                    onPressed: () => controller.savePersonalData(),
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
