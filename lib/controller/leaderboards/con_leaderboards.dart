import 'package:dio/dio.dart';
import 'package:online_quiz/model/leaderboards/model_leader_badge.dart';
import 'package:online_quiz/model/leaderboards/model_leaderboards.dart';
import '../api.dart';

Future<List<ModelLeaderBoards>> getLeaderBoards(List<ModelLeaderBoards> q) async{
  var request = await Dio().get(Api.baseUrl+Api.api+Api.leaderBoards);
  for(Map<String, dynamic> leaderBoards in request.data){
    List<ModelLeaderBadge> badge = [];

    for(Map<String, dynamic> badges in leaderBoards['badge']){
      badge.add(ModelLeaderBadge(
          badge_name: badges['badge_name'],
          badge_image: badges['badge_image']));
    }

    q.add(ModelLeaderBoards(
        id_user: leaderBoards['id_user'],
        name_user: leaderBoards['name_user'],
        photo_user: leaderBoards['photo_user'],
        score: leaderBoards['score'],
        badge: badge));

  }
  return q;
}