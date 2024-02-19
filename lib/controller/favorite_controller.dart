import 'package:flutter_task/controller/search_recipe_controller.dart';
import 'package:flutter_task/database/database_helper.dart';
import 'package:flutter_task/model/recipe_model.dart';
import 'package:flutter_task/utils/common.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  List<Results> favRecipes = [];

  getFavRecipe() async {
    favRecipes = await DatabaseHelper.instance.getRecipes();
    update();
  }

  removeFavorte(String id) async {
    if (await DatabaseHelper.instance
        .isRecipeExists(int.parse(id.toString()))) {
      favRecipes =
          await DatabaseHelper.instance.removeFromFavorites(int.parse(id));
      Common.showToast("Recipe removed!");
      update();
    }
  }

  @override
  void onClose() {
    Get.find<SearchRecipeController>().getFavRecipe();
    super.onClose();
  }
}
