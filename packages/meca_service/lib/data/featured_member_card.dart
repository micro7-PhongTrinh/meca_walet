import 'package:meca_service/data/member_card.dart';

class FeaturedMemberCard {
  final int total;
  final List<MemberCard> cards;

  FeaturedMemberCard(this.total, this.cards);

  factory FeaturedMemberCard.fromJson(Map<String, dynamic> json) {
    List<dynamic> cards = json['data'];
    return FeaturedMemberCard(
        json['total'], cards.map((e) => MemberCard.fromJson(e)).toList());
  }
}
