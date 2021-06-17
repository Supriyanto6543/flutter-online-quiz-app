// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_quiz_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelQuizContent _$ModelQuizContentFromJson(Map<String, dynamic> json) {
  return ModelQuizContent(
    id_quiz_content: json['id_quiz_content'] as String,
    id_quiz: json['id_quiz'] as String,
    image_quiz_content: json['image_quiz_content'] as String,
    question_quiz_content: json['question_quiz_content'] as String,
    answer_quiz_content: json['answer_quiz_content'] as String,
  );
}

Map<String, dynamic> _$ModelQuizContentToJson(ModelQuizContent instance) =>
    <String, dynamic>{
      'id_quiz_content': instance.id_quiz_content,
      'id_quiz': instance.id_quiz,
      'image_quiz_content': instance.image_quiz_content,
      'question_quiz_content': instance.question_quiz_content,
      'answer_quiz_content': instance.answer_quiz_content,
    };
