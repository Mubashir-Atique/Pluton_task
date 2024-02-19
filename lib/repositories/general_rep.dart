abstract class GeneralRepository {
  Future<Map<String, dynamic>> searchRecipe(String query);
  Future<Map<String, dynamic>> recipeDetail(String id);
}
