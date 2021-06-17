
import 'package:json_annotation/json_annotation.dart';
part 'model_leader_badge.g.dart';

@JsonSerializable()
class ModelLeaderBadge{
  String badge_name;
  String badge_image;

  ModelLeaderBadge({required this.badge_name, required this.badge_image});

  factory ModelLeaderBadge.fromJson (Map<String, dynamic> json) => _$ModelLeaderBadgeFromJson(json);

  Map<String, dynamic> toJson() => _$ModelLeaderBadgeToJson(this);
}