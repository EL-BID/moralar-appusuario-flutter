import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/properties_controller.dart';

class FilterView extends GetView<PropertiesController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Filtro',
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Theme(
        data: makeAppTheme().copyWith(
          unselectedWidgetColor: MoralarColors.veryLightPink,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Tipo de imóvel',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  final radioValue = controller.imovelValue.value;
                  return Row(
                    children: [
                      Radio(
                        activeColor: MoralarColors.veryLightPink,
                        value: 0,
                        groupValue: radioValue,
                        onChanged: (i) {
                          final dynamic value = i;
                          controller.imovelValue.value = value;
                        },
                      ),
                      Text(
                        'Todos',
                        style: textTheme.headlineSmall,
                      ),
                      Radio(
                        activeColor: MoralarColors.veryLightPink,
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (i) {
                          final dynamic value = i;
                          controller.imovelValue.value = value;
                        },
                      ),
                      Text(
                        'Casa',
                        style: textTheme.headlineSmall,
                      ),
                      Radio(
                        activeColor: MoralarColors.veryLightPink,
                        value: 2,
                        groupValue: radioValue,
                        onChanged: (i) {
                          final dynamic value = i;
                          controller.imovelValue.value = value;
                        },
                      ),
                      Text(
                        'Apartamento',
                        style: textTheme.headlineSmall,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 32),
                Text(
                  'Metragem Quadrada (m²)',
                  style: textTheme.headlineSmall,
                ),
                RowTextField(
                  textFields: [
                    MoralarTextField(
                      controller: controller.startSquareFootage,
                      label: 'De:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                    MoralarTextField(
                      controller: controller.endSquareFootage,
                      label: 'Até:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Valor do Condomínio',
                  style: textTheme.headlineSmall,
                ),
                RowTextField(
                  textFields: [
                    MoralarTextField(
                      controller: controller.startCondominiumValue,
                      label: 'De:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                    MoralarTextField(
                      controller: controller.endCondominiumValue,
                      label: 'Até:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Valor do IPTU',
                  style: textTheme.headlineSmall,
                ),
                RowTextField(
                  textFields: [
                    MoralarTextField(
                      controller: controller.startIptuValue,
                      label: 'De:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                    MoralarTextField(
                      controller: controller.endIptuValue,
                      label: 'Até:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Número de Quartos',
                  style: textTheme.headlineSmall,
                ),
                RowTextField(
                  textFields: [
                    MoralarTextField(
                      controller: controller.startNumberOfBedrooms,
                      label: 'De:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                    MoralarTextField(
                      controller: controller.endNumberOfBedrooms,
                      label: 'Até:',
                      keyboard: const TextInputType.numberWithOptions(
                        signed: true,
                      ),
                      color: MoralarColors.veryLightPink,
                      labelStyle: textTheme.headlineSmall,
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Bairro de Localização',
                  style: textTheme.headlineSmall,
                ),
                Row(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Expanded(
                          child: DropdownButton<String>(
                            value: controller.neighborhood.text != ""
                                ? controller.neighborhood.text
                                : null,
                            hint: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                "Selecione aqui",
                                style: textTheme.headlineSmall,
                              ),
                            ),
                            icon: const SizedBox(),
                            elevation: 16,
                            style: textTheme.headlineSmall,
                            underline: Container(
                              height: 1,
                              color: textTheme.headlineSmall?.color,
                            ),
                            dropdownColor: MoralarColors.strawberry,
                            onChanged: (String? value) {
                              if (value != null) {
                                setState(
                                    () => controller.neighborhood.text = value);
                              }
                            },
                            selectedItemBuilder: (_) {
                              return controller.registeredNeighborhoods.value
                                  .map<Widget>((String item) {
                                return Center(
                                  child: Text(item),
                                );
                              }).toList();
                            },
                            items: controller.registeredNeighborhoods.value
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 20,
                      child: Icon(
                        Icons.arrow_downward,
                        color: textTheme.headlineSmall?.color,
                      ),
                    )
                  ],
                ),
                // MoralarTextField(
                //   controller: controller.neighborhood,
                //   label: 'Nome do bairro',
                //   color: MoralarColors.veryLightPink,
                //   labelStyle: textTheme.headlineSmall,
                //   hintStyle: textTheme.headlineSmall,
                // ),
                const SizedBox(height: 32),
                Text(
                  'Garagem',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return YesOrNotRadio(
                    value: controller.hasGarage.value,
                    function: (i) {
                      final dynamic value = i;
                      controller.hasGarage.value = value;
                    },
                  );
                }),
                const SizedBox(height: 32),
                Text(
                  'Escada de Acesso',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return YesOrNotRadio(
                    value: controller.hasLadder.value,
                    function: (i) {
                      final dynamic value = i;
                      controller.hasLadder.value = value;
                    },
                  );
                }),
                const SizedBox(height: 32),
                Text(
                  'Rampa de Acesso',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return YesOrNotRadio(
                    value: controller.hasRamp.value,
                    function: (i) {
                      final dynamic value = i;
                      controller.hasRamp.value = value;
                    },
                  );
                }),
                const SizedBox(height: 32),
                Text(
                  'Adaptada ou permite adaptação para PCD',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return YesOrNotRadio(
                    value: controller.hasPCD.value,
                    function: (i) {
                      final dynamic value = i;
                      controller.hasPCD.value = value;
                    },
                  );
                }),
                const SizedBox(height: 64),
                MoralarButton(
                  onPressed: () async {
                    Get.back();
                    await controller.checkFilters();
                  },
                  color: MoralarColors.veryLightPink,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Aplicar Filtro',
                      style: textTheme.labelLarge
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
