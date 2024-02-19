import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_task/controller/recipe_controller.dart';
import 'package:get/get.dart';

class RecipeDetailsView extends GetView<RecipeDetailController> {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Detail'),
      ),
      body: GetBuilder<RecipeDetailController>(
          init: RecipeDetailController(),
          initState: (_) {
            if (Get.arguments['id'] != null) {
              controller.getRecipeDetail(Get.arguments['id'].toString());
            }
          },
          builder: (_) {
            return controller.recipeDetailModel.title == null
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      duration: Duration(milliseconds: 1000),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              controller.recipeDetailModel.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        controller.recipeDetailModel.title.toString(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Ingredients:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller
                            .recipeDetailModel.extendedIngredients!
                            .map((ingredient) =>
                                Text('• ${ingredient.originalName.toString()}'))
                            .toList(),
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Instructions:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller
                            .recipeDetailModel.analyzedInstructions![0].steps!
                            .asMap()
                            .entries
                            .map(
                              (entry) => ListTile(
                                title: Text(
                                  'Step ${entry.key + 1}: ${entry.value.step}',
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
          }),
    );
  }
}
