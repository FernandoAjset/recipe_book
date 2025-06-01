import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../datasources.dart';
import '../../../entities.dart';
import '../../../repositories.dart';

// Notifier
class RecipeNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  final RecipeRepository repository;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RecipeNotifier(this.repository) : super(const AsyncValue.loading()) {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      if (_isLoading) return; // Evita cargas múltiples
      _isLoading = true;
      state = const AsyncValue.loading(); // Establece el estado en loading
      await Future.delayed(const Duration(seconds: 3)); // Simular espera
      final recipes = await repository.getRecipes();
      state = AsyncValue.data(recipes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
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