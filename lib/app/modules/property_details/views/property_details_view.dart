import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/property_details_controller.dart';

class PropertyDetailsView extends GetView<PropertyDetailsController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final address = controller.property.residencialPropertyAdress;
    final features = controller.property.residencialPropertyFeatures;
    final bool hasElevator = features.hasElevator ?? false;
    final bool hasServiceArea = features.hasServiceArea ?? false;
    final bool hasGarage = features.hasGarage ?? false;
    final bool hasCistern = features.hasCistern ?? false;
    final bool hasWall = features.hasWall ?? false;
    final bool hasAcessLadder = features.hasAccessLadder ?? false;
    final bool hasAcessRamp = features.hasAccessRamp ?? false;
    final bool hasYard = features.hasYard ?? false;
    final bool hasAdaptedToPcd = features.hasAdaptedToPcd ?? false;
    final bool isInterested = features.isInterested ?? false;
    final formatCurrency = new NumberFormat.simpleCurrency(locale: "pt_Br");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.grey,
            size: 32,
          ),
          onPressed: Get.back,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 380,
              child: Visibility(
                visible: controller.property.photo!.length > 0,
                child: CarouselSlider.builder(
                  slideBuilder: (index) {
                    return Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Image.network(
                              controller.property.photo![index]['imageUrl'] ??
                                  '${MoralarWidgets.instance.baseUrlAssets}/default.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                            ),
                            Text(controller.property.photo![index]
                                    ['description'] ??
                                '')
                          ],
                        ));
                  },
                  slideIndicator: CircularSlideIndicator(
                    indicatorBackgroundColor: MoralarColors.veryLightPink,
                    currentIndicatorColor: MoralarColors.strawberry,
                    padding: const EdgeInsets.only(bottom: 8),
                  ),
                  itemCount: controller.property.photo!.length,
                  autoSliderTransitionCurve: Curves.easeIn,
                  autoSliderTransitionTime: const Duration(milliseconds: 800),
                  enableAutoSlider: true,
                  unlimitedMode: true,
                ),
                replacement: Center(
                  child: Image.network(
                    '${MoralarWidgets.instance.baseUrlAssets}/default.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    // spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Imóvel #${controller.property.code}',
                              style: textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  size: 16,
                                  color: MoralarColors.brownishGrey,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    '${address.neighborhood}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(
                          Routes.MAPS,
                          arguments: controller.property,
                        ),
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: MegaListTile(
                          title: features.typeProperty == 0
                              ? 'Casa'
                              : 'Apartamento',
                          leading: Icon(
                            features.typeProperty == 0
                                ? FontAwesomeIcons.home
                                : FontAwesomeIcons.solidBuilding,
                            size: 16,
                            color: MoralarColors.brownishGrey,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: MoralarColors.brownishGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MegaListTile(
                          title: '${features.squareFootage} m²',
                          leading: const Icon(
                            FontAwesomeIcons.ruler,
                            size: 16,
                            color: MoralarColors.brownishGrey,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: MoralarColors.brownishGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: MegaListTile(
                          title: '${features.numberOfBedrooms} quartos',
                          leading: const Icon(
                            FontAwesomeIcons.bed,
                            size: 16,
                            color: MoralarColors.brownishGrey,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: MoralarColors.brownishGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MegaListTile(
                          title: '${features.numberOfBathrooms} banheiros',
                          leading: const Icon(
                            FontAwesomeIcons.bath,
                            size: 16,
                            color: MoralarColors.brownishGrey,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: MoralarColors.brownishGrey,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: MegaListTile(
                          title:
                              // ignore: lines_longer_than_80_chars
                              '${controller.property.interestedFamilies} famílias interessadas',
                          leading: const Icon(
                            Icons.people,
                            color: MoralarColors.brownishGrey,
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            color: MoralarColors.brownishGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BoldNormal(
                    title: 'Planta',
                    body: '',
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Image.network(
                      controller.getProjectPath(
                          controller.property.project.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Valor do Condomínio',
                    body: '${formatCurrency.format(features.condominiumValue)}',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Valor do IPTU',
                    body: '${formatCurrency.format(features.iptuValue)}',
                  ),
                  Visibility(
                    visible:
                        features.floorLocation.toString().isNotEmpty ?? false,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        BoldNormal(
                          title: 'Andar de localização',
                          body: '${features.floorLocation}° andar',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Elevador',
                    body: hasElevator ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Número de pavimentos',
                    body: '${features.numberFloors}',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Área de serviço',
                    body: hasServiceArea ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Garagem',
                    body: hasGarage ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Cisterna',
                    body: hasCistern ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Murada',
                    body: hasWall ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Escada de acesso',
                    body: hasAcessLadder ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Rampa de acesso',
                    body: hasAcessRamp ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Quintal',
                    body: hasYard ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Adaptada ou permite adaptação para PCD',
                    body: hasAdaptedToPcd ? 'Sim' : 'Não',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Regularização do imóvel',
                    body: features.propertyRegularization == 1
                        ? 'Regularizável'
                        : 'Regular',
                  ),
                  const SizedBox(height: 24),
                  BoldNormal(
                    title: 'Instalação de Gás',
                    body: features.typeGasInstallation == 1
                        ? 'Botijão'
                        : 'Gás Encanado',
                  ),
                  const SizedBox(height: 24),
                  Obx(() {
                    return MoralarButton(
                      onPressed: () async {
                        if (isInterested) {
                          if (await controller.refuseInterest()) {
                            controller.moveForInterestPage();
                            Get.back();
                            Get.snackbar(
                              'Imóvel Removido!',
                              'Encontre novos imóveis que te interessam.',
                              colorText: MoralarColors.veryLightPink,
                              backgroundColor: MoralarColors.strawberry,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        } else {
                          if (await controller.confirmInterest()) {
                            final count = await controller
                                .getCountInterestingFamilyInTheProperty();
                            Get.defaultDialog(
                              title: '',
                              content: ConfirmSubscription(
                                  description:
                                      // ignore: lines_longer_than_80_chars
                                      'O número máximo de imóveis de seu interesse deve ser 3. \n',
                                  subDescription: '$count/3'),
                              cancel: Container(
                                padding: const EdgeInsets.all(8),
                                child: MoralarOutlinedButton(
                                  color: MoralarColors.waterBlue,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Ver seus imóveis de interesse',
                                      style: textTheme.labelLarge!.copyWith(
                                        color: MoralarColors.waterBlue,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  function: () {
                                    controller.moveForInterestPage();
                                    Get.back();
                                    Get.back();
                                  },
                                ),
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
                          }
                        }
                      },
                      isLoading: controller.isLoading.value,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          isInterested
                              ? 'Remover Interesse'
                              : 'Confirmar interesse',
                          style: textTheme.labelLarge,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
