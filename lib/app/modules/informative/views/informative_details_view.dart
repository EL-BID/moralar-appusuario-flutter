import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/informative_controller.dart';

class InformativeDetailView extends GetView<InformativeController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.INFORMATIVE);
          return false; // Prevent default back navigation
        },
        child: MoralarScaffold(
          appBar: const MoralarAppBar(
            titleText: 'Detalhe da notícia',
            backRoute: Routes.INFORMATIVE,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Visibility(
                // ignore: unnecessary_null_comparison
                visible: controller.informativeDetail != null,
                child: Column(children: [
                  InformativeDetailCard(
                    info: controller.informativeDetail as Informative,
                    checked: true,
                    function: () async {},
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}
