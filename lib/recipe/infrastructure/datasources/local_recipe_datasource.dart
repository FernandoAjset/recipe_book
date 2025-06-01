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
        "servings": 3,
        "description": "Ingredients:\\n- 200g spaghetti\\n- 100g minced beef\\n- 1 onion, chopped\\n- 2 garlic cloves, minced\\n- 400g canned tomatoes\\n- Salt and pepper to taste\\n\\nInstructions:\\n1. Cook the spaghetti according to package instructions.\\n2. In a pan, sauté onion and garlic until fragrant.\\n3. Add minced beef and cook until browned.\\n4. Add canned tomatoes, salt, and pepper. Simmer for 10 minutes.\\n5. Serve the sauce over the spaghetti."
      },
      {
        "recipeName": "Chicken Curry",
        "authorName": "Chef Jane Smith",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "15 mins",
        "servings": 2,
        "description": "Ingredients:\\n- 200g chicken breast, diced\\n- 1 onion, chopped\\n- 2 garlic cloves, minced\\n- 1 tbsp curry powder\\n- 200ml coconut milk\\n- Salt to taste\\n\\nInstructions:\\n1. In a pan, sauté onion and garlic until fragrant.\\n2. Add chicken and cook until browned.\\n3. Add curry powder and stir well.\\n4. Pour in coconut milk and simmer for 10 minutes.\\n5. Serve with rice."
      },
      {
        "recipeName": "Avocado Toast",
        "authorName": "Chef Emily Clark",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "10 mins",
        "servings": 1,
        "description": "Ingredients:\\n- 1 slice of bread\\n- 1 avocado\\n- Salt and pepper to taste\\n\\nInstructions:\\n1. Toast the bread.\\n2. Mash the avocado and spread it on the toast.\\n3. Sprinkle with salt and pepper."
      },
      {
        "recipeName": "Beef Tacos",
        "authorName": "Chef Carlos Ruiz",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "25 mins",
        "servings": 4,
        "description": "Ingredients:\\n- 200g minced beef\\n- 1 onion, chopped\\n- 1 packet taco seasoning\\n- 8 taco shells\\n- Lettuce, tomato, and cheese for topping\\n\\nInstructions:\\n1. In a pan, sauté onion until fragrant.\\n2. Add minced beef and cook until browned.\\n3. Add taco seasoning and stir well.\\n4. Fill taco shells with beef mixture and top with lettuce, tomato, and cheese."
      },
      {
        "recipeName": "Vegan Buddha Bowl",
        "authorName": "Chef Lisa Wong",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "30 mins",
        "servings": 2,
        "description": "Ingredients:\\n- 1 cup quinoa\\n- 1 cup chickpeas\\n- 1 avocado\\n- 1 cup mixed greens\\n- 1 tbsp olive oil\\n- Lemon juice to taste\\n\\nInstructions:\\n1. Cook quinoa according to package instructions.\\n2. Arrange quinoa, chickpeas, avocado, and mixed greens in a bowl.\\n3. Drizzle with olive oil and lemon juice."
      },
      {
        "recipeName": "Classic Burger",
        "authorName": "Chef Mike Johnson",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "20 mins",
        "servings": 2,
        "description": "Ingredients:\\n- 200g ground beef\\n- 2 burger buns\\n- Lettuce, tomato, and cheese\\n- Ketchup and mustard\\n\\nInstructions:\\n1. Shape ground beef into patties and cook in a pan until done.\\n2. Toast burger buns.\\n3. Assemble burgers with lettuce, tomato, cheese, ketchup, and mustard."
      },
      {
        "recipeName": "Pancake Stack",
        "authorName": "Chef Anna Lopez",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "15 mins",
        "servings": 3,
        "description": "Ingredients:\\n- 1 cup flour\\n- 1 cup milk\\n- 1 egg\\n- 1 tbsp sugar\\n- Butter for cooking\\n\\nInstructions:\\n1. Mix flour, milk, egg, and sugar to form a batter.\\n2. Heat a pan and melt butter.\\n3. Pour batter into the pan and cook pancakes until golden brown."
      },
      {
        "recipeName": "Grilled Salmon",
        "authorName": "Chef Samuel Kim",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "25 mins",
        "servings": 2,
        "description": "Ingredients:\\n- 2 salmon fillets\\n- 1 tbsp olive oil\\n- Salt and pepper to taste\\n\\nInstructions:\\n1. Preheat grill to medium heat.\\n2. Brush salmon with olive oil and season with salt and pepper.\\n3. Grill salmon for 10-12 minutes."
      },
      {
        "recipeName": "Tomato Basil Pasta",
        "authorName": "Chef Monica Bellucci",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "20 mins",
        "servings": 2,
        "description": "Ingredients:\\n- 200g pasta\\n- 2 tomatoes, chopped\\n- 1 garlic clove, minced\\n- Fresh basil leaves\\n- Olive oil\\n\\nInstructions:\\n1. Cook pasta according to package instructions.\\n2. In a pan, sauté garlic and tomatoes in olive oil.\\n3. Toss pasta with tomato mixture and garnish with basil."
      },
      {
        "recipeName": "Chocolate Cake",
        "authorName": "Chef David Brown",
        "imageUrl": "https://images.unsplash.com/photo-1551218808-94e220e084d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "time": "50 mins",
        "servings": 6,
        "description": "Ingredients:\\n- 1 cup flour\\n- 1 cup sugar\\n- 1/2 cup cocoa powder\\n- 1 tsp baking powder\\n- 1/2 cup milk\\n- 2 eggs\\n\\nInstructions:\\n1. Preheat oven to 180°C.\\n2. Mix flour, sugar, cocoa powder, and baking powder.\\n3. Add milk and eggs, and mix until smooth.\\n4. Pour batter into a greased cake pan and bake for 40 minutes."
      }
    ]
    ''';

    final List<dynamic> decodedData = json.decode(jsonString);
    return decodedData.map((item) => Recipe.fromJson(item)).toList();
  }
}