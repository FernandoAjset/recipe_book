import '../../domain/datasources/recipe_datasource.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDatasource datasource;

  RecipeRepositoryImpl(this.datasource);

  @override
  Future<List<Recipe>> getRecipes() {
    return datasource.getRecipes();
  }
}