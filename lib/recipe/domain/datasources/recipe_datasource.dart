import '../entities/recipe.dart';

abstract class RecipeDatasource {
  Future<List<Recipe>> getRecipes();
}
