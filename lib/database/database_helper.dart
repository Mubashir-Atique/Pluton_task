import 'package:flutter_task/model/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes(
        id INTEGER PRIMARY KEY,
        title TEXT,
        image TEXT,
        imageType TEXT,
        favorite INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertRecipe(Results recipe) async {
    Database db = await instance.database;
    return await db.insert('recipes', recipe.toJson());
  }

  Future<List<Results>> getRecipes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('recipes');
    return List.generate(maps.length, (i) {
      return Results(
        id: maps[i]['id'],
        title: maps[i]['title'],
        image: maps[i]['image'],
        imageType: maps[i]['imageType'],
        favorite: maps[i]['favorite'],
      );
    });
  }

  Future<List<Results>> removeFromFavorites(int id) async {
    print('Removing recipe with ID: $id');
    try {
      Database db = await instance.database;
      await db.rawDelete('''
      DELETE FROM recipes
      WHERE id = ?
    ''', [id]);
      List<Results> recipes = await getRecipes();
      return recipes;
    } catch (e) {
      return [];
    }
  }

  Future<bool> isRecipeExists(int recipeId) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) FROM recipes WHERE id = ?',
      [recipeId],
    );
    int count = Sqflite.firstIntValue(result)!;
    return count > 0;
  }
}
