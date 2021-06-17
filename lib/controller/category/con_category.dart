import 'package:dio/dio.dart';
import 'package:online_quiz/model/category/model_category.dart';

import '../api.dart';

Future<List<ModelCategory>> getCategories(List<ModelCategory> q) async{
  var request = await Dio().get(Api.baseUrl+Api.api+Api.category);
  for(Map<String, dynamic> category in request.data){
    q.add(ModelCategory(
        cat_id: category['cat_id'],
        cat_name: category['cat_name'],
        photo_cat: category['photo_cat'],
        cat_status: category['cat_status']));
  }
  return q;
}