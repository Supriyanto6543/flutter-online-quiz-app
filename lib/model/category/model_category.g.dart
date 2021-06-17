// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelCategory _$ModelCategoryFromJson(Map<String, dynamic> json) {
  return ModelCategory(
    cat_id: json['cat_id'] as String,
    cat_name: json['cat_name'] as String,
    photo_cat: json['photo_cat'] as String,
    cat_status: json['cat_status'] as String,
  );
}

Map<String, dynamic> _$ModelCategoryToJson(ModelCategory instance) =>
    <String, dynamic>{
      'cat_id': instance.cat_id,
      'cat_name': instance.cat_name,
      'photo_cat': instance.photo_cat,
      'cat_status': instance.cat_status,
    };
