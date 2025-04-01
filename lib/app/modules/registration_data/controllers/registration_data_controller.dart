import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/registration_data_provider.dart';
import '../../../routes/app_pages.dart';

class RegistrationDataController extends GetxController {
  //Base
  final _registrationDataProvider = Get.find<RegistrationDataProvider>();
  final personalFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  //Classes
  FamilyUser familyUser = FamilyUser(
    holder:
        FamilyHolder.fromJson(MegaFlutter.instance.auth.currentUser!.toJson()),
    spouse: Spouse(name: '', birthday: 0),
    members: [FamilyMember(name: '', birthday: 0, kinShip: 0)],
    id: '',
    isFirstAcess: false,
  );
  RxList members = <FamilyMember>[].obs;

  //Personal Data -  Radio, Dropdown School and TextEditingController
  TextEditingController name = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tel = TextEditingController();
  final schoolPersonal = 'Selecionar'.obs;
  final genderPersonal = 3.obs;

  //Family Data - Radio, Dropdown School and Dropdown kinship
  final radioSpouse = 0.obs;
  final schoolSpouse = ''.obs;
  final radioFamily = <int>[].obs;
  final schoolFamily = <String>[].obs;
  final kinshipFamily = <String>[].obs;
  final readOnly = <bool>[];

  //List school and List kinship
  List<String> schoolTypes = [
    'Não Possui',
    'Fundamental Incompleto',
    'Fundamental Completo',
    'Médio Incompleto',
    'Médio Completo',
    'Superior Incompleto',
    'Superior Completo',
    'Pós Graduação Incompleto',
    'Pós Graduação Completo',
  ];
  List<String> kinship = [
    'Filha',
    'Filho',
    'Mãe',
    'Pai',
    'Avó',
    'Avô',
    'Enteada',
    'Enteado',
    'Tia',
    'Tio',
    'Outro'
  ];

  Future<void> savePersonalData() async {
    if (personalFormKey.currentState!.validate()) {
      personalFormKey.currentState!.save();
      final unmaskedTel = Formats.unmaskTel(tel.text);
      familyUser.holder.scholarity = schoolTypes.indexOf(schoolPersonal.value);
      if (familyUser.holder.scholarity! >= 0) {
        if (genderPersonal.value != 3) {
          familyUser.holder.genre = genderPersonal.value;
          familyUser.holder.email = email.text;
          familyUser.holder.phone = unmaskedTel;
          if (familyUser.members.length > 0 || familyUser.spouse.name != null) {
            Get.toNamed(Routes.FAMILY_DATA);
          } else {
            isLoading.value = true;
            familyUser.isFirstAcess = false;
            familyUser.holder.isFirstAcess = false;
            try {
              final response =
                  await _registrationDataProvider.editPersonalData(familyUser);
              if (response) {
                isLoading.value = false;
                Get.offAndToNamed(Routes.TIMELINE);
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
          }
        } else {
          Get.snackbar(
            'Algo deu errado!',
            'Escolha seu Gênero.',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
          );
        }
      } else {
        Get.snackbar(
          'Algo deu errado!',
          'Escolha a sua escolaridade.',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
        );
      }
    }
  }

  Future<void> saveData() async {
    if (_verifyAllFields()) {
      isLoading.value = true;
      familyUser.isFirstAcess = false;
      debugPrint('Json inteiro: ${familyUser.toJson()}');
      debugPrint('Titular: ${familyUser.holder.toJson()}');
      debugPrint('Cônjugue: ${familyUser.spouse.toJson()}');
      for (var member in familyUser.members) {
        debugPrint('Membro: ${member.toJson()}');
      }
      try {
        final response =
            await _registrationDataProvider.editPersonalData(familyUser);
        if (response) {
          isLoading.value = false;
          Get.offAndToNamed(Routes.TIMELINE);
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
    }
    isLoading.value = false;
  }

  Future<void> getInfo() async {
    familyUser = await _registrationDataProvider.getInfoFamily();
    genderPersonal.value = familyUser.holder.genre ?? -1;
    email.text = familyUser.holder.email;
    tel.text = familyUser.holder.phone ?? "";
    if (familyUser.holder.scholarity != null) {
      schoolPersonal.value = schoolTypes[familyUser.holder.scholarity!];
    }
    if (familyUser.spouse.scholarity != null) {
      schoolSpouse.value = schoolTypes[familyUser.spouse.scholarity!];
    }
    radioSpouse.value = familyUser.spouse.genre ?? -1;
    schoolSpouse.value = familyUser.spouse.scholarity == null
        ? 'Selecione'
        : schoolTypes[familyUser.spouse.scholarity!];
    members.value = familyUser.members;

    for (var member in familyUser.members) {
      radioFamily.add(member.genre ?? -1);
      schoolFamily.add(
        member.scholarity == null
            ? 'Selecione'
            : schoolTypes[member.scholarity!],
      );
      kinshipFamily.add(kinship[member.kinShip]);
      readOnly.add(true);
    }
  }

  void addNewMember() {
    radioFamily.add(-1);
    schoolFamily.add('Selecione');
    kinshipFamily.add('Selecione');
    members.add(FamilyMember(name: '', birthday: 0, kinShip: -1));
    readOnly.add(false);
  }

  bool _verifyFamily() {
    for (FamilyMember family in members) {
      if (family.name.isEmpty || MoralarDate.validateDate(family.birthday)) {
        return false;
      }
    }
    return true;
  }

  bool _verifyScholarity() {
    if (familyUser.spouse.name == null ||
        familyUser.spouse.name == "" ||
        schoolTypes.indexOf(schoolSpouse.value) >= 0) {
      for (var family in schoolFamily) {
        if (schoolTypes.indexOf(family) < 0) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  bool _verifyGenre() {
    if (familyUser.spouse.name == null ||
        familyUser.spouse.name == "" ||
        radioSpouse.value >= 0) {
      for (var family in radioFamily) {
        if (family < 0) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  bool _verifyKinship() {
    for (var family in kinshipFamily) {
      if (kinship.indexOf(family) < 0) {
        return false;
      }
    }
    return true;
  }

  bool _verifyAllFields() {
    if (_verifyFamily()) {
      if (_verifyScholarity()) {
        if (_verifyGenre()) {
          if (_verifyKinship()) {
            return true;
          } else {
            Get.snackbar(
              'Algo deu errado!',
              'Verifique se marcou o grau de parentesco de cada familiar.',
              colorText: MoralarColors.veryLightPink,
              backgroundColor: MoralarColors.strawberry,
            );
          }
        } else {
          Get.snackbar(
            'Algo deu errado!',
            'Verifique se marcou o genêro de cada familiar.',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
          );
        }
      } else {
        Get.snackbar(
          'Algo deu errado!',
          'Verifique se marcou as escolaridades de cada familiar.',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
        );
      }
    } else {
      Get.snackbar(
        'Algo deu errado!',
        'Verifique o nome e a data de nascimento dos familiares.',
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
      );
    }

    return false;
  }

  @override
  void onInit() {
    super.onInit();
    getInfo();
    initializeDateFormatting();
    name.text = familyUser.holder.name;
    cpf.text = UtilBrasilFields.obterCpf(familyUser.holder.cpf);
    print(familyUser.holder.birthday);
    date.text = DateFormat.yMd("pt").format(DateTime.fromMillisecondsSinceEpoch(
        familyUser.holder.birthday! * 1000));
  }

  @override
  void onClose() {}
}
