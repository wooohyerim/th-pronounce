class WordDataModel {
  final String text, category, difficulty;
  final int id;

  WordDataModel.fromJson(Map<String, dynamic> json)
    : text = json["text"],
      category = json["category"],
      difficulty = json["difficulty"],
      id = json["id"];
}
