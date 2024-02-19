import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_task/database/database_helper.dart';
import 'package:flutter_task/model/recipe_model.dart';
import 'package:flutter_task/repositories/iml_general_rep.dart';
import 'package:flutter_task/utils/common.dart';
import 'package:flutter_task/utils/loading_dialog.dart';
import 'package:get/get.dart';

class SearchRecipeController extends GetxController {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  List<Results> filteredRecipes = [];
  List<Results> favRecipes = [];

  get searchController => _searchController;

  filterRecipes(String query) {
    filteredRecipes.clear();
    try {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

      _debounceTimer = Timer(Duration(milliseconds: 500), () async {
        var res = await getRecipes(query);
        if (res != null) {
          RecipeModel recipeModel = RecipeModel.fromJson(res);
          if (recipeModel.results != null) {
            filteredRecipes.addAll(recipeModel.results!.toList());
            for (var filterRecipe in filteredRecipes) {
              for (var recipe in favRecipes) {
                if (recipe.id == filterRecipe.id) {
                  filterRecipe.favorite = 1;
                }
              }
            }
            update();
          }
        }
      });
    } catch (e) {
      Common.showToast("Something went wrong!");
    }

    update();
  }

  getRecipes(String query) async {
    LoadingDialog.show();

    try {
      final response = await GeneralRepositoryImp().searchRecipe(query);
      LoadingDialog.hide();

      return response;
    } catch (e) {
      Common.showToast("Something went wrong!");
      LoadingDialog.hide();
    }
  }

  addFavrorite(int index, Results recipe) async {
    if (await DatabaseHelper.instance
        .isRecipeExists(int.parse(recipe.id.toString()))) {
      filteredRecipes[index].favorite = 0;
      favRecipes = await DatabaseHelper.instance
          .removeFromFavorites(int.parse(recipe.id.toString()));
      Common.showToast("removed from favorites");
    } else {
      filteredRecipes[index].favorite = 1;
      await DatabaseHelper.instance.insertRecipe(recipe);
      Common.showToast("Added in favorites");
    }
    update();
  }

  getFavRecipe() async {
    favRecipes = await DatabaseHelper.instance.getRecipes();
    update();
  }

  @override
  void onInit() {
    getFavRecipe();
    super.onInit();
  }
}
