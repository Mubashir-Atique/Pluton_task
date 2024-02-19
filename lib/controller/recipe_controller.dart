import 'package:flutter_task/model/recipe_detail_model.dart';
import 'package:flutter_task/repositories/iml_general_rep.dart';
import 'package:flutter_task/utils/common.dart';
import 'package:flutter_task/utils/loading_dialog.dart';
import 'package:get/get.dart';

class RecipeDetailController extends GetxController {
  RecipeDetailModel recipeDetailModel = RecipeDetailModel();

  getRecipeDetail(String id) async {
    try {
      // LoadingDialog.show();
      final response = await GeneralRepositoryImp().recipeDetail(id);
      recipeDetailModel = RecipeDetailModel.fromJson(response);
      update();
      // LoadingDialog.hide();
    } catch (e) {
      Common.showToast("Something went wrong!");
      LoadingDialog.hide();
    }
  }
}
