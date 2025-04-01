import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    initializeDateFormatting();

    _content(QuestionResponse response, int index) {
      final answers = controller.getDescriptionAnswers(
        response.description,
        index,
      );
      return Visibility(
        visible: response.typeResponse == 0,
        child: OpenQuestion(
          controller: TextEditingController(
            text: (controller.answers.isNotEmpty &&
                    controller.answers.length > index)
                ? controller.answers[index].answerDescription ?? ""
                : "",
          ),
          onChanged: (s) {
            controller.answers[index].answerDescription = s;
            controller.waitingAnswerFilled.value = false;
          },
        ),
        replacement: Visibility(
          visible: response.typeResponse == 1,
          child: Column(
            children: [
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Text(
                    '* Você pode selecionar mais de uma opção',
                    textAlign: TextAlign.start,
                    style: textTheme.titleLarge?.copyWith(
                      color: MoralarColors.brownishGrey,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MultiplyQuestion(
                questionValue: controller.valueAnswer[index],
                answers: answers,
                onChanged: (i) {
                  controller.valueAnswer[index][i!] =
                      !controller.valueAnswer[index][i];
                },
              ),
            ],
          ),
          replacement: Visibility(
            visible: response.typeResponse == 2,
            child: CloseQuestion(
              questionIndex: controller.indexAnswer[index],
              answers: answers,
              onChanged: (i) {
                if (i != null && response.description != []) {
                  controller.indexAnswer[index] = i;
                  controller.answers[index].questionDescriptionId!.clear();
                  controller.answers[index] = Answer(
                      questionDescriptionId: [response.description[i].id],
                      answerDescription: answers[i]);
                }
              },
            ),
            replacement: ListQuestion(
              index: controller.indexAnswer[index],
              answers: answers,
              onChanged: (s) {
                int i = 0;
                for (final answer in answers) {
                  if (answer == s) {
                    controller.answers[index].questionDescriptionId!.clear();
                    controller.answers[index].questionDescriptionId!
                        .add(response.description[i].id);
                    controller.answers[index].answerDescription = answers[i];
                    controller.indexAnswer[index] = i;
                    return;
                  }
                  i++;
                }
              },
            ),
          ),
        ),
      );
    }

    return MoralarScaffold(
      appBar: MoralarAppBar(
        titleText: 'Questionário',
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            if (!controller.hasPageView.value) {
              Get.back();
              return;
            }
            if (controller.pageController.page == 0) {
              Get.back();
            } else {
              controller.pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Obx(() {
          final questions = controller.quiz.value.questionViewModel;
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
              visible: questions.isNotEmpty,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(DateFormat.yMMMd("pt").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            controller.quiz.value.created * 1000))),
                  ),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageController,
                      children: List.generate(questions.length, (index) {
                        return Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    QuizHeader(
                                      quizLength: questions.length,
                                      number: index + 1,
                                      nameQuestion:
                                          questions[index].nameQuestion,
                                    ),
                                    Visibility(
                                      visible:
                                          questions[index].typeResponse == 2,
                                      child: Column(
                                        children: [
                                          Text(
                                            '* Escolha apenas uma alternativa',
                                            style:
                                                textTheme.titleLarge?.copyWith(
                                              color: MoralarColors.brownishGrey,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 64),
                                    _content(questions[index], index),
                                  ],
                                ),
                              ),
                            ),
                            MoralarButton(
                              // ignore: avoid_bool_literals_in_conditional_expressions
                              disabled: (questions[index].typeResponse != 0
                                      ? false
                                      : controller.checkAnswer()) ||
                                  controller.buttonLoading.value,
                              onPressed: () async {
                                // ignore: avoid_bool_literals_in_conditional_expressions
                                if (questions[index].typeResponse != 0) {
                                  await controller.verifyAnswer(index);
                                } else {
                                  if (controller.pageController.hasClients) {
                                    await controller.verifyAnswer(index);
                                  }
                                }
                              },
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Visibility(
                                  visible: !controller.buttonLoading.value,
                                  child: Text(
                                    (questions.isNotEmpty &&
                                            (questions.length - 1) == index)
                                        ? 'Enviar'
                                        : 'Continuar',
                                    style: textTheme.labelLarge,
                                  ),
                                ),
                                Visibility(
                                  visible: controller.buttonLoading.value,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              replacement: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 256),
                child: Text(
                  'Nenhuma pergunta encontrada',
                  style: textTheme.headlineLarge,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
