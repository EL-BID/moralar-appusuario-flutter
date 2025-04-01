import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/properties_controller.dart';

class PropertiesView extends GetView<PropertiesController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    _properties() {
      return SingleChildScrollView(
        child: Column(
          children: [
            MoralarPicker(
              types: const ['Imóveis', 'Interessado'],
              isCurrent: 0,
              color: Theme.of(context).primaryColor,
              controller: controller.pageController,
              verticalPadding: 8,
              horizontalPadding: 36,
            ),
            const SizedBox(height: 24),
            Obx(() {
              return Visibility(
                visible: controller.hasFilter.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PropertyFilterCard(
                    filter: controller.filter.value,
                    imovel: controller.imovelValue.value,
                    changeImovel: (i) {
                      controller.imovelValue.value = i!;
                    },
                    startSquareFootage: controller.startSquareFootage,
                    endSquareFootage: controller.endSquareFootage,
                    startCondominiumValue: controller.startCondominiumValue,
                    endCondominiumValue: controller.endCondominiumValue,
                    startIptuValue: controller.startIptuValue,
                    endIptuValue: controller.endIptuValue,
                    neighborhood: controller.neighborhood,
                    startNumberOfBedrooms: controller.startNumberOfBedrooms,
                    endNumberOfBedrooms: controller.endNumberOfBedrooms,
                    hasGarage: controller.hasGarage.value,
                    changeGarage: (i) {
                      controller.hasGarage.value = i!;
                    },
                    hasLadder: controller.hasLadder.value,
                    changeLadder: (i) {
                      controller.hasLadder.value = i!;
                    },
                    hasRamp: controller.hasRamp.value,
                    changeRamp: (i) {
                      controller.hasRamp.value = i!;
                    },
                    hasPCD: controller.hasPCD.value,
                    changePCD: (i) {
                      controller.hasPCD.value = i!;
                    },
                    apply: () {
                      controller.checkFilters();
                    },
                    remove: () {
                      controller.removeFilters();
                    },
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 256),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.properties.isNotEmpty,
                    child: Column(
                      children:
                          List.generate(controller.properties.length, (index) {
                        return PropertyCard(
                          function: () => Get.toNamed(
                            Routes.PROPERTY_DETAILS,
                            arguments: controller.properties[index],
                          ),
                          property: controller.properties[index],
                        );
                      }),
                    ),
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(vertical: 256),
                      child: Text(
                        'Nenhum Imóvel encontrado',
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    }

    _matchs() {
      return SingleChildScrollView(
        child: Column(
          children: [
            MoralarPicker(
              types: const ['Imóveis', 'Interessado'],
              isCurrent: 1,
              color: Theme.of(context).primaryColor,
              controller: controller.pageController,
              verticalPadding: 8,
              horizontalPadding: 36,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() {
                return Visibility(
                  visible: controller.isLoading.value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 256),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  replacement: Visibility(
                    visible: controller.matchs.isNotEmpty,
                    child: Column(
                      children:
                          List.generate(controller.matchs.length, (index) {
                        return PropertyCard(
                          function: () => Get.toNamed(
                            Routes.PROPERTY_DETAILS,
                            arguments: controller.matchs[index],
                          ),
                          property: controller.matchs[index],
                        );
                      }),
                    ),
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(vertical: 256),
                      child: Text(
                        'Nenhum Imóvel encontrado',
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    }

    return MoralarScaffold(
      appBar: MoralarAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleText: 'Escolha de imóveis',
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.FILTER),
            icon: const Icon(FontAwesomeIcons.slidersH),
          ),
        ],
      ),
      body: PageView(
        controller: controller.pageController,
        children: [
          _properties(),
          _matchs(),
        ],
      ),
    );
  }
}
