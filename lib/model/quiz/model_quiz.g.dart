// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelQuiz _$ModelQuizFromJson(Map<String, dynamic> json) {
  return ModelQuiz(
    id_quiz: json['id_quiz'] as String,
    name_quiz: json['name_quiz'] as String,
    image_quiz: json['image_quiz'] as String,
    category_name: json['category_name'] as String,
    category_id: json['category_id'] as String,
    status_quiz: json['status_quiz'] as String,
    content: (json['content'] as List<dynamic>)
        .map((e) => ModelQuizContent.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ModelQuizToJson(ModelQuiz instance) => <String, dynamic>{
      'id_quiz': instance.id_quiz,
      'name_quiz': instance.name_quiz,
      'image_quiz': instance.image_quiz,
      'category_name': instance.category_name,
      'category_id': instance.category_id,
      'status_quiz': instance.status_quiz,
      'content': instance.content,
    };
