import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CustomSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        height: 55,
        child: TextField(
          onChanged: onChanged,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Search any recipe',
            hintStyle: TextStyle(color: theme.hintColor),
            prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.primaryColor.withOpacity(0.5),
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.primaryColor.withOpacity(0.4),
                width: 1.8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}