import 'package:hive/hive.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class HiveProvider{

  void deleteAll(){
    Hive.deleteBoxFromDisk('quizzes');
    Hive.deleteBoxFromDisk('quizList');
  }

  Future<QuizDetails?> getQuizDetails(String id) async {
    var box = await Hive.openBox('quizzes');
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        if(box.getAt(i).id == id){
          return box.getAt(i);
        }
      }
    }
    return null;
  }

  Future<void> saveQuizDetails(QuizDetails quizDetails) async {
    var box = await Hive.openBox('quizzes');
    box.add(quizDetails);
  }

  Future<List<Quiz>> getListQuiz() async {
    var box = await Hive.openBox('quizList');
    List<Quiz> quizList = [];
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        quizList.add(box.getAt(i));
      }
    }
    return quizList;
  }

  Future<void> saveListQuiz(List<Quiz> quizList) async {
    Hive.deleteBoxFromDisk('quizList');
    var box = await Hive.openBox('quizList');
    quizList.forEach((element) {
      box.add(element);
    });
  }

  Future<List<Answer>> getAnswers() async {
    var box = await Hive.openBox('answers');
    List<Answer> answers = [];
    if(box.isNotEmpty) {
      for(int i = 0; i < box.length; i++){
        answers.add(box.getAt(i));
      }
    }
    return answers;
  }

  Future<void> saveAnswers(List<Answer> answers) async {
    var box = await Hive.openBox('answers');
    answers.forEach((element) {
      box.add(element);
    });
  }
}