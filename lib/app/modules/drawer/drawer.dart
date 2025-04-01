import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../routes/app_pages.dart';
import '../timeline/controllers/timeline_controller.dart';

class FamilyDrawer extends StatelessWidget {
  const FamilyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _timelineController = Get.find<TimelineController>();
    final user = MegaFlutter.instance.auth.currentUser as FamilyHolder;
    return MoralarDrawer(
      header: MoralarDrawerHeader(
        title: user.name,
        subtitle: UtilBrasilFields.obterCpf(user.cpf),
      ),
      options: [
        MoralarDrawerListTile(
          titleText: 'Status de Reassentamento',
          icon: FontAwesomeIcons.bars,
          onTap: () {
            final controller = Get.find<TimelineController>();
            controller.getCountNotReadNotifications();
            Get.toNamed(Routes.TIMELINE);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Escolha de Imóveis',
          icon: FontAwesomeIcons.home,
          onTap: () {
            Get.toNamed(Routes.PROPERTIES);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Agendamentos',
          icon: FontAwesomeIcons.calendarAlt,
          onTap: () {
            Get.toNamed(Routes.SCHEDULINGS);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Questionários',
          icon: FontAwesomeIcons.questionCircle,
          onTap: () {
            Get.toNamed(Routes.QUIZZES, arguments: true);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Informativos',
          icon: FontAwesomeIcons.infoCircle,
          onTap: () {
            Get.toNamed(Routes.INFORMATIVE);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Entre em contato',
          icon: FontAwesomeIcons.whatsapp,
          onTap: () {
            Get.toNamed(Routes.CONTACTS);
          },
        ),
        MoralarDrawerListTile(
          titleText: 'Alterar Senha',
          icon: FontAwesomeIcons.lock,
          onTap: () {
            Get.toNamed(Routes.CHANGE_PASSWORD);
          },
        ),
      ],
      signOut: () async {
        Get.offAndToNamed(Routes.SPLASH);
        await _timelineController.unregisterDeviceId();
        await MegaFlutter.instance.auth.signOut();
      },
    );
  }
}
