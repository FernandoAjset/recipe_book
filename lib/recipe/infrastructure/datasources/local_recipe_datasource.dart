import 'dart:convert';

import '../../domain/datasources/recipe_datasource.dart';
import '../../domain/entities/recipe.dart';

class LocalRecipeDatasource implements RecipeDatasource {
  @override
  Future<List<Recipe>> getRecipes() async {
    const jsonString = '''
    [
      {
        "recipeName": "Spaghetti Bolognese",
        "authorName": "Chef John Doe",
        "imageUrl": "https://images.unsplash.com/photo-1589927986089-358123789b0c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDF8fHNwYWdldHRpJTIwYm9sb25lc3xlbnwwfHx8fDE2ODQ5NTY1MjE&ixlib=rb-4.0.3&q=80&w=400"
      },
      {
        "recipeName": "Chicken Curry",
        "authorName": "Chef Jane Smith",
        "imageUrl": "https://images.unsplash.com/photo-1603052875000-4c8f3b1e2a5d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fGNoaWNrZW4lMjBjdXJyeXxlbnwwfHx8fDE2ODQ5NTY1MjE&ixlib=rb-4.0.3&q=80&w=400"
      }
    ]
    ''';

    final List<dynamic> decodedData = json.decode(jsonString);

    return decodedData.map((item) => Recipe.fromJson(item)).toList();
  }
}