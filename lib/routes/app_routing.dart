import 'package:flutter_task/binding/favorites_binding.dart';
import 'package:flutter_task/binding/recipe_detail_binding.dart';
import 'package:flutter_task/binding/search_recipe_binding.dart';
import 'package:flutter_task/controller/favorite_controller.dart';
import 'package:flutter_task/routes/route_names.dart';
import 'package:flutter_task/view/favorites_view.dart';
import 'package:flutter_task/view/recipe_detail_view.dart';
import 'package:flutter_task/view/search_recipe_view.dart';
import 'package:get/get.dart';

class AppRouting {
  List<GetPage> routingList = [
    GetPage(
      name: RouteNames.searchView,
      page: () => const SearchRecipeView(),
      binding: SearchRecipeBinding(),
    ),
    GetPage(
      name: RouteNames.recipeDetailView,
      page: () => const RecipeDetailsView(),
      binding: RecipeDetailBinding(),
    ),
    GetPage(
      name: RouteNames.favoritesView,
      page: () => const FavoritesView(),
      binding: FavoritesBinding(),
    ),
  ];
}
