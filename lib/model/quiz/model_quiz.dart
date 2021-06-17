import 'package:json_annotation/json_annotation.dart';
import 'package:online_quiz/model/quiz/model_quiz_content.dart';
part 'model_quiz.g.dart';

@JsonSerializable()
class ModelQuiz{
  String id_quiz;
  String name_quiz;
  String image_quiz;
  String category_name;
  String category_id;
  String status_quiz;
  List<ModelQuizContent> content;

  ModelQuiz({required this.id_quiz,
    required this.name_quiz,
    required this.image_quiz,
    required this.category_name,
    required this.category_id,
    required this.status_quiz,
    required this.content});

  factory ModelQuiz.fromJson(Map<String, dynamic> json) => _$ModelQuizFromJson(json);
  Map<String, dynamic> toJson() => _$ModelQuizToJson(this);
}