import 'model_quiz_content.dart';

class Question{

  int numberQuestion = 0;

  nextQuestionQuiz(int modelNextQuestion){
    if(numberQuestion < (modelNextQuestion - 1)){
      numberQuestion++;
    }else{
      bool completedQuiz = true;
      return completedQuiz;
    }
  }

  String getQuestion(List<ModelQuizContent> modelQuestion){
    return modelQuestion[numberQuestion].question_quiz_content;
  }

  String getImage(List<ModelQuizContent> modelQuestion){
    return modelQuestion[numberQuestion].image_quiz_content;
  }

  bool getAnswer(List<ModelQuizContent> modelQuestion){
    return modelQuestion[numberQuestion].answer_quiz_content == "0" ? false : true;
  }

  int startOver(){
    return numberQuestion = 0;
  }

}