class BrandSearchModel {
  final String? id;
  final DateTime? createdAt;
  final String? name;
  final String? arabicName;

  BrandSearchModel({this.id, this.createdAt, this.name, this.arabicName});

  factory BrandSearchModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return BrandSearchModel();
    return BrandSearchModel(
      id: json["id"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      arabicName: json["arabic_name"],
    );
  }

  static List<BrandSearchModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => BrandSearchModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return this.createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(BrandSearchModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => name!;
}
