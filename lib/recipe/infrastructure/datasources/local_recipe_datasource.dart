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
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "20 mins",
        "servings": 3
      },
      {
        "recipeName": "Chicken Curry",
        "authorName": "Chef Jane Smith",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "15 mins",
        "servings": 2
      },
      {
        "recipeName": "Avocado Toast",
        "authorName": "Chef Emily Clark",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "10 mins",
        "servings": 1
      },
      {
        "recipeName": "Beef Tacos",
        "authorName": "Chef Carlos Ruiz",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "25 mins",
        "servings": 4
      },
      {
        "recipeName": "Vegan Buddha Bowl",
        "authorName": "Chef Lisa Wong",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "30 mins",
        "servings": 2
      },
      {
        "recipeName": "Classic Burger",
        "authorName": "Chef Mike Johnson",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "20 mins",
        "servings": 2
      },
      {
        "recipeName": "Pancake Stack",
        "authorName": "Chef Anna Lopez",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "15 mins",
        "servings": 3
      },
      {
        "recipeName": "Grilled Salmon",
        "authorName": "Chef Samuel Kim",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "25 mins",
        "servings": 2
      },
      {
        "recipeName": "Tomato Basil Pasta",
        "authorName": "Chef Monica Bellucci",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "20 mins",
        "servings": 2
      },
      {
        "recipeName": "Chocolate Cake",
        "authorName": "Chef David Brown",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "50 mins",
        "servings": 6
      }
    ]
    ''';

    final List<dynamic> decodedData = json.decode(jsonString);
    return decodedData.map((item) => Recipe.fromJson(item)).toList();
  }
}