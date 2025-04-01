import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/properties_provider.dart';

class PropertiesController extends GetxController {
  final _propertiesProvider = Get.find<PropertiesProvider>();
  final PageController pageController = PageController();
  final isLoading = false.obs;
  final hasFilter = false.obs;

  //Filtros
  final imovelValue = 0.obs;
  final TextEditingController startSquareFootage = TextEditingController();
  final TextEditingController endSquareFootage = TextEditingController();
  final TextEditingController startCondominiumValue = TextEditingController();
  final TextEditingController endCondominiumValue = TextEditingController();
  final TextEditingController startIptuValue = TextEditingController();
  final TextEditingController endIptuValue = TextEditingController();
  final TextEditingController startNumberOfBedrooms = TextEditingController();
  final TextEditingController endNumberOfBedrooms = TextEditingController();
  final TextEditingController neighborhood = TextEditingController();
  final hasGarage = 3.obs;
  final hasLadder = 3.obs;
  final hasRamp = 3.obs;
  final hasPCD = 3.obs;

  //Classes
  final registeredNeighborhoods = <String>[].obs;
  final properties = <Property>[].obs;
  final matchs = <Property>[].obs;
  final filter = PropertyFilter().obs;
  final user =
      FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson());

  Future<void> getRegisteredNeighborhoods() async {
    isLoading.value = true;
    try {
      registeredNeighborhoods.value = await _propertiesProvider.getRegisteredNeighborhoods();
      if (registeredNeighborhoods.value.isNotEmpty) {
        // neighborhood.text = registeredNeighborhoods.value.first;
      }
    } on MegaResponseException catch (e) {
      properties.value = [];
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> getProperties() async {
    await getLocation();
    isLoading.value = true;
    try {
      properties.value = await _propertiesProvider.getProperties(filter.value);
    } on MegaResponseException catch (e) {
      properties.value = [];
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> getMatchs() async {
    isLoading.value = true;
    try {
      matchs.value = await _propertiesProvider.getMatchs(user.id!);
    } on MegaResponseException catch (e) {
      matchs.value = [];
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<void> checkFilters() async {
    debugPrint('Inicio: ${filter.value.toJson()}');

    //Tipo de imóvel
    if (imovelValue.value == 1) {
      filter.value.typeProperty = 'Casa';
    } else if (imovelValue.value == 2) {
      filter.value.typeProperty = 'Apartamento';
    } else {
      filter.value.typeProperty = null;
    }

    //Metragem Quadrada
    if (startSquareFootage.text.isNotEmpty) {
      filter.value.startSquareFootage = double.parse(startSquareFootage.text);
    } else {
      filter.value.startSquareFootage = null;
    }
    if (endSquareFootage.text.isNotEmpty) {
      filter.value.endSquareFootage = double.parse(endSquareFootage.text);
    } else {
      filter.value.endSquareFootage = null;
    }

    //Valor do Condominio
    if (startCondominiumValue.text.isNotEmpty) {
      filter.value.startCondominiumValue =
          double.parse(startCondominiumValue.text);
    } else {
      filter.value.startCondominiumValue = null;
    }
    if (endCondominiumValue.text.isNotEmpty) {
      filter.value.endCondominiumValue = double.parse(endCondominiumValue.text);
    } else {
      filter.value.endCondominiumValue = null;
    }

    //Valor do IPUT
    if (startIptuValue.text.isNotEmpty) {
      filter.value.startIptuValue = double.parse(startIptuValue.text);
    } else {
      filter.value.startIptuValue = null;
    }
    if (endIptuValue.text.isNotEmpty) {
      filter.value.endIptuValue = double.parse(endIptuValue.text);
    } else {
      filter.value.endIptuValue = null;
    }

    //Número de quartos
    if (startNumberOfBedrooms.text.isNotEmpty) {
      filter.value.startNumberOfBedrooms =
          int.parse(startNumberOfBedrooms.text);
    } else {
      filter.value.startNumberOfBedrooms = null;
    }
    if (endNumberOfBedrooms.text.isNotEmpty) {
      filter.value.endNumberOfBedrooms = int.parse(endNumberOfBedrooms.text);
    } else {
      filter.value.endNumberOfBedrooms = null;
    }

    //Bairro de localização
    if (neighborhood.text.isNotEmpty) {
      filter.value.neighborhood = neighborhood.text;
    } else {
      filter.value.neighborhood = null;
    }

    //Tem Garagem
    if (hasGarage.value == 0) {
      filter.value.hasGarage = true;
    } else if (hasGarage.value == 1) {
      filter.value.hasGarage = false;
    } else {
      filter.value.hasGarage = null;
    }

    //Tem Escada de Acesso
    if (hasLadder.value == 0) {
      filter.value.hasAccessLadder = true;
    } else if (hasLadder.value == 1) {
      filter.value.hasAccessLadder = false;
    } else {
      filter.value.hasAccessLadder = null;
    }

    //Tem Rampa de Acesso
    if (hasRamp.value == 0) {
      filter.value.hasAccessRamp = true;
    } else if (hasRamp.value == 1) {
      filter.value.hasAccessRamp = false;
    } else {
      filter.value.hasAccessRamp = null;
    }

    //Tem PCD
    if (hasPCD.value == 0) {
      filter.value.hasAdaptedToPcd = true;
    } else if (hasPCD.value == 1) {
      filter.value.hasAdaptedToPcd = false;
    } else {
      filter.value.hasAdaptedToPcd = null;
    }

    debugPrint('Fim: ${filter.value.toJson()}');
    hasFilter.value = false;
    await getProperties();
    hasFilter.value = true;
  }

  void removeFilters() {
    imovelValue.value = 0;
    startSquareFootage.text = '';
    endSquareFootage.text = '';
    startCondominiumValue.text = '';
    endCondominiumValue.text = '';
    startIptuValue.text = '';
    endIptuValue.text = '';
    startNumberOfBedrooms.text = '';
    endNumberOfBedrooms.text = '';
    neighborhood.text = '';
    hasGarage.value = 3;
    hasLadder.value = 3;
    hasRamp.value = 3;
    hasPCD.value = 3;
    hasFilter.value = false;
    filter.value = PropertyFilter();
    getProperties();
  }

  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    filter.value.lat = _locationData.latitude;
    filter.value.lng = _locationData.longitude;
  }

  @override
  void onInit() {
    super.onInit();
    getRegisteredNeighborhoods();
    getProperties();
    getMatchs();
  }

  @override
  void onClose() {}
}
