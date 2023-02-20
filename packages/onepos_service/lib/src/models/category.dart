class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? parentId;

  CategoryModel(
      {required this.name, required this.id, this.description, this.parentId});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentId: json['parentId'],
      );
}
