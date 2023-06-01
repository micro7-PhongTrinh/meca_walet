import 'store.dart';

class Product {
  final int id;
  final String name;
  final String imgUrl;
  final int price;
  final Store store;

  Product(this.id, this.name, this.imgUrl, this.price, this.store);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['name'], json['imgUrl'], json['price'],
        Store.fromJson(json['store']));
  }
}
