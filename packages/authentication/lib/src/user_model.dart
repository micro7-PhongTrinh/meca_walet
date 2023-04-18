import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? name;
  final String? avatarUrl;
  final String? phone;
  final String? email;

  const UserModel({this.name, this.avatarUrl, this.phone, this.email});

  static const empty = UserModel();
  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [name, avatarUrl, phone, email];
}
