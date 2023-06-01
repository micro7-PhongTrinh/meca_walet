import 'detail_member_card.dart';

class FeaturedMemberCard {
  final int total;
  final List<DetailMemberCard> cards;

  FeaturedMemberCard(this.total, this.cards);

  factory FeaturedMemberCard.fromJson(Map<String, dynamic> json) {
    List<dynamic> cards = json['data'];
    return FeaturedMemberCard(
        json['total'], cards.map((e) => DetailMemberCard.fromJson(e)).toList());
  }
}
