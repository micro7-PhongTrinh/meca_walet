import 'store.dart';

class Event {
  final int id;
  final String name;
  final String imgUrl;
  final DateTime startTime;
  final DateTime endTime;
  final Store store;

  Event(this.id, this.name, this.imgUrl, this.startTime, this.endTime, this.store);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(json['id'], json['name'], json['imgUrl'],
        DateTime.parse(json['startTime']), DateTime.parse(json['endTime']), Store.fromJson(json['store']));
  }
}
