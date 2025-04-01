import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/informative_controller.dart';

class InformativeView extends GetView<InformativeController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Informativos',
        // ignore: avoid_redundant_argument_values
        backRoute: Routes.TIMELINE,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            return Visibility(
              visible: controller.isLoading.value,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 256),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              replacement: Visibility(
                visible: controller.informatives.isNotEmpty,
                child: Column(
                  children:
                      List.generate(controller.informatives.length, (index) {
                    return InformativeCard(
                      info: controller.informatives[index],
                      checked: controller.isChecked[index].value,
                      isLoading: controller.checkboxLoading[index].value,
                      function: () async {
                        controller.changeStatusInformative(index);
                      },
                      onTap: () async {
                        controller
                            .goToDetailView(controller.informatives[index]);
                      },
                    );
                  }),
                ),
                replacement: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 256),
                  child: Text(
                    'Nenhum Informativo encontrado',
                    style: textTheme.headlineLarge,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
