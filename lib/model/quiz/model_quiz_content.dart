
import 'package:json_annotation/json_annotation.dart';
part 'model_quiz_content.g.dart';

@JsonSerializable()
class ModelQuizContent{
  String id_quiz_content;
  String id_quiz;
  String image_quiz_content;
  String question_quiz_content;
  String answer_quiz_content;

  ModelQuizContent({required this.id_quiz_content,
    required this.id_quiz,
    required this.image_quiz_content,
    required this.question_quiz_content,
    required this.answer_quiz_content});

  factory ModelQuizContent.fromJson (Map<String, dynamic> json) => _$ModelQuizContentFromJson(json);
  Map<String, dynamic> toJson() => _$ModelQuizContentToJson(this);
}