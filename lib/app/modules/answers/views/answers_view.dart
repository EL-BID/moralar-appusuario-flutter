import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/answers_controller.dart';

class AnswersView extends GetView<AnswersController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    _content(int index) {
      return Container(
        child: Visibility(
          visible: controller.answer[index].typeResponse == 0,
          child: Text(
            controller.answer[index].answers[0],
          ),
          replacement: Visibility(
            visible: controller.answer[index].typeResponse == 1,
            child: Column(children: [
              const Visibility(visible: false, child: Column()),
              MultiplyQuestionOnlyRead(
                questionValue: controller.getCheckboxQuestionValue(
                    controller.answer[index].answers[0]),
                answers: controller
                    .getCheckboxAnswers(controller.answer[index].answers[0]),
                onChanged: (i) {},
              ),
            ]),
            replacement: Visibility(
              visible: controller.answer[index].typeResponse == 2,
              child: CloseQuestion(
                small: true,
                questionIndex: 0,
                answers: controller.answer[index].answers,
                onChanged: (i) {},
              ),
              replacement: Column(
                children: [
                  ListQuestion(
                    onlyRead: true,
                    index: 0,
                    answers: controller.answer[index].answers,
                    onChanged: (s) {},
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    ;
    return Obx(() {
      return MoralarScaffold(
        appBar: MoralarAppBar(
          titleText: controller.title.value,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Visibility(
              visible: controller.isLoading.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 256),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              replacement: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (MoralarDate.secondsForDateHours(
                              controller.quiz.value.created)
                          .length >=
                      10)
                    Text(
                        "Data: ${MoralarDate.secondsForDateHours(controller.quiz.value.created).substring(0, 10)}",
                        style: textTheme.bodyMedium?.copyWith(fontSize: 16)),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(controller.answer.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            controller.answer[index].question,
                            style: textTheme.bodyMedium?.copyWith(
                              color: MoralarColors.waterBlue,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _content(index),
                          const SizedBox(height: 20),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
