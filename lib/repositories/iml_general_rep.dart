import 'dart:convert';

import 'package:flutter_task/api/general_api.dart';
import 'package:flutter_task/repositories/general_rep.dart';

class GeneralRepositoryImp extends GeneralRepository {
  @override
  Future<Map<String, dynamic>> searchRecipe(String query) async {
    try {
      final response = await GeneralApi.searchRecipe(query).request();
      final result = json.decode(response);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> recipeDetail(String id) async {
    try {
      final response = await GeneralApi.recipeDetail(id).request();
      final result = json.decode(response);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
