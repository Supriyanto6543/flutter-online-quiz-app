
import 'package:json_annotation/json_annotation.dart';
part 'model_category.g.dart';

@JsonSerializable()
class ModelCategory{
  String cat_id;
  String cat_name;
  String photo_cat;
  String cat_status;

  ModelCategory({required this.cat_id,
    required this.cat_name,
    required this.photo_cat,
    required this.cat_status});

  factory ModelCategory.fromJson (Map<String, dynamic> json) => _$ModelCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ModelCategoryToJson(this);
}