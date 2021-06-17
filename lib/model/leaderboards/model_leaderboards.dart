
import 'package:json_annotation/json_annotation.dart';
import 'package:online_quiz/model/leaderboards/model_leader_badge.dart';
part 'model_leaderboards.g.dart';

@JsonSerializable()
class ModelLeaderBoards{
  String id_user;
  String name_user;
  String photo_user;
  String score;
  List<ModelLeaderBadge> badge;

  ModelLeaderBoards({required this.id_user,
    required this.name_user,
    required this.photo_user,
    required this.score, required this.badge});

  factory ModelLeaderBoards.fromJson (Map<String, dynamic> json) => _$ModelLeaderBoardsFromJson(json);

  Map<String, dynamic> toJson() => _$ModelLeaderBoardsToJson(this);

}