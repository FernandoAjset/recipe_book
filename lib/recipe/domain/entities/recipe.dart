class Recipe {
  final String recipeName;
  final String authorName;
  final String imageUrl;

  const Recipe({
    required this.recipeName,
    required this.authorName,
    required this.imageUrl,
  });

  Recipe copyWith({
    String? recipeName,
    String? authorName,
    String? imageUrl,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      authorName: authorName ?? this.authorName,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeName: json['recipeName'] ?? '',
      authorName: json['authorName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeName': recipeName,
      'authorName': authorName,
      'imageUrl': imageUrl,
    };
  }
}