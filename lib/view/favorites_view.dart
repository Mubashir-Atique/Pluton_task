import 'package:flutter/material.dart';
import 'package:flutter_task/controller/favorite_controller.dart';
import 'package:flutter_task/routes/route_names.dart';
import 'package:get/get.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GetBuilder<FavoritesController>(
          init: FavoritesController(),
          initState: (_) {
            controller.getFavRecipe();
          },
          builder: (_) {
            return controller.favRecipes.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.all(12.0),
                    itemCount: controller.favRecipes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(
                          controller.favRecipes[index].image.toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title:
                            Text(controller.favRecipes[index].title.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              controller.removeFavorte(
                                  controller.favRecipes[index].id.toString());
                            },
                            icon: Icon(Icons.favorite)),
                        onTap: () {
                          Get.toNamed(RouteNames.recipeDetailView, arguments: {
                            'id': controller.favRecipes[index].id.toString()
                          });
                        },
                      );
                    },
                  )
                : Center(
                    child: Text("No favorite recipe"),
                  );
          }),
    );
  }
}
