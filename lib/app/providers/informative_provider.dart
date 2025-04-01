import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class InformativeProvider extends RemoteProvider {
  Future<List<Informative>> getInformatives() async {
    try {
      final response = await get(Urls.family.informative);
      print(response.data);
      return (response.data as List)
          .map((item) => Informative.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> changeStatusInformative(String id) async {
    try {
      print('${Urls.family.changeInformative}/$id');
      await post(
        '${Urls.family.changeInformative}/$id',
        body: {
          "informativeId": id
        }
      );
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
