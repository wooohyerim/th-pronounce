class WordData {
  final String text, category, difficulty;
  final int id;

  WordData.fromJson(Map<String, dynamic> json)
    : text = json["text"],
      category = json["category"],
      difficulty = json["difficulty"],
      id = json["id"];
}
