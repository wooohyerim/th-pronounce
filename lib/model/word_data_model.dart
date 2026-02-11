class WordDataModel {
  final String text, levelCategory;
  final int id;

  WordDataModel.fromJson(Map<String, dynamic> json)
    : text = json["text"],
      levelCategory = json["levelCategory"],
      id = json["id"];
}
