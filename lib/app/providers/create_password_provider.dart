import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class CreatePasswordProvider extends RemoteProvider {
  Future<bool> createPassword(
      String cpf, String password, String mom, String motherCity) async {
    try {
      await post(
        Urls.family.firstAccess,
        body: {
          'cpf': cpf,
          'password': password,
          'motherName': mom,
          'motherCityBorned': motherCity,
        },
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
