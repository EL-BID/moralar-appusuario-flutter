import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_appusuario/app/providers/hive_provider.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../../../providers/quiz_provider.dart';
import '../../../routes/app_pages.dart';
import '../../quizzes/controllers/quizzes_controller.dart';

class QuizController extends GetxController {
  final _quizProvider = Get.find<QuizProvider>();
  final _quizzesController = Get.find<QuizzesController>();
  final _hiveProvider = Get.find<HiveProvider>();
  final isLoading = false.obs;
  final buttonLoading = false.obs;
  final hasPageView = false.obs;
  final String id = Get.arguments;
  final PageController pageController = PageController();

  //Criação da tela
  final count = 0.obs;
  final indexAnswer = <int>[].obs;
  final valueAnswer = [<bool>[].obs];

  final waitingAnswerFilled = false.obs;

  //Classes
  final quiz = QuizDetails(
          id: Get.arguments,
          questionViewModel: [],
          title: '',
          typeQuiz: 0,
          created: 0)
      .obs;
  final answers = <Answer>[];
  final answersId = <String>[];
  final user = MegaFlutter.instance.auth.currentUser as FamilyHolder;

  Future<void> getQuiz() async {
    isLoading.value = true;
    if (await hasNetwork()) {
      try {
        quiz.value = await _quizProvider.getQuizDetails(id);
        _hiveProvider.saveQuizDetails(quiz.value);
        await createAnswers(quiz.value.questionViewModel);
        hasPageView.value = true;
        isLoading.value = false;
      } on MegaResponseException catch (e) {
        isLoading.value = false;
        Get.snackbar(
          'Algo deu errado!',
          e.message!,
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      final result = await _hiveProvider.getQuizDetails(id);
      if (result != null) {
        quiz.value = result;
        await createAnswers(quiz.value.questionViewModel);
        hasPageView.value = true;
      }
      isLoading.value = false;
    }
    getAnswers();
  }

  Future<void> getAnswers() async {
    final answersAux = await _hiveProvider.getAnswers();
    if (answersAux.length == answers.length) {
      answers.clear();
      answers.addAll(await _hiveProvider.getAnswers());
    }
    print(answers);
    indexAnswer.clear();
    for (int i = 0; i < quiz.value.questionViewModel.length; i++) {
      if (quiz.value.questionViewModel[i].typeResponse == 2 &&
          answers.length < i) {
        indexAnswer.add(quiz.value.questionViewModel[i].description.indexWhere(
            (element) => element.description == answers[i].answerDescription));
      } else {
        indexAnswer.add(0);
      }
    }
  }

  Future<void> createAnswers(List<QuestionResponse> questions) async {
    int index = 0;
    while (index < questions.length) {
      answers.add(
        Answer(
          questionId: questions[index].id,
          answerDescription: '',
          questionDescriptionId: [],
        ),
      );
      if (index >= 0 &&
          index <= answersId.length &&
          index <= questions.length) {
        answersId.insert(index, questions[index].id);
      }

      indexAnswer.add(0);
      final RxList<bool> initialValue = <bool>[].obs;
      valueAnswer.add(initialValue);
      index++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getQuiz();
  }

  List<String> getDescriptionAnswers(
      List<Description> descriptions, int index) {
    final List<String> answers = [];
    for (Description description in descriptions) {
      answers.add(description.description);
      valueAnswer[index].add(false);
    }
    return answers;
  }

  List<Answer> recoverQuestionIdForMyAnswers(List<Answer> answers) {
    for (var i = 0; i < answers.length; i++) {
      if ((answers[i].questionId == null) && (i < answersId.length)) {
        answers[i].questionId = answersId[i].toString();
      }
    }
    return answers;
  }

  Future<void> postAnswers() async {
    isLoading.value = true;
    try {
      final List<Answer> answersChecked =
          recoverQuestionIdForMyAnswers(answers);
      // ignore: parameter_assignments
      final questions = quiz.value.questionViewModel;
      final response = await _quizProvider.registerQuiz(
        user.id!,
        quiz.value.id,
        answersChecked,
      );
      isLoading.value = false;
      if (response) {
        _quizzesController.getQuiz();
        Get.back();
        Get.toNamed(Routes.ANSWERS, arguments: quiz.value.id);
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.snackbar(
            'Sucesso!',
            "Já recebemos suas respostas!",
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.algaeGreen,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    } on MegaResponseException catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Algo deu errado!',
        e.message!,
        colorText: MoralarColors.veryLightPink,
        backgroundColor: MoralarColors.strawberry,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> verifyAnswer(int index) async {
    final questions = quiz.value.questionViewModel;
    bool answered = true;

    buttonLoading.value = true;

    if (questions[index].typeResponse == 1) {
      int i = 0;
      String response = '';
      answers[index].questionDescriptionId!.clear();
      for (bool value in valueAnswer[index]) {
        if (value) {
          answers[index]
              .questionDescriptionId!
              .add(questions[index].description[i].id);
          response += '{${questions[index].description[i].description}}';
        }
        i++;
      }
      await Future.delayed(const Duration(milliseconds: 1000));

      if (response.isEmpty) {
        buttonLoading.value = false;
        answered = false;
        Get.snackbar(
          'Algo deu errado!',
          'Selecione pelo menos uma resposta',
          colorText: MoralarColors.veryLightPink,
          backgroundColor: MoralarColors.strawberry,
          snackPosition: SnackPosition.TOP,
        );
      } else {
        answers[index].answerDescription = response.trim();
      }
    } else {
      if (questions[index].typeResponse == 0) {
        await Future.delayed(const Duration(milliseconds: 3000));
      }
      if (answers[index].answerDescription!.isEmpty) {
        if (questions[index].typeResponse == 0) {
          answered = false;
          buttonLoading.value = false;
          Get.snackbar(
            'Algo deu errado!',
            'Digite uma resposta para prosseguir',
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
            snackPosition: SnackPosition.TOP,
          );
          return;
        } else {
          answers[index].answerDescription =
              questions[index].description[0].description;
          answers[index].questionDescriptionId?.add(questions[index].id);

          await Future.delayed(const Duration(milliseconds: 1500));
        }
      }
    }

    if (questions[index].typeResponse == 2) {
      await Future.delayed(const Duration(milliseconds: 3000));
    }

    buttonLoading.value = false;

    if (answered) {
      if (index + 1 == questions.length) {
        if (await hasNetwork()) {
          postAnswers();
        } else {
          _hiveProvider.saveAnswers(answers);
          Get.snackbar(
            'Sem conexão!',
            "Você está sem conexão com a internet, porém suas respostas foram salvas!",
            colorText: MoralarColors.veryLightPink,
            backgroundColor: MoralarColors.strawberry,
            snackPosition: SnackPosition.TOP,
          );
        }
      } else {
        pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }
  }

  bool checkAnswer() {
    return waitingAnswerFilled.value;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
