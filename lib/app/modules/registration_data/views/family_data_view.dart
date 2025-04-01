import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/registration_data_controller.dart';

class FamilyDataView extends GetView<RegistrationDataController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Dados Cadastrais',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Obx(() {
                final Spouse spouse = controller.familyUser.spouse;
                return SpouseForm(
                  spouse: controller.familyUser.spouse,
                  radio: controller.radioSpouse.value,
                  onChangedRadio: (i) {
                    controller.radioSpouse.value = i!;
                    spouse.genre = controller.radioSpouse.value;
                  },
                  schoolSpouse: controller.schoolSpouse.value,
                  onChangedSchool: (s) {
                    controller.schoolSpouse.value = s!;
                    spouse.scholarity = controller.schoolTypes
                        .indexOf(controller.schoolSpouse.value);
                  },
                  schoolTypes: controller.schoolTypes,
                );
              }),
              Text(
                'Dados do familiar',
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                // ignore: lines_longer_than_80_chars
                'Revise os dados dos seus familiares, se quiser adicionar outro membro ou editar algum campo você pode fazer isso, se tudo estiver em ordem você pode clicar no botão salvar.',
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Obx(() {
                return Column(
                  children: List.generate(controller.members.length, (index) {
                    final FamilyMember member = controller.members[index];
                    return MemberForm(
                      member: controller.familyUser.members[index],
                      radio: controller.radioFamily[index],
                      onChangedRadio: (i) {
                        controller.radioFamily[index] = i!;
                        member.genre = controller.radioFamily[index];
                      },
                      school: controller.schoolFamily[index],
                      onChangedSchool: (s) {
                        controller.schoolFamily[index] = s!;
                        member.scholarity = controller.schoolTypes
                            .indexOf(controller.schoolFamily[index]);
                      },
                      schoolTypes: controller.schoolTypes,
                      kinship: controller.kinshipFamily[index],
                      onChangedKinship: (s) {
                        controller.kinshipFamily[index] = s!;
                        member.kinShip = controller.kinship
                            .indexOf(controller.kinshipFamily[index]);
                      },
                      kinships: controller.kinship,
                      readOnly: controller.readOnly[index],
                    );
                  }),
                );
              }),
              const SizedBox(height: 32),
              MoralarOutlinedButton(
                function: () {
                  controller.addNewMember();
                },
                color: Theme.of(context).focusColor,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Adicionar Membro',
                    style: textTheme.labelLarge
                        ?.copyWith(color: Theme.of(context).focusColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return MoralarButton(
                  onPressed: () async {
                    await controller.saveData();
                  },
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
    );
  }
}
