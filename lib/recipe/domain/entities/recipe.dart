class Recipe {
  final String recipeName;
  final String authorName;
  final String imageUrl;
  final String time;
  final int servings;

  const Recipe({
    required this.recipeName,
    required this.authorName,
    required this.imageUrl,
    required this.time,
    required this.servings,
  });

  Recipe copyWith({
    String? recipeName,
    String? authorName,
    String? imageUrl,
    String? time,
    int? servings,
  }) {
    return Recipe(
      recipeName: recipeName ?? this.recipeName,
      authorName: authorName ?? this.authorName,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
      servings: servings ?? this.servings,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeName: json['recipeName'] ?? '',
      authorName: json['authorName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      time: json['time'] ?? '',
      servings: json['servings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeName': recipeName,
      'authorName': authorName,
      'imageUrl': imageUrl,
      'time': time,
      'servings': servings,
    };
  }
}