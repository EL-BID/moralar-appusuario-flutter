import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../routes/app_pages.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MoralarScaffold(
      appBar: const MoralarAppBar(
        titleText: 'Cursos',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
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
                    visible: controller.courses.isNotEmpty,
                    child: Column(
                      children:
                          List.generate(controller.courses.length, (index) {
                        return CourseCard(
                          function: () {
                            Get.toNamed(
                              Routes.COURSE_DETAILS,
                              arguments: controller.courses[index],
                            );
                          },
                          course: controller.courses[index],
                        );
                      }),
                    ),
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(vertical: 256),
                      child: Text(
                        'Nenhum Curso encontrado',
                        style: textTheme.headlineLarge,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
