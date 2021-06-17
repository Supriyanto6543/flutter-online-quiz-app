import 'package:dio/dio.dart';
import 'package:online_quiz/controller/api.dart';
import 'package:online_quiz/model/quiz/model_quiz.dart';
import 'package:online_quiz/model/quiz/model_quiz_content.dart';

Future<List<ModelQuiz>> getQuiz(List<ModelQuiz> q) async{
  var request = await Dio().get(Api.baseUrl+Api.api+Api.quiz);
  print("${Api.baseUrl+Api.api+Api.quiz}");
  for(Map<String, dynamic> quiz in request.data){
    List<ModelQuizContent> mqc = [];
    for(Map<String, dynamic> content in quiz['content']){
      mqc.add(ModelQuizContent(
          id_quiz_content: content['id_quiz_content'],
          id_quiz: content['id_quiz'],
          image_quiz_content: content['image_quiz_content'],
          question_quiz_content: content['question_quiz_content'],
          answer_quiz_content: content['answer_quiz_content']));
    }
    q.add(ModelQuiz(id_quiz: quiz['id_quiz'],
        name_quiz: quiz['name_quiz'],
        image_quiz: quiz['image_quiz'],
        category_name: quiz['category_name'],
        category_id: quiz['category_id'],
        status_quiz: quiz['status_quiz'],
        content: mqc));
  }
  return q;
}