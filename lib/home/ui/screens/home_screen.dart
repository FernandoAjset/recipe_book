import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../forms.dart';
import '../../../providers.dart';
import '../../../recipe/domain/entities/recipe.dart';
import '../../../screen.dart';
import '../../../widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String searchQuery = '';

  Future<void> _showRecipeForm(BuildContext context, {Recipe? recipe}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9, // Set modal height to 90% of the screen
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RecipeDetailForm(
            recipe: recipe ??
                const Recipe(
                  recipeName: '',
                  authorName: '',
                  imageUrl: '',
                  time: '',
                  servings: 1,
                ),
            onSubmit: (updatedRecipe) {
              if (recipe == null) {
                // Add new recipe
                // ref.read(recipeProvider.notifier).addRecipe(updatedRecipe);
              } else {
                // Update existing recipe
                // ref.read(recipeProvider.notifier).updateRecipe(updatedRecipe);
              }
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipesState = ref.watch(recipeProvider);
    final theme = ref.watch(themeProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref.read(recipeProvider.notifier).loadRecipes();
                },
                child: recipesState.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      const Center(child: Text('Error loading recipes')),
                  data: (recipes) {
                    if (recipesState.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final filtered = recipes
                        .where((r) =>
                            r.recipeName.toLowerCase().contains(searchQuery))
                        .toList();
                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text('No recipes found'),
                      );
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetialScreen(recipe: filtered[index]),
                              ),
                            );
                          },
                          child: RecipeCard(recipe: filtered[index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          _showRecipeForm(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
