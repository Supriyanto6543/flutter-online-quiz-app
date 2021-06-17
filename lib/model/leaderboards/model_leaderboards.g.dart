// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_leaderboards.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelLeaderBoards _$ModelLeaderBoardsFromJson(Map<String, dynamic> json) {
  return ModelLeaderBoards(
    id_user: json['id_user'] as String,
    name_user: json['name_user'] as String,
    photo_user: json['photo_user'] as String,
    score: json['score'] as String,
    badge: (json['badge'] as List<dynamic>)
        .map((e) => ModelLeaderBadge.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ModelLeaderBoardsToJson(ModelLeaderBoards instance) =>
    <String, dynamic>{
      'id_user': instance.id_user,
      'name_user': instance.name_user,
      'photo_user': instance.photo_user,
      'score': instance.score,
      'badge': instance.badge,
    };
