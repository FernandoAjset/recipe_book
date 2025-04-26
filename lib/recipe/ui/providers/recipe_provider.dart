import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../datasources.dart';
import '../../../entities.dart';
import '../../../repositories.dart';

// Notifier
class RecipeNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  final RecipeRepository repository;

  RecipeNotifier(this.repository) : super(const AsyncValue.loading()) {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      final recipes = await repository.getRecipes();
      state = AsyncValue.data(recipes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// Provider
final recipeProvider =
    StateNotifierProvider<RecipeNotifier, AsyncValue<List<Recipe>>>(
  (ref) {
    final datasource = LocalRecipeDatasource();
    final repository = RecipeRepositoryImpl(datasource);
    return RecipeNotifier(repository);
  },
);