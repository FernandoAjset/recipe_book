import 'package:flutter/material.dart';

import '../../../entities.dart';

class RecipeDetialScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetialScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.white,
          ),
          title: Center(
              child: Text(recipe.recipeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ))),
        ),
        body: Center(
          child: Text(
            'Recipe Detail Screen',
            style: Theme.of(context).textTheme.headline4,
          ),
        ));
  }
}