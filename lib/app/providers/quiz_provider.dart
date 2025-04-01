import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class QuizProvider extends RemoteProvider {
  Future<List<Quiz>> getQuiz(int typeQuiz) async {
    print(Urls.family.quiz);
    try {
      final response = await get(
        Urls.family.quiz,
        queryParameters: {
          'typeQuiz': typeQuiz,
        },
      );
      return (response.data as List)
          .map((item) => Quiz.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<QuizDetails> getQuizDetails(String id) async {
    try {
      final response = await get(
        '${Urls.family.quizDetails}/$id',
      );
      return QuizDetails.fromJson(response.data);
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<List<AnswerDetails>> getAnswerDetails(String id) async {
    print(Urls.family.response);
    print({'quizId': id});
    try {
      final response = await get(
        Urls.family.response,
        queryParameters: {'quizId': id},
      );
      return (response.data as List)
          .map((item) => AnswerDetails.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future<bool> registerQuiz(
      String familyId, String quizId, List<Answer> answers) async {
    try {
      final response = await post(
        Urls.family.registerQuiz,
        body: {
          'familyId': familyId,
          'responsibleForResponsesId': familyId,
          'quizId': quizId,
          'questions': answers.map((e) => e.toJson()).toList(),
        },
      );
      print({
        'familyId': familyId,
        'responsibleForResponsesId': familyId,
        'quizId': quizId,
        'questions': answers.map((e) => e.toJson()).toList(),
      }.toString());
      print(response.data);
      return true;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}
