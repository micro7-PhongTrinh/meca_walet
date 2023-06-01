class Store {
  final int id;
  final String name;
  final String logoUrl;
  final List<String> imgUrl;
  final String location;
  final int memberNumber;

  Store(this.id, this.name, this.logoUrl, this.imgUrl, this.location,
      this.memberNumber);

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        json['id'],
        json['name'],
        json['logoUrl'],
        (json['imgUrl'] as List).map((e) => e.toString()).toList(),
        json['location'],
        json['memberNumber']);
  }
}
