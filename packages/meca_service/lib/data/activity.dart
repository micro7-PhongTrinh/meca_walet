class Activity {
  final int id;
  final String content;
  final DateTime date;
  final int point;
  final String storeName;
  final String logoUrl;

  Activity(this.id, this.content, this.date, this.point, this.storeName,
      this.logoUrl);

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      json['id'],
      json['content'],
      DateTime.parse(json['date']),
      json['point'],
      json['storeName'],
      json['logoUrl'],
    );
  }
}
