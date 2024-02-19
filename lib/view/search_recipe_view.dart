import 'package:flutter/material.dart';
import 'package:flutter_task/controller/search_recipe_controller.dart';
import 'package:flutter_task/routes/route_names.dart';
import 'package:flutter_task/utils/common.dart';
import 'package:get/get.dart';

class SearchRecipeView extends GetView<SearchRecipeController> {
  const SearchRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Searching'),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(RouteNames.favoritesView),
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: GetBuilder<SearchRecipeController>(
          init: SearchRecipeController(),
          builder: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.blue,
                        ),
                        errorBorder: Common.customOutlineBorder,
                        enabledBorder: Common.customOutlineBorder,
                        focusedBorder: Common.customOutlineBorder,
                        disabledBorder: Common.customOutlineBorder,
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3),
                        hintText: 'Search recipe here',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14)),
                    onChanged: controller.filterRecipes,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.filteredRecipes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.withOpacity(0.1)),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                controller.filteredRecipes[index].image
                                    .toString(),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  controller.addFavrorite(
                                      index, controller.filteredRecipes[index]);
                                },
                                icon: Icon(controller
                                            .filteredRecipes[index].favorite ==
                                        1
                                    ? Icons.favorite
                                    : Icons.favorite_border)),
                            title: Text(
                              controller.filteredRecipes[index].title
                                  .toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              Get.toNamed(RouteNames.recipeDetailView,
                                  arguments: {
                                    'id': controller.filteredRecipes[index].id
                                        .toString()
                                  });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}
