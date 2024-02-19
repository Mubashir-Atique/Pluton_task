import 'package:flutter_task/controller/recipe_controller.dart';
import 'package:get/get.dart';

class RecipeDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipeDetailController());
  }
}
