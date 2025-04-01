import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/terms_controller.dart';

class TermsView extends GetView<TermsController> {
  @override
  Widget build(BuildContext context) {
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Termos de Uso',
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: const Text('Em breve'),
      ),
    );
  }
}
