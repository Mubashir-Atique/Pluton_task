//  String apiKey = 'apiKey=a3738478ab5847d084c66e324f31dcda';
class ApiEndPoint {
  static String get baseUrl => "api.spoonacular.com";
  static String get searchRecipe => "/recipes/complexSearch";
  static String recipeDetail(String id) {
    return "recipes/$id/information";
  }
}
