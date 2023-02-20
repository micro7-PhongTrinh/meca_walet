class CreateCategoryParam {
  final String name;
  final String? description;
  final String? parentId;

  CreateCategoryParam({required this.name, this.description, this.parentId});
}
