import 'package:flutter/material.dart';

import '../../domain/entities/recipe.dart';
import '../../../widgets.dart';

class RecipeDetailForm extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe)? onSubmit;

  const RecipeDetailForm({
    super.key,
    required this.recipe,
    this.onSubmit,
  });

  @override
  State<RecipeDetailForm> createState() => _RecipeDetailFormState();
}

class _RecipeDetailFormState extends State<RecipeDetailForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController recipeNameController;
  late TextEditingController authorNameController;
  late TextEditingController timeController;
  late TextEditingController servingsController;
  late TextEditingController descriptionController;
  late Recipe updatedRecipe;

  @override
  void initState() {
    super.initState();
    updatedRecipe = widget.recipe;
    recipeNameController =
        TextEditingController(text: widget.recipe.recipeName);
    authorNameController =
        TextEditingController(text: widget.recipe.authorName);
    timeController = TextEditingController(text: widget.recipe.time);
    servingsController =
        TextEditingController(text: widget.recipe.servings.toString());
    descriptionController =
        TextEditingController(text: widget.recipe.description);
  }

  @override
  void dispose() {
    recipeNameController.dispose();
    authorNameController.dispose();
    timeController.dispose();
    servingsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.recipe.recipeName.isNotEmpty &&
        widget.recipe.authorName.isNotEmpty &&
        widget.recipe.time.isNotEmpty &&
        widget.recipe.servings > 0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); 
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      isEditing ? 'Edit Recipe' : 'Add Recipe',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Recipe Name',
                  controller: recipeNameController,
                  hint: 'Enter recipe name',
                  onChanged: (value) =>
                      updatedRecipe = updatedRecipe.copyWith(recipeName: value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipe name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Author Name',
                  controller: authorNameController,
                  hint: 'Enter author name',
                  onChanged: (value) =>
                      updatedRecipe = updatedRecipe.copyWith(authorName: value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter author name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ImageInput(
                  key: const ValueKey('image_input'),
                  initialUrl: widget.recipe.imageUrl,
                  onUrlChanged: (url) =>
                      updatedRecipe = updatedRecipe.copyWith(imageUrl: url),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Preparation Time',
                  controller: timeController,
                  hint: 'Enter preparation time',
                  onChanged: (value) =>
                      updatedRecipe = updatedRecipe.copyWith(time: value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter preparation time';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Servings',
                  controller: servingsController,
                  hint: 'Enter servings',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => updatedRecipe = updatedRecipe.copyWith(
                      servings: int.tryParse(value) ?? widget.recipe.servings),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter servings';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Description',
                  controller: descriptionController,
                  hint: 'Enter description',
                  onChanged: (value) => updatedRecipe =
                      updatedRecipe.copyWith(description: value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit?.call(updatedRecipe);
                    }
                  },
                  child: const Text(
                    'Save recipe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required Function(String) onChanged,
    required String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16,
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1),
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
    );
  }
}
