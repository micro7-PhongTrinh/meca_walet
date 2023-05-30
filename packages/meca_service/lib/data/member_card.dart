import 'package:meca_service/data/store.dart';

class MemberCard {
  final int id;
  final String name;
  final String imgUrl;
  final DateTime openDate;
  final Store store;

  MemberCard(this.id, this.name, this.imgUrl, this.openDate, this.store);

  factory MemberCard.fromJson(Map<String, dynamic> json) {
    return MemberCard(json['id'], json['name'], json['imgUrl'],
        DateTime.parse(json['openDate']), Store.fromJson(json['store']));
  }
}
