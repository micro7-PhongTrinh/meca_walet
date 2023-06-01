import 'package:meca_service/data/member_card.dart';

class DetailMemberCard {
  final int id;
  final int point;
  final DateTime openDate;
  final MemberCard card;

  DetailMemberCard(this.id, this.point, this.openDate, this.card);

  factory DetailMemberCard.fromJson(Map<String, dynamic> json) {
    return DetailMemberCard(
        json['id'],
        json['point'],
        DateTime.parse(json['openDate']),
        MemberCard.fromJson(json['member_card']));
  }
}
